// Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

// An input string is valid if:

// Open brackets must be closed by the same type of brackets.
// Open brackets must be closed in the correct order.
// Note that an empty string is also considered valid.

// Example 1:

// Input: "()"
// Output: true
// Example 2:

// Input: "()[]{}"
// Output: true
// Example 3:

// Input: "(]"
// Output: false
// Example 4:

// Input: "([)]"
// Output: false
// Example 5:

// Input: "{[]}"
// Output: true

// Hint
// An interesting property about a valid parenthesis expression is that a sub-expression of a valid expression should also be a valid expression. (Not every sub-expression) e.g.
// { { } [ ] [ [ [ ] ] ] } is VALID expression
//           [ [ [ ] ] ]    is VALID sub-expression
//   { } [ ]                is VALID sub-expression
// Can we exploit this recursive structure somehow?
// 
// What if whenever we encounter a matching pair of parenthesis in the expression, we simply remove it from the expression? This would keep on shortening the expression. e.g.
// { { ( { } ) } }
//       |_|
// { { (      ) } }
//     |______|
// { {          } }
//   |__________|
// {                }
// |________________|
// VALID EXPRESSION!
// 
// The stack data structure can come in handy here in representing this recursive structure of the problem. We can't really process this from the inside out because we don't have an idea about the overall structure. But, the stack can help us process this recursively i.e. from outside to inwards.

// Solution 1: Stack 
// use leftArr to save finded left part
// use closeSet for checking right part
// everytime when this char is left part, put it into leftArr
// if this char is right part, pop the left last one, if it is not match, return false
// at the end, checking if leftArr is empty is enough
// 
// TimeComplexity: O(n) because we simply traverse the given string one character at a time and push and pop operations on a stack take O(1) time.
// SpaceComplexity: O(n) as we push all opening brackets onto the stack and in the worst case, we will end up pushing all the brackets onto the stack. e.g. ((((((((((.
class Solution {
    func isValid(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        guard s.count > 1 else { return false }
        
        var s = Array(s)
        
        var leftArr = [Character]() 
        var closeSet: Set<Character> = [")", "]", "}"]
        
        var right = 0
        
        while right < s.count {
            let char = s[right]
            if closeSet.contains(char) {
                guard right > 0, !leftArr.isEmpty else { return false }
                let leftChar = leftArr.removeLast()
                
                // check the char, and remove its correspond pair
                switch char {
                case ")":
                    if leftChar != "(" { return false }
                case "]":
                    if leftChar != "[" { return false }
                case "}":
                    if leftChar != "{" { return false }
                default:
                    break
                }
            } else {
                leftArr.append(char)
            }
            right += 1
        }
        
        return leftArr.isEmpty
    }
}

class Solution {
    func isValid(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        guard s.count > 1 else { return false }
        
        var s = Array(s)
        
        var dic: [Character: Character] = [")": "(", "}": "{", "]": "["]
        var leftArr = [Character]() 
        
        var right = 0
        
        while right < s.count {
            let char = s[right]
            if dic.keys.contains(char) {
                guard !leftArr.isEmpty else { return false }
                guard dic[char] == leftArr.removeLast() else { return false}
            } else {
                leftArr.append(char)
            }
            right += 1
        }
        
        return leftArr.isEmpty
    }
}
