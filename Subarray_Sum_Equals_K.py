'''
Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum equals to k.



Example 1:

Input: nums = [1,1,1], k = 2
Output: 2
Example 2:

Input: nums = [1,2,3], k = 3
Output: 2


Constraints:

1 <= nums.length <= 2 * 104
-1000 <= nums[i] <= 1000
-107 <= k <= 107

'''

'''
Solution 2:
map, store [sum-k: count]

[sum_i, number of occurrences of sum_i]

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def subarraySum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        # key is sum-k, value is frequency
        numMap = {}
        numMap[0] = 1

        numSum = 0
        count = 0
        for num in nums:
            numSum += num
            if numSum-k in numMap:
                count += numMap[numSum-k]
            numMap[numSum] = numMap.get(numSum, 0) + 1
        return count