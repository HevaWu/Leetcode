'''
Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.



Example 1:

Input: nums = [1,1,2]
Output:
[[1,1,2],
 [1,2,1],
 [2,1,1]]
Example 2:

Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]


Constraints:

1 <= nums.length <= 8
-10 <= nums[i] <= 10
'''

'''
Solution 1:
backtrack

put num and freq into map
then insert number by sorted keys

Time Complexity: O(n!)
Space Complexity: O(n)
'''
class Solution:
    def permuteUnique(self, nums: List[int]) -> List[List[int]]:
        per = []
        cur = []

        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        n = len(nums)
        def backtrack(cur, freq):
            if len(cur) == n:
                per.append(cur.copy())
                return

            for num in freq.keys():
                if freq[num] > 0:
                    cur.append(num)
                    freq[num] = freq[num]-1

                    backtrack(cur, freq)

                    freq[num] = freq[num]+1
                    cur.pop(-1)

        backtrack(cur, freq)
        return per
