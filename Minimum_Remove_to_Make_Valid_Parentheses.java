/*
Given a string s of '(' , ')' and lowercase English characters.

Your task is to remove the minimum number of parentheses ( '(' or ')', in any positions ) so that the resulting parentheses string is valid and return any valid string.

Formally, a parentheses string is valid if and only if:

It is the empty string, contains only lowercase characters, or
It can be written as AB (A concatenated with B), where A and B are valid strings, or
It can be written as (A), where A is a valid string.


Example 1:

Input: s = "lee(t(c)o)de)"
Output: "lee(t(c)o)de"
Explanation: "lee(t(co)de)" , "lee(t(c)ode)" would also be accepted.
Example 2:

Input: s = "a)b(c)d"
Output: "ab(c)d"
Example 3:

Input: s = "))(("
Output: ""
Explanation: An empty string is also valid.
Example 4:

Input: s = "(a(b(c)d)"
Output: "a(b(c)d)"


Constraints:

1 <= s.length <= 10^5
s[i] is one of  '(' , ')' and lowercase English letters.

*/

/*
Solution 2
optimize solution 1

use counter to check left (

Time Complexity: O(n)
Space Complexity: O(1)
*/class Solution {
    public String minRemoveToMakeValid(String s) {
        StringBuilder strb = new StringBuilder();
        int counter = 0;
        for(int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '(':
                    counter += 1;
                    strb.append(c);
                    continue;
                case ')':
                    if (counter > 0) {
                        counter -= 1;
                        strb.append(c);
                    }
                    continue;
                default:
                    strb.append(c);
            }
        }

        if (counter == 0) {
            return strb.toString();
        }

        int i = strb.length()-1;
        while (counter > 0 && i >= 0) {
            if (strb.charAt(i) == '(') {
                counter -= 1;
                strb.deleteCharAt(i);
            }
            i -= 1;
        }
        return strb.toString();
    }
}
