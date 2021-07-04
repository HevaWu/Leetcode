/*
Given an integer n, your task is to count how many strings of length n can be formed under the following rules:

Each character is a lower case vowel ('a', 'e', 'i', 'o', 'u')
Each vowel 'a' may only be followed by an 'e'.
Each vowel 'e' may only be followed by an 'a' or an 'i'.
Each vowel 'i' may not be followed by another 'i'.
Each vowel 'o' may only be followed by an 'i' or a 'u'.
Each vowel 'u' may only be followed by an 'a'.
Since the answer may be too large, return it modulo 10^9 + 7.



Example 1:

Input: n = 1
Output: 5
Explanation: All possible strings are: "a", "e", "i" , "o" and "u".
Example 2:

Input: n = 2
Output: 10
Explanation: All possible strings are: "ae", "ea", "ei", "ia", "ie", "io", "iu", "oi", "ou" and "ua".
Example 3:

Input: n = 5
Output: 68


Constraints:

1 <= n <= 2 * 10^4
*/

/*
Solution 1:
DP

based on the rule
ae
ea, ei
ia, ie, io, iu
oi, ou
ua

dp[i][j] to record ith length and end with jth vowel permutation
j = 0 -> a
j = 1 -> e
j = 2 -> i
j = 3 -> o
j = 4 -> u

- if we want to append a, previous can be e, i, u
    ->  dp[i][0] = dp[i-1][1] + dp[i-1][2] + dp[i-1][4]
- if we want to append e, previous can be a, i
    ->  dp[i][0] = dp[i-1][0] + dp[i-1][2]
- if we want to append i, previous can be e, o
    ->  dp[i][0] = dp[i-1][1] + dp[i-1][3]
- if we want to append o, previous can be i
    ->  dp[i][0] = dp[i-1][2]
- if we want to append u, previous can be i, o
    ->  dp[i][0] = dp[i-1][2] + dp[i-1][3]

Time Complexity: O(5n)
Space Complexity: O(5n)
*/
class Solution {
    func countVowelPermutation(_ n: Int) -> Int {
        let mod = Int(1e9 + 7)
        if n == 1 { return 5 }

        // a, e, i, o, u, char 0, 1, 2, 3, 4
        // dp[i][j], ith len, end by char j
        var dp = Array(
            repeating: Array(repeating: 0, count: 5),
            count: n
        )
        dp[0] = [1, 1, 1, 1, 1]

        for i in 1..<n {
            dp[i][0] = (dp[i-1][1] + dp[i-1][2] + dp[i-1][4]) % mod
            dp[i][1] = (dp[i-1][0] + dp[i-1][2]) % mod
            dp[i][2] = (dp[i-1][1] + dp[i-1][3]) % mod
            dp[i][3] = dp[i-1][2]
            dp[i][4] = (dp[i-1][2] + dp[i-1][3]) % mod
        }

        return (dp[n-1][0] + dp[n-1][1] + dp[n-1][2] + dp[n-1][3] + dp[n-1][4]) % mod
    }
}