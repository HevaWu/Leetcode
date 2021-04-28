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
    func longestPalindromeSubseq(_ s: String) -> Int {
        var s = Array(s)
        let n = s.count

        // dp[i][j] longest subsequence in s[i...j]
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: n),
            count: n
        )

        return check(0, n-1, s, &dp)
    }

    func check(_ i: Int, _ j: Int,
               _ s: [Character], _ dp: inout [[Int?]]) -> Int {
        if let val = dp[i][j] { return val }
        if i > j {
            dp[i][j] = 0
            return 0
        }
        if i == j {
            dp[i][j] = 1
            return 1
        }

        if s[i] == s[j] {
            dp[i][j] = check(i+1, j-1, s, &dp) + 2
        } else {
            dp[i][j] = max(
                check(i+1, j, s, &dp),
                check(i, j-1, s, &dp)
            )
        }
        return dp[i][j]!
    }
}

/*
Solution 1:
DP

dp[i][j] is longest subsequence in s[i...j]
dp[i][j] = dp[i+1][j-1] if s[i] == s[j]
else dp[i][j] = max(dp[i+1][j], dp[i][j-1])

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func longestPalindromeSubseq(_ s: String) -> Int {
        var s = Array(s)
        let n = s.count

        // dp[i][j] longest subsequence in s[i...j]
        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in stride(from: n-1, through: 0, by: -1) {
            dp[i][i] = 1
            for j in i+1..<n {
                if s[i] == s[j] {
                    dp[i][j] = dp[i+1][j-1] + 2
                } else {
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1])
                }
            }
        }
        return dp[0][n-1]
    }
}