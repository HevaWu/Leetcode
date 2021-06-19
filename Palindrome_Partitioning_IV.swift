/*
Given a string s, return true if it is possible to split the string s into three non-empty palindromic substrings. Otherwise, return false.​​​​​

A string is said to be palindrome if it the same string when reversed.



Example 1:

Input: s = "abcbdd"
Output: true
Explanation: "abcbdd" = "a" + "bcb" + "dd", and all three substrings are palindromes.
Example 2:

Input: s = "bcbddxy"
Output: false
Explanation: s cannot be split into 3 palindromes.


Constraints:

3 <= s.length <= 2000
s​​​​​​ consists only of lowercase English letters.
*/

/*
Solution 1:
DP

dp[i][j] = true if s[i...j] is palindrome
build dp first, then check if we can find i,j, where dp[0][i], dp[i+1][j], dp[j+1][n-1] all true

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func checkPartitioning(_ s: String) -> Bool {
        let n = s.count
        var s = Array(s)

        var dp = Array(
            repeating: Array(repeating: false, count: n),
            count: n
        )

        for i in 0..<n {
            dp[i][i] = true
            if i+1 < n, s[i] == s[i+1] {
                dp[i][i+1] = true
            }
        }

        for len in 2..<n {
            for j in len..<n {
                let i = j-len
                dp[i][j] = dp[i+1][j-1] && s[i] == s[j]
            }
        }
        // print(dp)

        for i in 0..<n {
            if dp[0][i], i+1 < n {
                for j in (i+1)..<n {
                    if dp[i+1][j], j+1 < n, dp[j+1][n-1] {
                        return true
                    }
                }
            }
        }

        return false
    }
}