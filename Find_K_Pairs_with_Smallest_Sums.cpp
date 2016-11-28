/*373. Find K Pairs with Smallest Sums   QuestionEditorial Solution  My Submissions
Total Accepted: 13835 Total Submissions: 48405 Difficulty: Medium Contributors: Admin
You are given two integer arrays nums1 and nums2 sorted in ascending order and an integer k.

Define a pair (u,v) which consists of one element from the first array and one element from the second array.

Find the k pairs (u1,v1),(u2,v2) ...(uk,vk) with the smallest sums.

Example 1:
Given nums1 = [1,7,11], nums2 = [2,4,6],  k = 3

Return: [1,2],[1,4],[1,6]

The first 3 pairs are returned from the sequence:
[1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]
Example 2:
Given nums1 = [1,1,2], nums2 = [1,2,3],  k = 2

Return: [1,1],[1,1]

The first 2 pairs are returned from the sequence:
[1,1],[1,1],[1,2],[2,1],[1,2],[2,2],[1,3],[1,3],[2,3]
Example 3:
Given nums1 = [1,2], nums2 = [3],  k = 3 

Return: [1,3],[2,3]

All possible pairs are returned from the sequence:
[1,3],[2,3]
Credits:
Special thanks to @elmirap and @StefanPochmann for adding this problem and creating all test cases.

Hide Company Tags Google Uber
Hide Tags Heap
Hide Similar Problems (M) Kth Smallest Element in a Sorted Matrix
*/



/* O(k log(k))
priority queue   heap
first, take the first k elements of nums1 and paired with nums2[0]
so that we have (0,0), (1,0), (2,0),.....(k-1,0) in the heap
each time after we pick the pair with min sum. 
put the new pair with the second index +1

build a Ele struct
	int[] pair --- the first one is nums1, the second is nums2 number
	int n2idx --- current index to nums2
	long sum --- store the 
use priority queue to implement this*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<pair<int, int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        vector<pair<int, int>> ret;
        if(nums1.size()==0 || nums2.size()==0) return ret;
        
        auto comp = [&nums1, &nums2](pair<int, int> a, pair<int, int> b) {
            return nums1[a.first] + nums2[a.second] > nums1[b.first] + nums2[b.second];};
        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(comp)> min_heap(comp);
        min_heap.emplace(0, 0);
        while(k-- > 0 && min_heap.size())
        {
            auto idx_pair = min_heap.top(); min_heap.pop();
            ret.emplace_back(nums1[idx_pair.first], nums2[idx_pair.second]);
            if (idx_pair.first + 1 < nums1.size())
                min_heap.emplace(idx_pair.first + 1, idx_pair.second);
            if (idx_pair.first == 0 && idx_pair.second + 1 < nums2.size())
                min_heap.emplace(idx_pair.first, idx_pair.second + 1);
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    class Ele{
        int[] p; //store nums1,nums2
        int n2idx; // index for nums2
        long sum; //nums1+nums2
        Ele(int n2idx, int n1, int n2){
            p = new int[]{n1,n2};
            this.n2idx = n2idx;
            this.sum = n1+n2;
        }
    }
    
    public List<int[]> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        List<int[]> ret = new ArrayList<>();
        if(nums1==null || nums2==null 
            || nums1.length==0 || nums2.length==0){
                return ret;
            }
        
        int len1 = nums1.length;
        int len2 = nums2.length;
        
        PriorityQueue<Ele> Q = new PriorityQueue<>(k, new Comparator<Ele>(){
            public int compare(Ele e1, Ele e2){
                return Long.compare(e1.sum, e2.sum);
            }
        });
        
        for(int i = 0; i < nums1.length && i < k; ++i){
            //remember i<k
            //only need the first k number in nums1
            Q.offer(new Ele(0, nums1[i], nums2[0]));
        }
        
        for(int i = 1; i<=k && !Q.isEmpty(); ++i){
            //get the first k sums
            Ele e = Q.poll();
            ret.add(e.p);
            if(e.n2idx < len2-1){
                //get to next value in nums2
                int next = e.n2idx+1;
                Q.offer(new Ele(next, e.p[0], nums2[next]));
                //priority queue is already sorted the element for you
            }
        }
        
        return ret;
    }
}

