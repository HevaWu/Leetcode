/*
A valid parentheses string is either empty "", "(" + A + ")", or A + B, where A and B are valid parentheses strings, and + represents string concatenation.

For example, "", "()", "(())()", and "(()(()))" are all valid parentheses strings.
A valid parentheses string s is primitive if it is nonempty, and there does not exist a way to split it into s = A + B, with A and B nonempty valid parentheses strings.

Given a valid parentheses string s, consider its primitive decomposition: s = P1 + P2 + ... + Pk, where Pi are primitive valid parentheses strings.

Return s after removing the outermost parentheses of every primitive string in the primitive decomposition of s.



Example 1:

Input: s = "(()())(())"
Output: "()()()"
Explanation:
The input string is "(()())(())", with primitive decomposition "(()())" + "(())".
After removing outer parentheses of each part, this is "()()" + "()" = "()()()".
Example 2:

Input: s = "(()())(())(()(()))"
Output: "()()()()(())"
Explanation:
The input string is "(()())(())(()(()))", with primitive decomposition "(()())" + "(())" + "(()(()))".
After removing outer parentheses of each part, this is "()()" + "()" + "()(())" = "()()()()(())".
Example 3:

Input: s = "()()"
Output: ""
Explanation:
The input string is "()()", with primitive decomposition "()" + "()".
After removing outer parentheses of each part, this is "" + "" = "".


Constraints:

1 <= s.length <= 105
s[i] is either '(' or ')'.
s is a valid parentheses string.
*/

/*
Solution 1:
use l to help checking the cur primitive string (The number of ( and ) characters must be equal.)
Then append and remove the outer parentheses

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func removeOuterParentheses(_ s: String) -> String {
        var l = 0
        var cur = [Character]()
        var res = ""
        for c in s {
            if c == Character("(") {
                l += 1
                cur.append(c)
            } else if c == Character(")") {
                l -= 1
                cur.append(c)
                if l == 0 {
                    res += removeOuter(cur)
                    cur = [Character]()
                }
            }
        }
        return res
    }

    func removeOuter(_ cur: [Character]) -> String {
        var cur = cur
        cur.removeFirst()
        cur.removeLast()
        return String(cur)
    }
}
