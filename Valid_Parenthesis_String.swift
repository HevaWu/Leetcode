/*
Given a string s containing only three types of characters: '(', ')' and '*', return true if s is valid.

The following rules define a valid string:

Any left parenthesis '(' must have a corresponding right parenthesis ')'.
Any right parenthesis ')' must have a corresponding left parenthesis '('.
Left parenthesis '(' must go before the corresponding right parenthesis ')'.
'*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string "".


Example 1:

Input: s = "()"
Output: true
Example 2:

Input: s = "(*)"
Output: true
Example 3:

Input: s = "(*))"
Output: true


Constraints:

1 <= s.length <= 100
s[i] is '(', ')' or '*'.
*/

/*
Solution 1:
greedy
keep track '(', '*'
the min/max open parenthesis

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func checkValidString(_ s: String) -> Bool {
        var lmin = 0
        var lmax = 0
        for c in s {
            if c == Character("(") {
                lmin += 1
                lmax += 1
            } else if c == Character(")") {
                lmin -= 1
                lmax -= 1
            } else {
                lmin -= 1
                lmax += 1
            }
            if lmax < 0 { return false }
            lmin = max(0, lmin)
        }
        return lmin == 0
    }
}
