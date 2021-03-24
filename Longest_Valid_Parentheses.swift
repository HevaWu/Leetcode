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
    func longestValidParentheses(_ s: String) -> Int {
        let n = s.count
        if n < 2 { return 0 }
        
        var s = Array(s)
        
        var left = 0
        var right = 0
        
        var valid = 0
        for i in 0..<n {
            if s[i] == "(" {
                left += 1
            } else {
                right += 1
            }
            
            if left == right {
                valid = max(valid, 2*right)
            } else if right > left {
                left = 0
                right = 0
            }
        }
        
        left = 0
        right = 0
        for i in stride(from: n-1, through: 0, by: -1) {
            if s[i] == "(" {
                left += 1
            } else {
                right += 1
            }
            
            if left == right {
                valid = max(valid, 2*right)
            } else if left > right {
                left = 0
                right = 0
            }
        }
        
        return valid
    }
}

/*
Solution 2:
Stack

- For every \text{‘(’}‘(’ encountered, we push its index onto the stack.
- For every \text{‘)’}‘)’ encountered, we pop the topmost element and subtract the current element's index from the top element of the stack, which gives the length of the currently encountered valid string of parentheses. If while popping the element, the stack becomes empty, we push the current element's index onto the stack. In this way, we keep on calculating the lengths of the valid substrings, and return the length of the longest valid string at the end.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func longestValidParentheses(_ s: String) -> Int {
        let n = s.count
        if n < 2 { return 0 }
        
        var s = Array(s)
        
        var left = [-1]
        var valid = 0
        for i in 0..<n {
            if s[i] == "(" {
                left.append(i)
            } else {
                left.removeLast()
                if !left.isEmpty {
                    valid = max(valid, i-left.last!)   
                } else {
                    left.append(i)
                }
            }
        }
        
        return valid
    }
}

/*
Solution 1:
DP

idea:
- s[i] = ")", s[i-1] = "("
	- dp[i] = dp[i-2] + 2
- s[i] = ")", s[i-1] = ")", s[i-dp[i-1]-1] = "("
	- dp[i] = dp[i-1] + dp[i-dp[i-1]-2] + 2

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func longestValidParentheses(_ s: String) -> Int {
        let n = s.count
        if n < 2 { return 0 }
        
        var s = Array(s)
        
        // dp[i] longest valid substring end with i
        var dp = Array(repeating: 0, count: n)
        var valid = 0
        for i in 1..<n {
            if s[i] == ")" {
                if s[i-1] == "(" {
                    dp[i] = (i >= 2 ? dp[i-2] : 0) + 2
                    
                } else if s[i-1] == ")", 
                i-dp[i-1] > 0, 
                s[i-dp[i-1]-1] == "(" {
                    dp[i] = dp[i-1] 
                    + (i - dp[i-1] >= 2 ? dp[i-dp[i-1]-2] : 0) 
                    + 2
                }
                valid = max(valid, dp[i])
            }
        }
        
        return valid
    }
}