'''
Given two strings word1 and word2, return the minimum number of steps required to make word1 and word2 the same.

In one step, you can delete exactly one character in either string.



Example 1:

Input: word1 = "sea", word2 = "eat"
Output: 2
Explanation: You need one step to make "sea" to "ea" and another step to make "eat" to "ea".
Example 2:

Input: word1 = "leetcode", word2 = "etco"
Output: 4


Constraints:

1 <= word1.length, word2.length <= 500
word1 and word2 consist of only lowercase English letters.
'''

'''
Solution 1:
DP

Idea:
- this problem is similar as solving find "maximum common characters between word1 and word2"
- for get minimum step, we first find maximum common chars between word1 and word2, and keep characters order same as original
- then, return (word1+word2 length - 2*dp[n1-1][n2-1]) should be okay

dp[i][j] is maximum common chars between word1[0...i] and word2[0...j]

Time Complexity: O(n1*n2)
Space Complexity: O(n1*n2)
'''
class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        m = len(word1)
        n = len(word2)
        dp = [[0 for j in range(n)] for i in range(m)]
        for i in range(m):
            for j in range(n):
                if word1[i] == word2[j]:
                    dp[i][j] = dp[i-1][j-1]+1 if i > 0 and j > 0 else 1
                else:
                    dp[i][j] = max(
                        dp[i-1][j] if i > 0 else 0,
                        dp[i][j-1] if j > 0 else 0
                    )
        # total words length is m+n
        # remove common chars between word1 and word2
        # will be result
        return m+n-2*dp[m-1][n-1]