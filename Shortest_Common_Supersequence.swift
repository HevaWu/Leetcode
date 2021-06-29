/*
Given two strings str1 and str2, return the shortest string that has both str1 and str2 as subsequences.  If multiple answers exist, you may return any of them.

(A string S is a subsequence of string T if deleting some number of characters from T (possibly 0, and the characters are chosen anywhere from T) results in the string S.)



Example 1:

Input: str1 = "abac", str2 = "cab"
Output: "cabac"
Explanation:
str1 = "abac" is a subsequence of "cabac" because we can delete the first "c".
str2 = "cab" is a subsequence of "cabac" because we can delete the last "ac".
The answer provided is the shortest such string that satisfies these properties.


Note:

1 <= str1.length, str2.length <= 1000
str1 and str2 consist of lowercase English letters.
*/

/*
Solution 1:
Longest Common Sequence

find longest common sequence `String` of str1 and str2
then iteratively build super sequence

Time Complexity: O(n1 * n2)
Space Complexity: O(n1 * n2)
*/
class Solution {
    func shortestCommonSupersequence(_ str1: String, _ str2: String) -> String {
        var str1 = Array(str1)
        var str2 = Array(str2)

        let common = LCS(str1, str2)
        // print(common)

        var res = String()
        var i1 = 0
        var i2 = 0
        let n1 = str1.count
        let n2 = str2.count

        for c in common {
            while i1 < n1, str1[i1] != c {
                res.append(str1[i1])
                i1 += 1
            }

            while i2 < n2, str2[i2] != c {
                res.append(str2[i2])
                i2 += 1
            }
            res.append(c)
            i1 += 1
            i2 += 1
        }

        // add remaining
        if i1 < n1 {
            res.append(contentsOf: str1[i1...])
        }

        if i2 < n2 {
            res.append(contentsOf: str2[i2...])
        }

        return res
    }

    // longest common sequence between str1 and str2
    func LCS(_ str1: [Character], _ str2: [Character]) -> String {
        let n1 = str1.count
        let n2 = str2.count

        // dp[i][j] means lcs of str1[0...i], str2[0...j]
        var dp = Array(
            repeating: Array(repeating: String(), count: n2+1),
            count: n1+1
        )

        for i in 0..<n1 {
            for j in 0..<n2 {
                if str1[i] == str2[j] {
                    dp[i+1][j+1] = dp[i][j] + String(str1[i])
                } else {
                    dp[i+1][j+1] = dp[i][j+1].count > dp[i+1][j].count ? dp[i][j+1] : dp[i+1][j]
                }
            }
        }

        return dp[n1][n2]
    }
}