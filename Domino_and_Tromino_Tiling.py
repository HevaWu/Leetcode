'''
We have two types of tiles: a 2x1 domino shape, and an "L" tromino shape. These shapes may be rotated.

XX  <- domino

XX  <- "L" tromino
X
Given n, how many ways are there to tile a 2 x n board? Return your answer modulo 109 + 7.

(In a tiling, every square must be covered by a tile. Two tilings are different if and only if there are two 4-directionally adjacent cells on the board such that exactly one of the tilings has both squares occupied by a tile.)

Example:
Input: n = 3
Output: 5
Explanation:
The five different ways are listed below, different letters indicates different tiles:
XYZ XXZ XYY XXY XYY
XYZ YYZ XZZ XYY XXY
Note:

n will be in range [1, 1000].
'''

'''
Solution 1:
DP

dp[n] = dp[n-1] + dp[n-2] + 2(dp[n-3] + ... dp[0])
      = dp[n-1] + dp[n-3] + dp[n-2] + dp[n-3] + 2(dp[n-4] + ... + dp[0])
      = dp[n-1] + dp[n-3] + dp[n-1]
      = 2dp[n-1] + dp[n-3]

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def numTilings(self, n: int) -> int:
        if n < 3:
            return n

        mod = 1000000007
        dp = [0 for _ in range(n+1)]
        dp[0] = 1
        dp[1] = 1
        dp[2] = 2

        for i in range (3, n+1):
            dp[i] = ((2*dp[i-1])%mod + dp[i-3]%mod) % mod

        return dp[n]
