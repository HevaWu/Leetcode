/*
Given two strings text1 and text2, return the length of their longest common
subsequence. If there is no common subsequence, return 0.

A subsequence of a string is a new string generated from the original string
with some characters (can be none) deleted without changing the relative order
of the remaining characters.

For example, "ace" is a subsequence of "abcde".
A common subsequence of two strings is a subsequence that is common to both
strings.



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
 public:
  int longestCommonSubsequence(string text1, string text2) {
    int n1 = text1.size();
    int n2 = text2.size();
    int dp[n1 + 1][n2 + 1];
    for (int i = 0; i < n1 + 1; i++) {
      dp[i][0] = 0;
    }
    for (int j = 0; j < n2 + 1; j++) {
      dp[0][j] = 0;
    }
    for (int i = 0; i < n1; i++) {
      for (int j = 0; j < n2; j++) {
        dp[i + 1][j + 1] = max(max(dp[i + 1][j], dp[i][j + 1]),
                               text1[i] == text2[j] ? 1 + dp[i][j] : 0);
      }
    }
    return dp[n1][n2];
  }
};
