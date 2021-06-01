/*
There is a strange printer with the following two special properties:

The printer can only print a sequence of the same character each time.
At each turn, the printer can print new characters starting from and ending at any place and will cover the original existing characters.
Given a string s, return the minimum number of turns the printer needed to print it.



Example 1:

Input: s = "aaabbb"
Output: 2
Explanation: Print "aaa" first and then print "bbb".
Example 2:

Input: s = "aba"
Output: 2
Explanation: Print "aaa" first and then print "b" from the second place of the string, which will cover the existing character 'a'.


Constraints:

1 <= s.length <= 100
s consists of lowercase English letters.
*/

/*
Solution 1:
DP

dp[i][j] means min number of print for s[i...j]
- init, dp[i][i], dp[i-1][i]
- check by len, if s[k] == s[j] we can shorten print as (dp[i][k] + dp[k+1][j] - 1)

Time Complexity: O(n*n*n)
Space Complexity: O(n*n)
*/
class Solution {
    func strangePrinter(_ s: String) -> Int {
        let n = s.count
        var s = Array(s)

        if n == 1 { return 1 }

        // dp[i][j] min number of turns for s[i...j]
        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in 0..<n {
            dp[i][i] = 1
            if i > 0 {
                // check adjacent 2 char
                dp[i-1][i] = s[i-1] == s[i] ? 1 : 2
            }
        }

        for len in 2..<n {
            for j in len..<n {
                let i = j-len
                dp[i][j] = len+1

                // print(dp)
                // start from i
                var k = i
                while k < j {
                    let temp = dp[i][k] + dp[k+1][j]
                    // we can shorten print if s[k] == s[j]
                    dp[i][j] = min(
                        dp[i][j],
                        s[k] == s[j] ? temp-1 : temp
                    )
                    k += 1
                }
                // print(dp)
            }
        }

        return dp[0][n-1]
    }
}