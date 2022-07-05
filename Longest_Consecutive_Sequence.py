'''
Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

Your algorithm should run in O(n) complexity.

Example:

Input: [100, 4, 200, 1, 3, 2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
'''

'''
Solution 1:
map
- map[i] is the number of element in consecutive path with boundary at i
- go through num
  - if there is a value there, means this num is counted
  - if there is no value there, try to find its left(num-1) and right(num+1) consecutive path, then put it into map, also need to update the boundary number in the map

Time complexity: O(n)
Space complexity: O(n)
'''
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        # boundary map help checking map[num]'s
        # length of longest consecutive path
        boundary = {}

        longest = 0
        for num in nums:
            if num not in boundary:
                l = boundary.get(num-1, 0)
                r = boundary.get(num+1, 0)
                cur = l+r+1
                boundary[num] = cur
                boundary[num-l] = cur
                boundary[num+r] = cur
                longest = max(longest, cur)
        return longest