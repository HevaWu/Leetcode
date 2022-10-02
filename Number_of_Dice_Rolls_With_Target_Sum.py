'''
You have d dice and each die has f faces numbered 1, 2, ..., f.

Return the number of possible ways (out of fd total ways) modulo 109 + 7 to roll the dice so the sum of the face-up numbers equals target.



Example 1:

Input: d = 1, f = 6, target = 3
Output: 1
Explanation:
You throw one die with 6 faces.  There is only one way to get a sum of 3.
Example 2:

Input: d = 2, f = 6, target = 7
Output: 6
Explanation:
You throw two dice, each with 6 faces.  There are 6 ways to get a sum of 7:
1+6, 2+5, 3+4, 4+3, 5+2, 6+1.
Example 3:

Input: d = 2, f = 5, target = 10
Output: 1
Explanation:
You throw two dice, each with 5 faces.  There is only one way to get a sum of 10: 5+5.
Example 4:

Input: d = 1, f = 2, target = 3
Output: 0
Explanation:
You throw one die with 2 faces.  There is no way to get a sum of 3.
Example 5:

Input: d = 30, f = 30, target = 500
Output: 222616187
Explanation:
The answer must be returned modulo 10^9 + 7.


Constraints:

1 <= d, f <= 30
1 <= target <= 1000

'''

'''
Solution 2:
bottom up dp
dp[current dices][current sum target]

Time Complexity: O(n*target*k)
Space Complexity: O(n*target)
'''
class Solution:
    def numRollsToTarget(self, n: int, k: int, target: int) -> int:
        if n == 1:
            return 1 if k >= target else 0

        dp = [[0 for _ in range(target+1)] for _ in range(n+1)]

        # init dp[1]
        for k1 in range(1, min(k, target)+1):
            dp[1][k1] = 1

        modNum = 1_000_000_007
        for i in range(2, n+1):
            for t in range(i, min(i*k, target)+1):
                for k1 in range(1, min(k, t-1)+1):
                    dp[i][t] = (dp[i][t] + dp[i-1][t-k1]) % modNum

        return dp[n][target]
