/*
Given a string s which represents an expression, evaluate this expression and return its value. 

The integer division should truncate toward zero.

 

Example 1:

Input: s = "3+2*2"
Output: 7
Example 2:

Input: s = " 3/2 "
Output: 1
Example 3:

Input: s = " 3+5 / 2 "
Output: 5
 

Constraints:

1 <= s.length <= 3 * 105
s consists of integers and operators ('+', '-', '*', '/') separated by some number of spaces.
s represents a valid expression.
All the integers in the expression are non-negative integers in the range [0, 231 - 1].
The answer is guaranteed to fit in a 32-bit integer.
*/

/*
Solution 2: 
Optimize solution 1, use constant space

- Instead of using a stack, we use a variable lastNumber to track the value of the last evaluated expression.
- If the operation is Addition (+) or Subtraction (-), add the lastNumber to the result instead of pushing it to the stack. The currentNumber would be updated to lastNumber for the next iteration.
- If the operation is Multiplication (*) or Division (/), we must evaluate the expression lastNumber * currentNumber and update the lastNumber with the result of the expression. This would be added to the result after the entire string is scanned.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func calculate(_ s: String) -> Int {
        if s.count == 1 { return Int(s)! }
        var s = Array(s)
        
        var res = 0
        var lastNum = 0
        var cur: Int = 0
        var operation: Character = "+"
        for i in 0..<s.count {
            let c = s[i]
            if let val = c.wholeNumberValue {
                cur = cur*10 + val
            }
            
            if (!c.isNumber && c != " ") || i == s.count-1 {
                switch operation {
                case "+":
                    // add lastNum
                    res += lastNum
                    lastNum = cur
                case "-":
                    res += lastNum
                    lastNum = -cur
                case "*":
                    // update lastNum
                    lastNum = lastNum * cur
                case "/":
                    lastNum = lastNum / cur
                default:
                    break
                }
                operation = c
                cur = 0
            }
        }
        
        res += lastNum
        return res
    }
}

/*
Solution 1:
stack

1. If the current character is a digit 0-9 ( operand ), add it to the number currentNumber.
2. Otherwise, the current character must be an operation (+,-,*, /). Evaluate the expression based on the type of operation.

- Addition (+) or Subtraction (-): We must evaluate the expression later based on the next operation. So, we must store the currentNumber to be used later. Let's push the currentNumber in the Stack.
- Multiplication (*) or Division (/): Pop the top values from the stack and evaluate the current expression. Push the evaluated value back to the stack.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func calculate(_ s: String) -> Int {
        if s.count == 1 { return Int(s)! }
        var s = Array(s)
        
        var stack = [Int]()
        var cur: Int = 0
        var operation: Character = "+"
        for i in 0..<s.count {
            let c = s[i]
            if let val = c.wholeNumberValue {
                cur = cur*10 + val
            }
            
            if (!c.isNumber && c != " ") || i == s.count-1 {
                switch operation {
                case "+":
                    stack.append(cur)
                case "-":
                    stack.append(-cur)
                case "*":
                    let temp = stack.removeLast()
                    stack.append(temp*cur)
                case "/":
                    let temp = stack.removeLast()
                    stack.append(temp/cur)
                default:
                    break
                }
                operation = c
                cur = 0
            }
        }
        
        var res = 0
        while !stack.isEmpty {
            res += stack.removeLast()
        }
        return res
    }
}