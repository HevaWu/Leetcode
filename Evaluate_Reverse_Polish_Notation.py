'''
Evaluate the value of an arithmetic expression in Reverse Polish Notation.

Valid operators are +, -, *, /. Each operand may be an integer or another expression.

Note:

Division between two integers should truncate toward zero.
The given RPN expression is always valid. That means the expression would always evaluate to a result and there won't be any divide by zero operation.
Example 1:

Input: ["2", "1", "+", "3", "*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9
Example 2:

Input: ["4", "13", "5", "/", "+"]
Output: 6
Explanation: (4 + (13 / 5)) = 6
Example 3:

Input: ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
Output: 22
Explanation:
  ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
= ((10 * (6 / (12 * -11))) + 17) + 5
= ((10 * (6 / -132)) + 17) + 5
= ((10 * 0) + 17) + 5
= (0 + 17) + 5
= 17 + 5
= 22
'''

'''
Solution 2:
stack

improvement to use int stack

TimeComplexity: O(n)
'''
class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        stack = []
        for t in tokens:
            if t == "+":
                num2 = stack.pop(-1)
                num1 = stack.pop(-1)
                stack.append(num1 + num2)
            elif t == "-":
                num2 = stack.pop(-1)
                num1 = stack.pop(-1)
                stack.append(num1 - num2)
            elif t == "*":
                num2 = stack.pop(-1)
                num1 = stack.pop(-1)
                stack.append(num1 * num2)
            elif t == "/":
                num2 = stack.pop(-1)
                num1 = stack.pop(-1)
                sign = -1 if num1 * num2 < 0 else 1
                stack.append(abs(num1) // abs(num2) * sign)
            else:
                stack.append(int(t))

        return stack.pop(-1)
