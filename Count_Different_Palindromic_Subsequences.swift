/*
Given a string S, find the number of different non-empty palindromic subsequences in S, and return that number modulo 10^9 + 7.

A subsequence of a string S is obtained by deleting 0 or more characters from S.

A sequence is palindromic if it is equal to the sequence reversed.

Two sequences A_1, A_2, ... and B_1, B_2, ... are different if there is some i for which A_i != B_i.

Example 1:
Input:
S = 'bccb'
Output: 6
Explanation:
The 6 different non-empty palindromic subsequences are 'b', 'c', 'bb', 'cc', 'bcb', 'bccb'.
Note that 'bcb' is counted only once, even though it occurs twice.
Example 2:
Input:
S = 'abcdabcdabcdabcdabcdabcdabcdabcddcbadcbadcbadcbadcbadcbadcbadcba'
Output: 104860361
Explanation:
There are 3104860382 different non-empty palindromic subsequences, which is 104860361 modulo 10^9 + 7.
Note:

The length of S will be in the range [1, 1000].
Each character S[i] will be in the set {'a', 'b', 'c', 'd'}.

*/

/*
Solution 1:
DP

dp[i][j] - maintain result from [i...j]

when s[i] != s[j]
- dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1]

when s[i] == s[j]
- use left, right find diff char in left half and right half
  -> if left > right, the pattern might be `a...a` `a...a`
    /* eg:  "aba" while i = 0 and j = 2:  dp[1][1] = 1 records the palindrome{"b"},
    the reason why dp[i + 1][j - 1] * 2 counted is that we count dp[i + 1][j - 1] one time as {"b"},
    and additional time as {"aba"}.
    The reason why 2 counted is that we also count {"a", "aa"}.
    So totally dp[i][j] record the palindrome: {"a", "b", "aa", "aba"}.
    */
  -> if left == right, consider the string from i to j is "a...a...a" where there is only one character 'a' inside the leftmost and rightmost 'a'
    /* eg:  "aaa" while i = 0 and j = 2: the dp[i + 1][j - 1] records the palindrome {"a"}.
    the reason why dp[i + 1][j - 1] * 2 counted is that we count dp[i + 1][j - 1] one time as {"a"},
    and additional time as {"aaa"}.
    the reason why 1 counted is that we also count {"aa"} that the first 'a' come from index i and the second come from index j. So totally dp[i][j] records {"a", "aa", "aaa"}
    */
  -> if left < right, consider the string from i to j is "a...a...a... a" where there are at least two character 'a' close to leftmost and rightmost 'a'
    /* eg: "aacaa" while i = 0 and j = 4: the dp[i + 1][j - 1] records the palindrome {"a",  "c", "aa", "aca"}.
    the reason why dp[i + 1][j - 1] * 2 counted is that we count dp[i + 1][j - 1] one time as {"a",  "c", "aa", "aca"},
    and additional time as {"aaa",  "aca", "aaaa", "aacaa"}.  Now there is duplicate :  {"aca"},
    which is removed by deduce dp[low + 1][high - 1]. So totally dp[i][j] record {"a",  "c", "aa", "aca", "aaa", "aaaa", "aacaa"}
    */

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func countPalindromicSubsequences(_ S: String) -> Int {
        let n = S.count
        if n == 1 { return 1 }

        let mod = Int(1e9+7)
        var S = Array(S)
        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in 0..<n {
            dp[i][i] = 1
        }

        for len in 1..<n {
            for i in 0..<n-len {
                let j = i + len
                if S[i] != S[j] {
                    dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1]
                } else {
                    var left = i + 1
                    var right = j - 1
                    while left <= right, S[left] != S[j] {
                        left += 1
                    }
                    while left <= right, S[right] != S[i] {
                        right -= 1
                    }

                    if left > right {
                        dp[i][j] = dp[i+1][j-1] * 2 + 2
                    } else if left == right {
                        dp[i][j] = dp[i+1][j-1] * 2 + 1
                    } else {
                        dp[i][j] = dp[i+1][j-1] * 2 - dp[left+1][right-1]
                    }
                }

                dp[i][j] = dp[i][j] < 0 ? dp[i][j] + mod : dp[i][j] % mod
            }
        }

        return dp[0][n-1]
    }
}