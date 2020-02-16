// Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

// For example, given n = 3, a solution set is:

// [
//   "((()))",
//   "(()())",
//   "(())()",
//   "()(())",
//   "()()()"
// ]

// Solution 1: 2 pointer
// 2 pointer for left & right
// add ( when left > 0
// add ) when right > 0
// return until left == right == 0
// 
// Time complexity:Time Complexity : O(\dfrac{4^n}{\sqrt{n}}). Each valid sequence has at most n steps during the backtracking procedure.
// Space Complexity : O(\dfrac{4^n}{\sqrt{n}}), as described above, and using O(n)O(n) space to store the sequence.
class Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        guard n > 0 else { return [String]() }
        var res = [String]()
        check(&res, "", n, 0)
        return res
    }
    
    private func check(_ res: inout [String], _ str: String, _ left: Int, _ right: Int) {
        if left == 0, right == 0 { 
            res.append(str)
            return 
        }
        
        if left > 0 {
            check(&res, str+"(", left - 1, right + 1)    
        }
        
        if right > 0 {
            check(&res, str+")", left, right - 1)
        }
    }
}