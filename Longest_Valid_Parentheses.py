'''
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
'''

'''
Solution 3:
constant space
2 pointer

we make use of two counters leftleft and rightright. First, we start traversing the string from the left towards the right and for every ‘(’ encountered, we increment the leftleft counter and for every ‘)’ encountered, we increment the rightright counter. Whenever leftleft becomes equal to rightright, we calculate the length of the current valid string and keep track of maximum length substring found so far. If rightright becomes greater than leftleft we reset leftleft and rightright to 00.

Time Complexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def longestValidParentheses(self, s: str) -> int:
        n = len(s)

        l = 0
        r = 0
        valid = 0

        for i in range(n):
            if s[i] == "(":
                l += 1
            else:
                r += 1

            if l == r:
                valid = max(valid, 2*r)
            elif r > l:
                l = 0
                r = 0

        l = 0
        r = 0
        for i in range(n-1, -1, -1):
            if s[i] == "(":
                l += 1
            else:
                r += 1

            if l == r:
                valid = max(valid, 2*r)
            elif l > r:
                l = 0
                r = 0

        return valid
