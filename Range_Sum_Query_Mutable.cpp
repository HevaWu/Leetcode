/*
Given an integer array nums, find the sum of the elements between indices i and j (i ≤ j), inclusive.

The update(i, val) function modifies nums by updating the element at index i to val.
Example:
Given nums = [1, 3, 5]

sumRange(0, 2) -> 9
update(1, 2)
sumRange(0, 2) -> 8
Note:
The array is only modifiable by the update function.
You may assume the number of calls to update and sumRange function is distributed evenly.
*/

class NumArray {
public:

    struct newArray
    {
        int sum;
        vector<int> val;
    };
    
    int arrayNum;
    int arraySize;
    vector<newArray> a1;
    
    NumArray(vector<int> &nums) {
        int nsize = nums.size();
        //arrayNum = (int)sqrt(nsize*2); 
        arrayNum = static_cast<int>(sqrt(nsize*2));  //remember * 2 //m
        arraySize = arrayNum/2; //k
        while(arraySize * arrayNum < nsize) ++arraySize; //only use < not <=
        
        a1.resize(arrayNum);
        for(int i = 0, k = 0; i < arrayNum; ++i)
        {
            int temp = 0;
            a1[i].val.resize(arraySize);
            for(int j = 0; j < arraySize && k < nsize; ++j, ++k)
            {
                temp += nums[k];
                a1[i].val[j] = nums[k];
            }
            a1[i].sum = temp;
        }
    }

    void update(int i, int val) {
        int x = i/arraySize;  //these two initialization are all using arraySize
        int y = i%arraySize;
        a1[x].sum += (val -a1[x].val[y]);  //a1[x].sum = a1[x].sum -a1[x].val[y] + val
        a1[x].val[y] = val;
    }

    int sumRange(int i, int j) {
        int x1 = i / arraySize;
        int y1 = i % arraySize;
        int x2 = j / arraySize;
        int y2 = j % arraySize;
        
        int sum = 0;
        if(x1 == x2)
        {
            for(int i = y1; i <= y2; ++i)
                sum += a1[x1].val[i];
            return sum;
        }
        
        for(int i = y1; i < arraySize; ++i)   //count the sum of x1 line
            sum += a1[x1].val[i];
        for(int i = x1 + 1; i < x2; ++i)  //count the sum of the line between x1 and x2
            sum += a1[i].sum;
        for(int i = 0; i <= y2; ++i)  //count the sum of the x2 line
            sum += a1[x2].val[i];
        
        return sum;
    }
    
};

/*
The idea is using “buckets”. Assume the length of the input array is n, we can partition the whole array into m buckets, with each bucket having k=n/m elements. For each bucket, we record two kind of information: 1) a copy of elements in the bucket, 2) the sum of all the elements in the bucket.

For example: If the input is [0,1,2,3,4,5,6,7,8,9], and we partition it into 4 buckets, formatted as {[numbers], sum}:

bucket0: {[0, 1, 2], 3}
bucket1: {[3, 4, 5], 12}
bucket2: {[6, 7, 8], 21}
bucket3: {[9], 9};
Updating is easy. You just need to find the right bucket, modify the element value, and change the “sum” value in that bucket accordingly. The operation takes O(1) time.

Summation is a little complicated. In the above example, let’s say we want to compute the sum in range [1, 7]. We can see, the numbers we want to accumulate are in bucket0, bucket1, and bucket2. Specifically, we only need parts of numbers in bucket0 and bucket2, and all the numbers in bucket1. Because the summation of all numbers in bucket1 have already been computed, we don’t need to compute it again. So, instead of doing (1+2) + (3+4+5) + (6+7), we can just do (1+2) + 12 + (6+7). We save two “+” operations. If you change the size of buckets, the number of saved “+” operations will be different. The questions is:

What is the best size that can save the most “+” operations?

Here is my analysis, which might be incorrect.

We have:

The number of buckets is m.
The size of each bucket is k.
The length of input array is n, and we have mk=n.
In the worst case (the query is [0, n-1]), we will first add all the elements in bucket0, then add from bucket1 to bucket(m-2), and finally add all the elements in bucket(m-1), so we do 2k+m-2 “+” operations. We want to find the minimum value of 2k+m. Because 2km=2n, when 2k=m, 2k+m reaches the minimum value. (Need proof?) So we have m = sqrt(2n) and k=sqrt(n/2).

Therefore, in the worst case, the best size of bucket is k=sqrt(n/2), and the complexity is O(2k+m-2)=O(2m-2)=O(m)=O(sqrt(2n))=O(n^0.5);
*/

// Your NumArray object will be instantiated and called as such:
// NumArray numArray(nums);
// numArray.sumRange(0, 1);
// numArray.update(1, 10);
// numArray.sumRange(1, 2);






/////////////////////////////////////////////////////////////////////////////
//java
public class NumArray {
    class SumTreeNode{
        int start, end;
        SumTreeNode left, right;
        int sum;
        
        public SumTreeNode(int start, int end){
            this.start = start;
            this.end = end;
            this.left = null;
            this.right = null;
            this.sum = 0;
        }
    }
    
    SumTreeNode root = null;
    
    private SumTreeNode buildTree(int[] nums, int start, int end){
        if(start>end)
            return null;
        else{
            SumTreeNode ret = new SumTreeNode(start, end);
            if(start == end)
                ret.sum = nums[start];
            else{
                int mid = start + (end-start)/2;
                ret.left = buildTree(nums, start, mid);
                ret.right = buildTree(nums, mid+1, end);
                ret.sum = ret.left.sum + ret.right.sum;
            }
            return ret;
        }
    } 

    public NumArray(int[] nums) {
        root = buildTree(nums, 0, nums.length-1);
    }
    
    void update(SumTreeNode root, int i, int val){
        if(root.start == root.end){
            root.sum = val;
        } else{
            int mid = (root.start+root.end)/2;
            if(i<=mid)
                update(root.left,i,val);
            else
                update(root.right,i,val);
            root.sum = root.left.sum + root.right.sum;
        }
    }
    
    void update(int i, int val) {
        update(root, i, val);
    }
    
    public int sumRange(SumTreeNode root, int start, int end){
        if(root.start == start && root.end == end){
            return root.sum;
        }else{
            int mid = (root.start+root.end)/2;
            if(end<=mid)
                return sumRange(root.left, start, end);
            else if(start>=mid+1)
                return sumRange(root.right, start, end);
            else
                return sumRange(root.left, start, mid)+sumRange(root.right, mid+1,end);
        }
    }

    public int sumRange(int i, int j) {
        return sumRange(root, i, j);
    }
}


// Your NumArray object will be instantiated and called as such:
// NumArray numArray = new NumArray(nums);
// numArray.sumRange(0, 1);
// numArray.update(1, 10);
// numArray.sumRange(1, 2);