/*
Given two strings s and t, return true if s is a subsequence of t, or false otherwise.

A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).



Example 1:

Input: s = "abc", t = "ahbgdc"
Output: true
Example 2:

Input: s = "axc", t = "ahbgdc"
Output: false


Constraints:

0 <= s.length <= 100
0 <= t.length <= 104
s and t consist only of lowercase English letters.


Follow up: Suppose there are lots of incoming s, say s1, s2, ..., sk where k >= 109, and you want to check one by one to see if t has its subsequence. In this scenario, how would you change your code?
*/

/*
Solution 1:
iterate two string, see if can map them until end of s

Time Complexity: O(max(ns, nt))
Space Complexity: O(ns + nt)
*/
class Solution {
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        var s = Array(s)
        var si = 0
        var sn = s.count
        if sn == 0, t.count == 0 {
            return true
        }
        if t.count < sn {
            return false
        }

        for ti in t.indices {
            if si < sn, s[si] == t[ti] {
                si += 1
            }
            if si == sn {
                return true
            }
        }
        return false
    }
}
