'''
You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once.

Return the single element that appears only once.

Your solution must run in O(log n) time and O(1) space.



Example 1:

Input: nums = [1,1,2,3,3,4,4,8,8]
Output: 2
Example 2:

Input: nums = [3,3,7,7,10,11,11]
Output: 10


Constraints:

1 <= nums.length <= 105
0 <= nums[i] <= 105
'''

'''
Solution 2:
binary search

Time Complexity: O(logn)
Space COmplexity: O(1)
'''
class Solution:
    def singleNonDuplicate(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1: return nums[0]

        l = 0
        r = n-1
        while l < r:
            mid = l + (r-l)//2
            if (mid+1<n and mid%2 == 0 and nums[mid]==nums[mid+1]) or (mid-1>=0 and mid%2 != 0 and nums[mid]==nums[mid-1]):
                l = mid+1
            else:
                r = mid
        return nums[l]
