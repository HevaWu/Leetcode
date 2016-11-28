/*315. Count of Smaller Numbers After Self  QuestionEditorial Solution  My Submissions
Total Accepted: 19793 Total Submissions: 60567 Difficulty: Hard
You are given an integer array nums and you have to return a new counts array. The counts array has the property where counts[i] is the number of smaller elements to the right of nums[i].

Example:

Given nums = [5, 2, 6, 1]

To the right of 5 there are 2 smaller elements (2 and 1).
To the right of 2 there is only 1 smaller element (1).
To the right of 6 there is 1 smaller element (1).
To the right of 1 there is 0 smaller element.
Return the array [2, 1, 1, 0].

Hide Company Tags Google
Hide Tags Divide and Conquer Binary Indexed Tree Segment Tree Binary Search Tree
Hide Similar Problems (H) Count of Range Sum (M) Queue Reconstruction by Height
*/



/*
build a tree node structure to store each element in nums
int sum --- store the total number of its left bottom side
int dup --- sotre how many duplication of this value node
Node left
Node right
int val
countSmaller --- start from the end of nums, since we need to find how many smaller elements at the right side of nums
insert(num, node, ret, i, preSum) --- 
    if node is null, insert a new node, and init ret[i]
    if node.val==num, this is a duplicate value, node.dup++
    if node.val>num, node.sum++, insert this num node to curnode.left child, and pass preSum as preSum + node.dup + node.sum
    else insert this num node to curnode.right node
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> countSmaller(vector<int>& nums) {
        vector<pair<int, int> > nnums(nums.size());
        for(int i = 0; i < nums.size(); i++){
            nnums[i].first = nums[i];  //the first is number
            nnums[i].second = i;      //the second is index
        }
        
        vector<int> smaller(nums.size(),0);
        nnums = sortSmaller(nnums, smaller);
        return smaller;
    }
    
    vector<pair<int, int> > sortSmaller(vector<pair<int, int> > nnums, vector<int> &smaller){
        if(nnums.size()<1)
            return nnums;
        int mid = nnums.size()/2;
        if(mid>0){
            vector<pair<int, int> > sleft(mid);
            vector<pair<int, int> > sright(nnums.size()-mid);
            for(int i = 0; i < sleft.size(); i++)
                sleft[i] = nnums[i];
            for(int i = 0; i < sright.size(); i++)
                sright[i] = nnums[mid+i];
            
            vector<pair<int, int> > sortLeft = sortSmaller(sleft, smaller);
            vector<pair<int, int> > sortRight = sortSmaller(sright, smaller);
            int llen = sortLeft.size(), rlen = sortRight.size(), i = 0, j = 0;
            while(i < llen || j < rlen){
                if(j==rlen || (i<llen && sortLeft[i].first<=sortRight[j].first)){
                    nnums[i+j] = sortLeft[i];
                    smaller[sortLeft[i].second] += j;
                    i++;
                } else{
                    nnums[i+j] = sortRight[j];
                    j++;
                }
            }
        }
        return nnums;
    }
};




////////////////////////////////////////////////////////////////////////////////////
//java
public class Solution {
    public class Node{
        Node left; 
        Node right;
        int val;
        int sum;  //count the total number of its left bottom side
        int dup = 1; //the duplication of this value node
        
        public Node(int v, int s){
            this.val = v;
            this.sum = s;
        }
    }
    
    public Node insert(int num, Node node, Integer[] ret, int i, int preSum){
        //insert node in node tree
        if(node==null){
            node = new Node(num, 0);
            ret[i] = preSum;
        } else if(node.val == num){
            node.dup++;
            ret[i] = preSum + node.sum;
        } else if(node.val > num){
            node.sum++;
            node.left = insert(num, node.left, ret, i, preSum);
        } else {
            node.right = insert(num, node.right, ret, i, preSum+node.dup+node.sum);
        }
        return node;
    }
    
    public List<Integer> countSmaller(int[] nums){
        Integer[] ret = new Integer[nums.length];
        Node root = null;
        for(int i = nums.length-1; i >= 0; --i){ //start from the end of the nums
            root = insert(nums[i], root, ret, i, 0);
        }
        return Arrays.asList(ret);
    }
}





public class Solution {
    class NumberIndex{
        private int number;
        private int index;
        
        public NumberIndex(int n1, int i1){
            this.number = n1;
            this.index = i1;
        }
        
        public NumberIndex(NumberIndex n2){
            this.number = n2.number;
            this.index = n2.index;
        }
    }
    
    public List<Integer> countSmaller(int[] nums) {
        List<Integer> ret = new ArrayList<>();
        NumberIndex[] nnums = new NumberIndex[nums.length];
        for(int i = 0; i < nums.length; i++){
            nnums[i] = new NumberIndex(nums[i], i);
        }
        int[] smaller = new int[nums.length];  //use to store the count of smaller number after this index
        nnums = sortSmaller(nnums, smaller);
        for(int i : smaller){
            ret.add(i);
        }
        return ret;
    }
    
    public NumberIndex[] sortSmaller(NumberIndex[] nnums, int[] smaller){
        if(nnums.length < 1)
            return nnums;
        int mid = nnums.length/2;
        if(mid>0){
            NumberIndex[] sleft = new NumberIndex[mid];
            NumberIndex[] sright = new NumberIndex[nnums.length - mid];
            for(int i = 0; i < sleft.length; i++){
                sleft[i] = nnums[i];
            }
            for(int i = 0; i < sright.length; i++){
                sright[i] = nnums[mid + i];
            }
            
            NumberIndex[] sortLeft = sortSmaller(sleft, smaller);
            NumberIndex[] sortRight = sortSmaller(sright, smaller);
            
            int llen = sortLeft.length, rlen = sortRight.length, i = 0, j = 0;
            while(i < llen || j < rlen){
                if(j==rlen || i<llen && sortLeft[i].number<=sortRight[j].number){
                    nnums[i+j] = sortLeft[i];
                    smaller[sortLeft[i].index] += j;
                    i++;
                } else{
                    nnums[i+j] = sortRight[j];
                    j++;
                }
            }
        }
        return nnums;
    }
}