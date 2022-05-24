/*
Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.



Example 1:

Input: s = "(()"
Output: 2
Explanation: The longest valid parentheses substring is "()".
Example 2:

Input: s = ")()())"
Output: 4
Explanation: The longest valid parentheses substring is "()()".
Example 3:

Input: s = ""
Output: 0


Constraints:

0 <= s.length <= 3 * 104
s[i] is '(', or ')'.
*/

/*
Solution 3:
constant space
2 pointer

we make use of two counters leftleft and rightright. First, we start traversing the string from the left towards the right and for every ‘(’ encountered, we increment the leftleft counter and for every ‘)’ encountered, we increment the rightright counter. Whenever leftleft becomes equal to rightright, we calculate the length of the current valid string and keep track of maximum length substring found so far. If rightright becomes greater than leftleft we reset leftleft and rightright to 00.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public int longestValidParentheses(String s) {
        int l = 0;
        int r = 0;
        int n = s.length();

        int valid = 0;
        for(int i = 0; i < n; i++) {
            if (s.charAt(i) == '(') {
                l += 1;
            } else {
                r += 1;
            }

            if (l == r) {
                valid = Math.max(valid, 2*r);
            } else if (r > l) {
                l = 0;
                r = 0;
            }
        }

        l = 0;
        r = 0;
        for (int i = n-1; i >= 0; i--) {
            if (s.charAt(i) == '(') {
                l += 1;
            } else {
                r += 1;
            }

            if (l == r) {
                valid = Math.max(valid, 2 * r);
            } else if (l > r) {
                l = 0;
                r = 0;
            }
        }

        return valid;
    }
}