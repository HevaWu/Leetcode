'''
Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Determine if you are able to reach the last index.

Example 1:

Input: [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
Example 2:

Input: [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum
             jump length is 0, which makes it impossible to reach the last index.

Hint:
This is dynamic programming question
There are 4 ways to solve it:
- Start with the recursive backtracking solution
- Optimize by using a memoization table (top-down[2] dynamic programming)
- Remove the need for recursion (bottom-up dynamic programming)
- Apply final tricks to reduce the time / memory complexity
'''

'''
Solution 5:
Greedy
keep tracking the maximum jumpable place
once find user can jump to end
return true

Time Complexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def canJump(self, nums: List[int]) -> bool:
        maxJump = 0
        cur = 0
        target = len(nums)-1
        while cur <= maxJump:
            maxJump = max(maxJump, cur + nums[cur])
            if maxJump >= target: return True
            cur += 1
        return False
