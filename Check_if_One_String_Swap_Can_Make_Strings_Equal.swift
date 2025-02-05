/*
You are given two strings s1 and s2 of equal length. A string swap is an operation where you choose two indices in a string (not necessarily different) and swap the characters at these indices.

Return true if it is possible to make both strings equal by performing at most one string swap on exactly one of the strings. Otherwise, return false.



Example 1:

Input: s1 = "bank", s2 = "kanb"
Output: true
Explanation: For example, swap the first character with the last character of s2 to make "bank".
Example 2:

Input: s1 = "attack", s2 = "defend"
Output: false
Explanation: It is impossible to make them equal with one string swap.
Example 3:

Input: s1 = "kelb", s2 = "kelb"
Output: true
Explanation: The two strings are already equal, so no string swap operation is required.


Constraints:

1 <= s1.length, s2.length <= 100
s1.length == s2.length
s1 and s2 consist of only lowercase English letters.
*/

/*
Solution 1:
Find first 2 difference character in s1 and s2
if there is more difference character, return false
At the end, check if s1 and s2 is equal after swap two chars

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func areAlmostEqual(_ s1: String, _ s2: String) -> Bool {
        var index1Diff = 0
        var index2Diff = 0
        var numDiffs = 0
        let n = s1.count
        var s1 = Array(s1)
        var s2 = Array(s2)
        for i in 0..<n {
            if s1[i] != s2[i] {
                numDiffs += 1
                if numDiffs > 2 {
                    return false
                } else if numDiffs == 1 {
                    index1Diff = i
                } else {
                    index2Diff = i
                }
            }
        }
        return s1[index1Diff] == s2[index2Diff]
        && s1[index2Diff] == s2[index1Diff]
    }
}
