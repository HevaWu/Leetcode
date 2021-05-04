/*
Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

For example, "ace" is a subsequence of "abcde".
A common subsequence of two strings is a subsequence that is common to both strings.



Example 1:

Input: text1 = "abcde", text2 = "ace"
Output: 3
Explanation: The longest common subsequence is "ace" and its length is 3.
Example 2:

Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: The longest common subsequence is "abc" and its length is 3.
Example 3:

Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: There is no such common subsequence, so the result is 0.


Constraints:

1 <= text1.length, text2.length <= 1000
text1 and text2 consist of only lowercase English characters.
*/

/*
Solution 1:
DP

if text1[i] == text2[j], DP[i][j] = DP[i - 1][j - 1] + 1
otherwise DP[i][j] = max(DP[i - 1][j], DP[i][j - 1])

Time Complexity: O(n1*n2)
Space Complexity: O(n1 * n2)
*/
class Solution {
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        let n1 = text1.count
        let n2 = text2.count

        let text1 = Array(text1)
        let text2 = Array(text2)

        // dp[i][j] LCS for text1[0...i] text2[0...j]
        var dp = Array(
            repeating: Array(repeating: 0, count: n2),
            count: n1
        )

        for i in 0..<n1 {
            for j in 0..<n2 {
                if text1[i] == text2[j] {
                    dp[i][j] = (i > 0 && j > 0 ? dp[i-1][j-1] : 0) + 1
                } else {
                    dp[i][j] = max(
                        i > 0 ? dp[i-1][j] : 0,
                        j > 0 ? dp[i][j-1] : 0
                    )
                }
            }
        }

        return dp[n1-1][n2-1]
    }
}