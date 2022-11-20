'''
Given a string s representing a valid expression, implement a basic calculator to evaluate it, and return the result of the evaluation.

Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as eval().



Example 1:

Input: s = "1 + 1"
Output: 2
Example 2:

Input: s = " 2-1 + 2 "
Output: 3
Example 3:

Input: s = "(1+(4+5+2)-3)+(6+8)"
Output: 23


Constraints:

1 <= s.length <= 3 * 105
s consists of digits, '+', '-', '(', ')', and ' '.
s represents a valid expression.
'+' is not used as a unary operation.
'-' could be used as a unary operation but it has to be inside parentheses.
There will be no two consecutive operators in the input.
Every number and running calculation will fit in a signed 32-bit integer.
'''

'''
Solution 1:
iterative, stack
input is valid, parentheses are always paired and in order
( --- push the previous ret and sign into the stack, set the ret to 0, just calculate the new ret within the parentheses
) --- pop out the two numbers from stack, first one is the sign before this pair of parentheses, second is the temporary ret before this pair of parenthesis, add together

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def calculate(self, s: str) -> int:
        stack = []
        cur = 0
        sign = 1
        res = 0

        for c in list(s):
            if c == "+":
                res += cur * sign
                cur = 0
                sign = 1
            elif c == "-":
                res += cur * sign
                cur = 0
                sign = -1
            elif c == "(":
                stack.append(res)
                stack.append(sign)
                res = 0
                sign = 1
            elif c == ")":
                res += cur * sign
                res = res * stack.pop(-1)
                res += stack.pop(-1)
                cur = 0
            elif c.isnumeric():
                cur = cur * 10 + int(c)

        res += cur * sign
        return res
