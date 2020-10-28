// Given two strings s1, s2, find the lowest ASCII sum of deleted characters to make two strings equal.

// Example 1:
// Input: s1 = "sea", s2 = "eat"
// Output: 231
// Explanation: Deleting "s" from "sea" adds the ASCII value of "s" (115) to the sum.
// Deleting "t" from "eat" adds 116 to the sum.
// At the end, both strings are equal, and 115 + 116 = 231 is the minimum sum possible to achieve this.
// Example 2:
// Input: s1 = "delete", s2 = "leet"
// Output: 403
// Explanation: Deleting "dee" from "delete" to turn the string into "let",
// adds 100[d]+101[e]+101[e] to the sum.  Deleting "e" from "leet" adds 101[e] to the sum.
// At the end, both strings are equal to "let", and the answer is 100+101+101+101 = 403.
// If instead we turned both strings into "lee" or "eet", we would get answers of 433 or 417, which are higher.
// Note:

// 0 < s1.length, s2.length <= 1000.
// All elements of each string will have an ASCII value in [97, 122].

/* Solution 1:
DP

dp[i][j] is the cost for s1.substr(0,i) and s2.substr(0, j). Note s1[i], s2[j] not included in the substring.

Base case: dp[0][0] = 0
target: dp[m][n]

if s1[i-1] = s2[j-1]   // no deletion
    dp[i][j] = dp[i-1][j-1];
else   // delete either s1[i-1] or s2[j-1]
    dp[i][j] = min(dp[i-1][j]+s1[i-1], dp[i][j-1]+s2[j-1]);

Time complexity: O(mn)
*/
class Solution {
    func minimumDeleteSum(_ s1: String, _ s2: String) -> Int {
        let s1 = Array(s1)
        let s2 = Array(s2)
        let m = s1.count
        let n = s2.count
        
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
        for j in 1...n {
            dp[0][j] = dp[0][j-1] + Int(s2[j-1].asciiValue!)
        }
        for i in 1...m {
            dp[i][0] = dp[i-1][0] + Int(s1[i-1].asciiValue!)
            for j in 1...n {
                if s1[i-1] == s2[j-1] {
                    dp[i][j] = dp[i-1][j-1]
                } else {
                    dp[i][j] = min(
                        dp[i-1][j] + Int(s1[i-1].asciiValue!),
                        dp[i][j-1] + Int(s2[j-1].asciiValue!)
                    )
                }
            }
        }
        
        return dp[m][n]
    }
}

/* Solution 2
Optimize to use n space dp
TimeComplexity: O(mn)
Space: O(n)
*/
class Solution {
    func minimumDeleteSum(_ s1: String, _ s2: String) -> Int {
        let s1 = Array(s1)
        let s2 = Array(s2)
        let m = s1.count
        let n = s2.count
        
        var dp: [Int] = Array(repeating: 0, count: n+1)
        for j in 1...n {
            dp[j] = dp[j-1] + Int(s2[j-1].asciiValue!)
        }
        for i in 1...m {
            var temp = dp[0]
            dp[0] += Int(s1[i-1].asciiValue!)
            for j in 1...n {
                var pre = dp[j]
                if s1[i-1] == s2[j-1] {
                    dp[j] = temp
                } else {
                    dp[j] = min(
                        dp[j] + Int(s1[i-1].asciiValue!),
                        dp[j-1] + Int(s2[j-1].asciiValue!)
                    )
                }
                temp = pre
            }
        }
        
        return dp[n]
    }
}