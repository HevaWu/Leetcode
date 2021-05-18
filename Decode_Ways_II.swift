/*
A message containing letters from A-Z can be encoded into numbers using the following mapping:

'A' -> "1"
'B' -> "2"
...
'Z' -> "26"
To decode an encoded message, all the digits must be grouped then mapped back into letters using the reverse of the mapping above (there may be multiple ways). For example, "11106" can be mapped into:

"AAJF" with the grouping (1 1 10 6)
"KJF" with the grouping (11 10 6)
Note that the grouping (1 11 06) is invalid because "06" cannot be mapped into 'F' since "6" is different from "06".

In addition to the mapping above, an encoded message may contain the '*' character, which can represent any digit from '1' to '9' ('0' is excluded). For example, the encoded message "1*" may represent any of the encoded messages "11", "12", "13", "14", "15", "16", "17", "18", or "19". Decoding "1*" is equivalent to decoding any of the encoded messages it can represent.

Given a string s containing digits and the '*' character, return the number of ways to decode it.

Since the answer may be very large, return it modulo 109 + 7.



Example 1:

Input: s = "*"
Output: 9
Explanation: The encoded message can represent any of the encoded messages "1", "2", "3", "4", "5", "6", "7", "8", or "9".
Each of these can be decoded to the strings "A", "B", "C", "D", "E", "F", "G", "H", and "I" respectively.
Hence, there are a total of 9 ways to decode "*".
Example 2:

Input: s = "1*"
Output: 18
Explanation: The encoded message can represent any of the encoded messages "11", "12", "13", "14", "15", "16", "17", "18", or "19".
Each of these encoded messages have 2 ways to be decoded (e.g. "11" can be decoded to "AA" or "K").
Hence, there are a total of 9 * 2 = 18 ways to decode "1*".
Example 3:

Input: s = "2*"
Output: 15
Explanation: The encoded message can represent any of the encoded messages "21", "22", "23", "24", "25", "26", "27", "28", or "29".
"21", "22", "23", "24", "25", and "26" have 2 ways of being decoded, but "27", "28", and "29" only have 1 way.
Hence, there are a total of (6 * 2) + (3 * 1) = 12 + 3 = 15 ways to decode "2*".


Constraints:

1 <= s.length <= 105
s[i] is a digit or '*'.
*/

/*
Solution 1:
DP

the number of decodings possible upto any index, ii, is dependent only on the characters upto the index ii and not on any of the characters following it. This leads us to the idea that this problem can be solved by making use of Dynamic Programming.

We can also easily observe from the recursive solution that, the number of decodings possible upto the index ii can be determined easily if we know the number of decodings possible upto the index i-1i−1 and i-2i−2. Thus, we fill in the dpdp array in a forward manner. dp[i]dp[i] is used to store the number of decodings possible by considering the characters in the given string ss upto the (i-1)^{th}(i−1)
th
  index only(including it).

The equations for filling this dpdp at any step again depend on the current character and the just preceding character. These equations are similar to the ones used in the recursive solution.

Time complexity : O(n). dpdp array of size n+1n+1 is filled once only. Here, nn refers to the length of the input string.
Space complexity : O(n). dpdp array of size n+1n+1 is used.
*/
class Solution {
    func numDecodings(_ s: String) -> Int {
        let mod = Int(1e9 + 7)
        let n = s.count
        var s = Array(s)

        // dp[i] num of decodings of s[0..<i]
        var dp = Array(repeating: 0, count: n+1)

        dp[0] = 1
        dp[1] = s[0] == "*" ? 9 : (s[0] == "0" ? 0 : 1)

        for i in 1..<n {
            if s[i] == "*" {
                dp[i+1] = 9 * dp[i]
                if s[i-1] == "1" {
                    dp[i+1] = (dp[i+1] + 9 * dp[i-1]) % mod
                } else if s[i-1] == "2" {
                    dp[i+1] = (dp[i+1] + 6 * dp[i-1]) % mod
                } else if s[i-1] == "*" {
                    dp[i+1] = (dp[i+1] + 15 * dp[i-1]) % mod
                }
            } else {
                dp[i+1] = s[i] == "0" ? 0 : dp[i]
                if s[i-1] == "1" {
                    dp[i+1] = (dp[i+1] + dp[i-1]) % mod
                } else if s[i-1] == "2" && s[i] <= "6" {
                    dp[i+1] = (dp[i+1] + dp[i-1]) % mod
                } else if s[i-1] == "*" {
                    dp[i+1] = (dp[i+1] + (s[i] <= "6" ? 2 : 1) * dp[i-1]) % mod
                }
            }
        }

        return dp[n] % mod
    }
}