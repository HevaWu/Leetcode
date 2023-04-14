public class Longest_Palindromic_Subsequence {

}
/*
Given a string s, find the longest palindromic subsequence's length in s.

A subsequence is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.



Example 1:

Input: s = "bbbab"
Output: 4
Explanation: One possible longest palindromic subsequence is "bbbb".
Example 2:

Input: s = "cbbd"
Output: 2
Explanation: One possible longest palindromic subsequence is "bb".


Constraints:

1 <= s.length <= 1000
s consists only of lowercase English letters.
*/

/*
Solution 2:
DP
bottom up

recursive with memoization

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    public int longestPalindromeSubseq(String s) {
        int n = s.length();
        int[][] dp = new int[n][n];
        for(int i = 0; i < n; i++) {
            for(int j = 0; j < n; j++) {
                dp[i][j] = -1;
            }
        }
        return check(0, n-1, s, dp);
    }

    int check(int i, int j, String s, int[][] dp) {
        if(dp[i][j] != -1) { return dp[i][j]; }
        if (i > j) {
            dp[i][j] = 0;
            return 0;
        }

        if (i == j) {
            dp[i][j] = 1;
            return 1;
        }

        if (s.charAt(i) == s.charAt(j)){
            dp[i][j] = check(i+1, j-1, s, dp) + 2;
        } else {
            dp[i][j] = Math.max(
                check(i+1, j, s, dp),
                check(i, j-1, s, dp)
            );
        }
        return dp[i][j];
    }
}
