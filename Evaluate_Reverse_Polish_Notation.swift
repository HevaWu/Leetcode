/*
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
*/

/*
Solution 2:
stack

improvement to use int stack

TimeComplexity: O(n)
*/
class Solution {
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for t in tokens {
            switch t {
            case "+":
                let second = stack.removeLast()
                let first = stack.removeLast()
                stack.append(first + second)
            case "-":
                let second = stack.removeLast()
                let first = stack.removeLast()
                stack.append(first - second)
            case "*":
                let second = stack.removeLast()
                let first = stack.removeLast()
                stack.append(first * second)
            case "/":
                let second = stack.removeLast()
                let first = stack.removeLast()
                stack.append(first / second)
            default:
                stack.append(Int(t)!)
            }
        }
        return stack.removeLast()
    }
}

/*
Solution 1:
Stack

start from tokens,
if we found an operator, do operation with its previous 2 num, and append new num into stack
if current is not an operator, directly push num into stack
*/
class Solution {
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [String]()
        let operatorSet = Set(["+","-","*","/"])
        for i in 0..<tokens.count {
            stack.append(tokens[i])
            while !stack.isEmpty {
                let _last = stack.last!
                if operatorSet.contains(_last) {
                    // can do operation
                    guard stack.count >= 3 else { return 0 }
                    
                    var temp = 0
                    // remove operator one
                    stack.removeLast()
                    let second = Int(stack.removeLast())!
                    let first = Int(stack.removeLast())!
                    
                    switch _last {
                    case "+": 
                        temp = first + second
                    case "-": 
                        temp = first - second
                    case "*":
                        temp = first * second
                    case "/":
                        temp = first / second
                    default:
                        // wrong operation
                        return 0
                    }
                    stack.append(String(temp))
                } else {
                    break
                }
            }
        }
        
        return stack.count == 1 ? Int(stack[0]) ?? 0 : 0
    }
}