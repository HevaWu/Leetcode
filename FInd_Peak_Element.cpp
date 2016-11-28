/*162. Find Peak Element  QuestionEditorial Solution  My Submissions
Total Accepted: 84303 Total Submissions: 241583 Difficulty: Medium
A peak element is an element that is greater than its neighbors.

Given an input array where num[i] ≠ num[i+1], find a peak element and return its index.

The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.

You may imagine that num[-1] = num[n] = -∞.

For example, in array [1, 2, 3, 1], 3 is a peak element and your function should return the index number 2.

click to show spoilers.
Note:
Your solution should be in logarithmic complexity.

Credits:
Special thanks to @ts for adding this problem and creating all test cases.

Hide Company Tags Microsoft Google
Hide Tags Binary Search Array
*/



/*binary search O(logn) time
since we only need to return the index of anyone of the peaks
If num[i-1] < num[i] > num[i+1], then num[i] is peak
If num[i-1] < num[i] < num[i+1], then num[i+1...n-1] must contains a peak
If num[i-1] > num[i] > num[i+1], then num[0...i-1] must contains a peak
If num[i-1] > num[i] < num[i+1], then both sides have peak
(n is num.length)
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int findPeakElement(vector<int>& nums) {
        return helper(nums, 0, nums.size()-1);
    }
    
    int helper(vector<int>& nums, int start, int end){
        if(start==end){
            return start;
        } else if (start+1==end){
            if(nums[start] > nums[end]) return start;
            return end;
        } else {
            int mid = (start+end)/2;
            if(nums[mid-1]<nums[mid] && nums[mid]>nums[mid+1]){
                return mid;
            } else if(nums[mid-1]<nums[mid] && nums[mid]<nums[mid+1]){
                return helper(nums, mid+1, end);
            } else {
                return helper(nums, start, mid-1);
            }
        }
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int findPeakElement(int[] nums) {
        return helper(nums, 0, nums.length-1);
    }
    
    public int helper(int[] nums, int start, int end){
        if(start==end){
            return start;
        } else if (start+1 == end){
            if(nums[start] > nums[end]) return start;
            return end;
        } else {
            int mid = (start+end)/2;
            if(nums[mid-1]<nums[mid] && nums[mid]>nums[mid+1]){
                return mid;
            } else if(nums[mid-1]<nums[mid] && nums[mid]<nums[mid+1]){
                return helper(nums, mid+1,end);
            } else {
                return helper(nums, start, mid-1);
            }
        }
    }
}
