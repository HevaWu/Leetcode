/*
Given two strings word1 and word2, return the minimum number of steps required to make word1 and word2 the same.

In one step, you can delete exactly one character in either string.



Example 1:

Input: word1 = "sea", word2 = "eat"
Output: 2
Explanation: You need one step to make "sea" to "ea" and another step to make "eat" to "ea".
Example 2:

Input: word1 = "leetcode", word2 = "etco"
Output: 4


Constraints:

1 <= word1.length, word2.length <= 500
word1 and word2 consist of only lowercase English letters.
*/

/*
Solution 1:
DP

Idea:
- this problem is similar as solving find "maximum common characters between word1 and word2"
- for get minimum step, we first find maximum common chars between word1 and word2, and keep characters order same as original
- then, return (word1+word2 length - 2*dp[n1-1][n2-1]) should be okay

dp[i][j] is maximum common chars between word1[0...i] and word2[0...j]

Time Complexity: O(n1*n2)
Space Complexity: O(n1*n2)
*/
class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let n1 = word1.count
        let n2 = word2.count

        var word1 = Array(word1)
        var word2 = Array(word2)

        // dp[i][j] -> common letters between word1[0...i] and word2[0...j]
        var dp = Array(
            repeating: Array(repeating: 0, count: n2),
            count: n1
        )

        for i in 0..<n1 {
            for j in 0..<n2 {
                if word1[i] == word2[j] {
                    dp[i][j] = (i > 0 && j > 0 ? dp[i-1][j-1] : 0) + 1
                } else {
                    dp[i][j] = max(
                        i > 0 ? dp[i-1][j] : 0,
                        j > 0 ? dp[i][j-1] : 0
                    )
                }
            }
        }

        // n1+n2 total characters in word1 and word2
        // dp[n1-1][n2-1] is maximum common characters in word1 and word2
        // for find minimum number of steps, return n1 + n2 - 2*dp[n1-1][n2-1]
        return n1 + n2 - 2*dp[n1-1][n2-1]
    }
}