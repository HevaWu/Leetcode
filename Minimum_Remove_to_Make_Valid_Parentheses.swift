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
*/
class Solution {
    func minRemoveToMakeValid(_ s: String) -> String {
        let n = s.count
        
        var counter = 0
        var res = [Character]()
        
        for c in s {
            switch c {
            case ")":
                if counter > 0 {
                    counter -= 1
                    res.append(c)
                }
            case "(":
                counter += 1
                res.append(c)
            default:
                res.append(c)
            }
        }
        
        for i in stride(from: res.count-1, through: 0, by: -1) {
            if res[i] == "(", counter > 0 { 
                res.remove(at: i)
                counter -= 1
            }
            if counter == 0 { break }
        }
        
        return String(res)
    }
}

/*
Solution 1
find all invalid first,
then remove it at the end

Time Complexity: O(n+klogk)
- n is s.count
- k is all invalid char count

Space Complexity: O(n)
*/
class Solution {
    func minRemoveToMakeValid(_ s: String) -> String {
        var s = Array(s)
        let n = s.count
        
        // keep left parentheses ( stack
        var left = [Int]()
        var invalid = [Int]()
        
        for i in 0..<n {
            switch s[i] {
            case ")":
                if !left.isEmpty {
                    left.removeLast()
                } else {
                    invalid.append(i)
                }
            case "(":
                left.append(i)
            default:
                continue
            }
        }
        
        invalid.append(contentsOf: left)
        invalid.sort()
        
        for i in 0..<invalid.count {
            s.remove(at: invalid[i]-i)
        }
        
        return String(s)
    }
}