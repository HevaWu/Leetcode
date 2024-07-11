/*
You are given a string s that consists of lower case English letters and brackets.

Reverse the strings in each pair of matching parentheses, starting from the innermost one.

Your result should not contain any brackets.



Example 1:

Input: s = "(abcd)"
Output: "dcba"
Example 2:

Input: s = "(u(love)i)"
Output: "iloveu"
Explanation: The substring "love" is reversed first, then the whole string is reversed.
Example 3:

Input: s = "(ed(et(oc))el)"
Output: "leetcode"
Explanation: First, we reverse the substring "oc", then "etco", and finally, the whole string.


Constraints:

1 <= s.length <= 2000
s only contains lower case English characters and parentheses.
It is guaranteed that all parentheses are balanced.
*/

/*
Solution 1:
Iterate string, keep record current string (wait for reverse)

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func reverseParentheses(_ s: String) -> String {
        var stack = [[Character]]()
        var cur = [Character]()
        for c in s {
            switch c {
            case Character("("):
                stack.append(cur)
                cur = [Character]()
            case Character(")"):
                cur.reverse()
                var last = stack.removeLast()
                last.append(contentsOf: cur)
                cur = last
            default:
                cur.append(c)
            }
        }
        return String(cur)
    }
}
