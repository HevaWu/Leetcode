/*
Given a balanced parentheses string S, compute the score of the string based on the following rule:

() has score 1
AB has score A + B, where A and B are balanced parentheses strings.
(A) has score 2 * A, where A is a balanced parentheses string.
 

Example 1:

Input: "()"
Output: 1
Example 2:

Input: "(())"
Output: 2
Example 3:

Input: "()()"
Output: 2
Example 4:

Input: "(()(()))"
Output: 6
 

Note:

S is a balanced parentheses string, containing only ( and ).
2 <= S.length <= 50
*/

/*
Solution 2
count scores

The final sum will be a sum of powers of 2, as every core (a substring (), with score 1) will have it's score multiplied by 2 for each exterior set of parentheses that contains that core.

Keep track of the balance of the string, as defined in Approach #1. For every ) that immediately follows a (, the answer is 1 << balance, as balance is the number of exterior set of parentheses that contains this core.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func scoreOfParentheses(_ S: String) -> Int {        
        var res = 0
        
        var left = 0
        
        var S = Array(S)
        for i in 0..<S.count {
            if S[i] == "(" {
                left += 1
            } else {
                left -= 1
                if i > 0, S[i-1] == "(" {
                    res += 1 << left
                }
            }
        }
        
        return res
    }
}

/*
Solution 1
stack

Every position in the string has a depth - some number of matching parentheses surrounding it. For example, the dot in (()(.())) has depth 2, because of these parentheses: (__(.__))

Our goal is to maintain the score at the current depth we are on. When we see an opening bracket, we increase our depth, and our score at the new depth is 0. When we see a closing bracket, we add twice the score of the previous deeper part - except when counting (), which has a score of 1.

For example, when counting (()(())), our stack will look like this:

[0, 0] after parsing (
[0, 0, 0] after (
[0, 1] after )
[0, 1, 0] after (
[0, 1, 0, 0] after (
[0, 1, 1] after )
[0, 3] after )
[6] after )

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func scoreOfParentheses(_ S: String) -> Int {        
        var stack: [Int] = [0]
        
        for c in S {
            if c == "(" {
                stack.append(0)
            } else if c == ")" {
                let v = stack.removeLast()
                let w = stack.removeLast()
                stack.append(w + max(v*2, 1))
            }
        }
        
        return stack[0]
    }
}