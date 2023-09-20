'''
You are given an integer array nums and an integer x. In one operation, you can either remove the leftmost or the rightmost element from the array nums and subtract its value from x. Note that this modifies the array for future operations.

Return the minimum number of operations to reduce x to exactly 0 if it's possible, otherwise, return -1.



Example 1:

Input: nums = [1,1,4,2,3], x = 5
Output: 2
Explanation: The optimal solution is to remove the last two elements to reduce x to zero.
Example 2:

Input: nums = [5,6,7,8,9], x = 4
Output: -1
Example 3:

Input: nums = [3,2,20,1,1,3], x = 10
Output: 5
Explanation: The optimal solution is to remove the last three elements and the first two elements (5 operations in total) to reduce x to zero.


Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 104
1 <= x <= 109

Hint 1:
Think in reverse; instead of finding the minimum prefix + suffix, find the maximum subarray.

Hint 2:
Finding the maximum subarray is standard and can be done greedily.
'''

'''
Solution 2:
2 window
Optimize space by use 2 pointer

- use left & right to control the sum part
- once we find cur > target, move left pointer to check if existing cur == target case, if exist, compare (right-left+1) wih current res

Time Complexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def minOperations(self, nums: List[int], x: int) -> int:
        target = -x;
        for num in nums:
            target += num;
        if target < 0: return -1
        if target == 0: return len(nums)
        n = len(nums)
        l = 0;
        r = 0;
        cur = 0;
        res = -1;
        while r < n:
            cur += nums[r]
            while cur > target and l <= r:
                cur -= nums[l];
                l += 1;
            if cur == target:
                res = max(res, r-l+1);
            r += 1;
        return -1 if res == -1 else n-res;
