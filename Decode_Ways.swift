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

Given a string s containing only digits, return the number of ways to decode it.

The answer is guaranteed to fit in a 32-bit integer.

 

Example 1:

Input: s = "12"
Output: 2
Explanation: "12" could be decoded as "AB" (1 2) or "L" (12).
Example 2:

Input: s = "226"
Output: 3
Explanation: "226" could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).
Example 3:

Input: s = "0"
Output: 0
Explanation: There is no character that is mapped to a number starting with 0.
The only valid mappings with 0 are 'J' -> "10" and 'T' -> "20", neither of which start with 0.
Hence, there are no valid ways to decode this since all digits need to be mapped.
Example 4:

Input: s = "06"
Output: 0
Explanation: "06" cannot be mapped to "F" because of the leading zero ("6" is different from "06").
 

Constraints:

1 <= s.length <= 100
s contains only digits and may contain leading zero(s).
*/

/*
Solution 2:
optimize solution 1

use constant space

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func numDecodings(_ s: String) -> Int {
        var s = Array(s)
        if s[0] == "0" { return 0 }
        
        let n = s.count
        if n == 1 { return 1 }
        
        var oneDigit = 1
        var twoDigit = 1
        
        for i in 2...n {
            var temp = 0
            
            let first = s[i-1].wholeNumberValue!
            let second = first + (s[i-2].wholeNumberValue!*10)
            
            if first >= 1, first <= 9 {
                temp += oneDigit
            }
            if second >= 10, second <= 26 {
                temp += twoDigit
            }
            
            twoDigit = oneDigit
            oneDigit = temp
            // print(i, first, second, dp)
        }
        
        return oneDigit
    }
}

/*
Solution 1:
DP

dp[0] means empty string
dp[1] means only decode s[0]

iteratively check dp[i] by s[i-1...i] && s[i-2...i]

Time ComplexityL: O(n)
Space Complexity: O(n)
*/
class Solution {
    func numDecodings(_ s: String) -> Int {
        var s = Array(s)
        if s[0] == "0" { return 0 }
        
        let n = s.count
        if n == 1 { return 1 }
        
        var dp = Array(repeating: 0, count: n+1)
        dp[0] = 1
        dp[1] = 1
        
        for i in 2...n {
            let first = s[i-1].wholeNumberValue!
            let second = first + (s[i-2].wholeNumberValue!*10)
            
            if first >= 1, first <= 9 {
                dp[i] += dp[i-1]
            }
            if second >= 10, second <= 26 {
                dp[i] += dp[i-2]
            }
            // print(i, first, second, dp)
        }
        
        return dp[n]
    }
}