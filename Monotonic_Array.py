'''
An array is monotonic if it is either monotone increasing or monotone decreasing.

An array nums is monotone increasing if for all i <= j, nums[i] <= nums[j]. An array nums is monotone decreasing if for all i <= j, nums[i] >= nums[j].

Given an integer array nums, return true if the given array is monotonic, or false otherwise.



Example 1:

Input: nums = [1,2,2,3]
Output: true
Example 2:

Input: nums = [6,5,4,4]
Output: true
Example 3:

Input: nums = [1,3,2]
Output: false


Constraints:

1 <= nums.length <= 105
-105 <= nums[i] <= 105
'''

'''
Solution 1:
iterate array, check if it is keep increasing / decreasing

Time Complexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def isMonotonic(self, nums: List[int]) -> bool:
        n = len(nums)
        if n <= 1: return True
        gap = nums[1] - nums[0]
        for i in range(2, n):
            tmp = nums[i] - nums[i-1]
            if gap == 0:
                gap = tmp
            else:
                if gap * tmp < 0: return False
        return True
