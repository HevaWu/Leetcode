/*153. Find Minimum in Rotated Sorted Array
Description  Submission  Solutions  Add to List
Total Accepted: 133227
Total Submissions: 342838
Difficulty: Medium
Contributors: Admin
Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

Find the minimum element.

You may assume no duplicate exists in the array.

Hide Company Tags Microsoft
Hide Tags Array Binary Search
Hide Similar Problems (M) Search in Rotated Sorted Array (H) Find Minimum in Rotated Sorted Array II
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 1:
Binary Search


Solution 2:
O(n) time
search from start, find the minimum value
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int findMin(int[] nums) {
        if(nums.length <= 0) return -1;
        if(nums.length == 1) return nums[0];

        int start = 0;
        int end = nums.length-1;

        while(start < end){
            if(nums[start] < nums[end]) return nums[start];

            int mid = (start+end)/2;
            if(nums[mid] >= nums[start]){
                start = mid+1;
            } else {
                end = mid;
            }
        }

        return nums[start]; //return start
    }
}


//Solution 2
public class Solution {
    public int findMin(int[] nums) {
        if(nums.length <= 0) return -1;
        int min = nums[0];
        for(int i = 1; i < nums.length; ++i){
            if(nums[i] < nums[i-1]){
                min = Math.min(min, nums[i]);
            }
        }
        return min;
    }
}

