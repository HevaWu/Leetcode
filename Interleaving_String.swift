/*
Given strings s1, s2, and s3, find whether s3 is formed by an interleaving of s1 and s2.

An interleaving of two strings s and t is a configuration where they are divided into non-empty substrings such that:

s = s1 + s2 + ... + sn
t = t1 + t2 + ... + tm
|n - m| <= 1
The interleaving is s1 + t1 + s2 + t2 + s3 + t3 + ... or t1 + s1 + t2 + s2 + t3 + s3 + ...
Note: a + b is the concatenation of strings a and b.



Example 1:


Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
Output: true
Example 2:

Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
Output: false
Example 3:

Input: s1 = "", s2 = "", s3 = ""
Output: true


Constraints:

0 <= s1.length, s2.length <= 100
0 <= s3.length <= 200
s1, s2, and s3 consist of lowercase English letters.


Follow up: Could you solve it using only O(s2.length) additional memory space?
*/

/*
Solution 3:
DP 1d array

memo dp[j] for checking if pick s2 element

Time Complexity: O(n1*n2)
Space Complexity: O(n2)
*/
class Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let n1 = s1.count
        let n2 = s2.count
        let n3 = s3.count

        if n1+n2 != n3 { return false }
        if n3 == 0 {
            return n1 == 0 && n2 == 0
        }

        if n1 == 0 {
            return s2 == s3
        }

        if n2 == 0 {
            return s1 == s3
        }

        var s1 = Array(s1)
        var s2 = Array(s2)
        var s3 = Array(s3)

        var dp = Array(repeating: false, count: n2+1)
        dp[0] = true

        for i in 0...n1 {
            for j in 0...n2 {
                if i == 0, j > 0 {
                    // only pick s2 element
                    dp[j] = dp[j-1] && s2[j-1] == s3[i+j-1]
                } else if j == 0, i > 0 {
                    // only pick s1 element
                    dp[j] = dp[j] && s1[i-1] == s3[i+j-1]
                } else if i > 0, j > 0 {
                    dp[j] = (dp[j] && s1[i-1] == s3[i+j-1])
                    || (dp[j-1] && s2[j-1] == s3[i+j-1])
                }
            }
        }

        return dp[n2]
    }
}

/*
Solution 2:
DP 2d array

dp[i][j], s1[0...i], s2[0...j] can make interleave s3[i+j]

dp[i][j] = (dp[i-1][j] && s1[i-1] == s3[i+j-1])
|| (dp[i][j-1] && s2[j-1] == s3[i+j-1])

Time Complexity: O(n1 * n2)
Space Complexity: O(n1 * n2)
*/
class Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let n1 = s1.count
        let n2 = s2.count
        let n3 = s3.count

        if n1+n2 != n3 { return false }
        if n3 == 0 {
            return n1 == 0 && n2 == 0
        }

        if n1 == 0 {
            return s2 == s3
        }

        if n2 == 0 {
            return s1 == s3
        }

        var s1 = Array(s1)
        var s2 = Array(s2)
        var s3 = Array(s3)

        var dp: [[Bool]] = Array(repeating: Array(repeating: false, count: n2+1),
                                 count: n1+1)
        dp[0][0] = true

        for j in 1...n2 {
            dp[0][j] = dp[0][j-1] && s2[j-1] == s3[j-1]
        }

        for i in 1...n1 {
            dp[i][0] = dp[i-1][0] && s1[i-1] == s3[i-1]
        }

        for i in 1...n1 {
            for j in 1...n2 {
                dp[i][j] = (dp[i-1][j] && s1[i-1] == s3[i+j-1])
                || (dp[i][j-1] && s2[j-1] == s3[i+j-1])
            }
        }

        return dp[n1][n2]
    }
}

/*
Solution 1:
recursion with memoization

Time Complexity: O(n1*n2)
Space Complexity: O(n1*n2)
*/
class Solution {
    func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
        let n1 = s1.count
        let n2 = s2.count
        let n3 = s3.count

        if n1+n2 != n3 { return false }
        if n3 == 0 {
            return n1 == 0 && n2 == 0
        }

        var memo: [[Bool?]] = Array(repeating: Array(repeating: nil, count: n2),
                                    count: n1)
        return _isInterleave(Array(s1), 0, n1,
                             Array(s2), 0, n2,
                             Array(s3), 0, n3,
                             &memo)
    }

    func _isInterleave(_ s1: [Character], _ is1: Int, _ n1: Int,
                       _ s2: [Character], _ is2: Int, _ n2: Int,
                       _ s3: [Character], _ is3: Int, _ n3: Int,
                       _ memo: inout [[Bool?]]) -> Bool {
        if is1 == n1 {
            return s2[is2...] == s3[is3...]
        }

        if is2 == n2 {
            return s1[is1...] == s3[is3...]
        }

        if let val = memo[is1][is2] {
            return val
        }

        var res = false
        if (s3[is3] == s1[is1]
            && _isInterleave(s1, is1+1, n1, s2, is2, n2, s3, is3+1, n3, &memo))
        || (s3[is3] == s2[is2]
            && _isInterleave(s1, is1, n1, s2, is2+1, n2, s3, is3+1, n3, &memo)) {
            res = true
        }

        memo[is1][is2] = res
        return res
    }
}