/*
Given two strings s and t, return the number of distinct subsequences of s which equals t.

A string's subsequence is a new string formed from the original string by deleting some (can be none) of the characters without disturbing the remaining characters' relative positions. (i.e., "ACE" is a subsequence of "ABCDE" while "AEC" is not).

It is guaranteed the answer fits on a 32-bit signed integer.



Example 1:

Input: s = "rabbbit", t = "rabbit"
Output: 3
Explanation:
As shown below, there are 3 ways you can generate "rabbit" from S.
rabbbit
rabbbit
rabbbit
Example 2:

Input: s = "babgbag", t = "bag"
Output: 5
Explanation:
As shown below, there are 5 ways you can generate "bag" from S.
babgbag
babgbag
babgbag
babgbag
babgbag


Constraints:

1 <= s.length, t.length <= 1000
s and t consist of English letters.
*/

/*
Solution 2:
optimzie solution 1 by using only 2 array

Time Complexity: O(ns * nt)
Space Complexity: O(ns)
*/
class Solution {
    public int numDistinct(String s, String t) {
        int ns = s.length();
        int nt = t.length();

        int[] pre = new int[ns+1];
        for (int i = 0; i <= ns; i++) {
            pre[i] = 1;
        }

        int[] cur = new int[ns+1];

        for (int i = 1; i <= nt; i++) {
            for (int j = 1; j <= ns; j++) {
                if (t.charAt(i-1) == s.charAt(j-1)) {
                    cur[j] = pre[j-1] + cur[j-1];
                } else {
                    cur[j] = cur[j-1];
                }
            }

            pre = Arrays.copyOf(cur, ns+1);

            // for (int j = 0; j <= ns; j++) {
            //     pre[j] = cur[j];
            // }
        }

        return cur[ns];
    }
}

/*
Solution 1:
DP

- if the current character in S doesn't equal to current character T, then we have the same number of distinct subsequences as we had without the new character.
- if the current character in S equal to the current character T, then the distinct number of subsequences: the number we had before plus the distinct number of subsequences we had with less longer T and less longer S.

- dp[i][j] = dp[i-1][j] when s[i-1] != t[j-1]
- or dp[i][j] = dp[i-1][j] + dp[i-1][j-1] when s[i-1] == t[j-1],
- dp[i][j] represents the number of distinct subsequences for s[0, i-1] and t[0, t-1];

We first keep in mind that s is the longer string [0, i-1], t is the shorter substring [0, j-1]. We can assume t is fixed, and s is increasing in character one by one (this is the key point).

Time Complexity: O(ns * nt)
Space Complexity: O(ns * nt)
*/
class Solution {
    public int numDistinct(String s, String t) {
        int ns = s.length();
        int nt = t.length();

        int[][] dp = new int[nt+1][ns+1];
        for (int j = 0; j <= ns; j++) {
            dp[0][j] = 1;
        }

        for (int i = 1; i <= nt; i++) {
            for (int j = 1; j <= ns; j++) {
                if (t.charAt(i-1) == s.charAt(j-1)) {
                    dp[i][j] = dp[i-1][j-1] + dp[i][j-1];
                } else {
                    dp[i][j] = dp[i][j-1];
                }
            }
        }

        return dp[nt][ns];
    }
}