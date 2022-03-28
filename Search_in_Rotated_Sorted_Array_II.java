/*
There is an integer array nums sorted in non-decreasing order (not necessarily with distinct values).

Before being passed to your function, nums is rotated at an unknown pivot index k (0 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,4,4,5,6,6,7] might be rotated at pivot index 5 and become [4,5,6,6,7,0,1,2,4,4].

Given the array nums after the rotation and an integer target, return true if target is in nums, or false if it is not in nums.



Example 1:

Input: nums = [2,5,6,0,0,1,2], target = 0
Output: true
Example 2:

Input: nums = [2,5,6,0,0,1,2], target = 3
Output: false


Constraints:

1 <= nums.length <= 5000
-104 <= nums[i] <= 104
nums is guaranteed to be rotated at some pivot.
-104 <= target <= 104


Follow up: This problem is the same as Search in Rotated Sorted Array, where nums may contain duplicates. Would this affect the runtime complexity? How and why?
*/

/*
Solution 1:
binary search

shorten left, right if left+1, right-1 is duplicated
then do same thing as Search in rotated sorted array

Time Complexity: worst O(n) best O(logn)
Space Complexity: O(1)
*/
class Solution {
    public boolean search(int[] nums, int target) {
        if (nums.length == 0) { return false; }

        int left = 0;
        int right = nums.length-1;
        while (left <= right) {
            while (left < right && nums[left] == nums[left+1]) {
                left += 1;
            }
            while (left < right && nums[right-1] == nums[right]) {
                right -= 1;
            }

            int mid = left + (right - left) / 2;
            if (nums[mid] == target) { return true; }
            if (nums[left] <= nums[mid]) {
                if (nums[left] <= target && target <= nums[mid]) {
                    right = mid-1;
                } else {
                    left = mid+1;
                }
            } else {
                if (nums[mid] <= target && target <= nums[right]) {
                    left = mid+1;
                } else {
                    right = mid-1;
                }
            }
        }
        return false;
    }
}