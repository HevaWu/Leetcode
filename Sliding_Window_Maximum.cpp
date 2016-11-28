/*239. Sliding Window Maximum  QuestionEditorial Solution  My Submissions
Total Accepted: 38261 Total Submissions: 127240 Difficulty: Hard
Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

For example,
Given nums = [1,3,-1,-3,5,3,6,7], and k = 3.

Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
Therefore, return the max sliding window as [3,3,5,5,6,7].

Note: 
You may assume k is always valid, ie: 1 ≤ k ≤ input array's size for non-empty array.

Follow up:
Could you solve it in linear time?

Hint:

How about using a data structure such as deque (double-ended queue)?
The queue size need not be the same as the window’s size.
Remove redundant elements and the queue should store only elements that need to be considered.
Hide Company Tags Amazon Google Zenefits
Hide Tags Heap
Hide Similar Problems (H) Minimum Window Substring (E) Min Stack (H) Longest Substring with At Most Two Distinct Characters (H) Paint House II
*/



/*O(n) each element is put and polled once
use dequeue to do this
scan array from n to n-1
only consider number in [i-(k-1), i]
1. If an element in the deque and it is out of i-(k-1), we discard them. 
	We just need to poll from the head, as we are using a deque and elements are ordered as the sequence in the array
2. Now only those elements within [i-(k-1),i] are in the deque. We then discard elements smaller than a[i] from the tail. 
	This is because if a[x] <a[i] and x<i, then a[x] has no chance to be the "max" in [i-(k-1),i], or any other subsequent window: a[i] would always be a better candidate.
3. As a result elements in the deque are ordered in both sequence in array and their value. At each step the head of the deque is the max element in [i-(k-1),i]*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        if(nums.size()==0 || k<=0) return vector<int>(0);
        deque<int> dq; //store the index of nums
        vector<int> ret;
        for(int i = 0; i < nums.size(); ++i){
            while(!dq.empty() && dq.front()<i-k+1){
                //remove numbers out of range k
                dq.pop_front();
            }
            while(!dq.empty() && nums[dq.back()]<nums[i]){
                //remove the number in k range which is useless
                dq.pop_back();
            }
            dq.push_back(i);
            if(i>=k-1) {
                //each step, the head of deque is the maxelement in the range[i-(k-1),i]
                ret.push_back(nums[dq.front()]);  //remember nums[]
            }
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] maxSlidingWindow(int[] nums, int k) {
        if(nums.length==0 || k<=0) return new int[0]; //add 0
        int[] ret = new int[nums.length-k+1];
        int index = 0; // the index for ret
        Deque<Integer> dq = new ArrayDeque<>();
        for(int i = 0; i < nums.length; ++i){
            while(!dq.isEmpty() && dq.peek()<i-k+1){
                //remove the number out of range
                dq.poll();
            }
            while(!dq.isEmpty() && nums[dq.peekLast()]<nums[i]){
                //remove the element in the range but useless
                dq.pollLast();
            }
            dq.offer(i);
            if(i>=k-1){
                //each step, the head of the deque is the max element in the range
                ret[index++] = nums[dq.peek()];  //remember nums[]
            }
        }
        return ret;
    }
}
