// Given an Android 3x3 key lock screen and two integers m and n, where 1 ≤ m ≤ n ≤ 9, count the total number of unlock patterns of the Android lock screen, which consist of minimum of m keys and maximum n keys.

 

// Rules for a valid pattern:

// Each pattern must connect at least m keys and at most n keys.
// All the keys must be distinct.
// If the line connecting two consecutive keys in the pattern passes through any other keys, the other keys must have previously selected in the pattern. No jumps through non selected key is allowed.
// The order of keys used matters.

// Explanation:

// | 1 | 2 | 3 |
// | 4 | 5 | 6 |
// | 7 | 8 | 9 |
// Invalid move: 4 - 1 - 3 - 6
// Line 1 - 3 passes through key 2 which had not been selected in the pattern.

// Invalid move: 4 - 1 - 9 - 2
// Line 1 - 9 passes through key 5 which had not been selected in the pattern.

// Valid move: 2 - 4 - 1 - 3 - 6
// Line 1 - 3 is valid because it passes through key 2, which had been selected in the pattern

// Valid move: 6 - 5 - 4 - 1 - 9 - 2
// Line 1 - 9 is valid because it passes through key 5, which had been selected in the pattern.

 

// Example:

// Input: m = 1, n = 1
// Output: 9

// Solution 1: backtrack
// Select a digit ii which is not used in the pattern till this moment. This is done with the help of a usedused array which stores all available digits.
// We need to keep last inserted digit lastlast. The algorithm makes a check whether one of the following conditions is valid.
// 
// There is a knight move (as in chess) from lastlast towards ii or lastlast and ii are adjacent digits in a row, in a column. In this case the sum of both digits should be an odd number.
// The middle element midmid in the line which connects ii and lastlast was previously selected. In case ii and lastlast are positioned at both ends of the diagonal, digit midmid = 5 should be previously selected.
// lastlast and ii are adjacent digits in a diagonal
// 
// Time complexity : O( n!)O(n!), where nn is maximum pattern length
// The algorithm computes each pattern once and no element can appear in the pattern twice. The time complexity is proportional to the number of the computed patterns. One upper bound of the number of all possible combinations is :\sum_{i=m}^{n} {_9}P_i = \sum_{i=m}^{n} \frac{9!}{(9 - i)!}∑i=mn9Pi=∑ i=mn(9−i)!9!
// ​Space complexity : O(n)O(n), where nn is maximum pattern length In the worst case the maximum depth of recursion is nn. Therefore we need O( n)O(n) space used by the system recursive stack
class Solution {
    var map = Array(repeating: false, count: 9)
    
    func numberOfPatterns(_ m: Int, _ n: Int) -> Int {
        var num = 0
        for i in m...n {
            num += getPatterns(-1, i)
            // reset map
            map = Array(repeating: false, count: 9)
        }
        return num
    }
    
    private func getPatterns(_ last: Int, _ len: Int) -> Int {
        guard len > 0 else { return 1 }
        var num = 0
        for i in 0..<9 {
            if isValid(i, last) {
                map[i] = true
                num += getPatterns(i, len-1)
                map[i] = false
            }
        }
        return num
    }
    
    private func isValid(_ cur: Int, _ last: Int) -> Bool {
        if map[cur] == true { return false }
        
        // first digit pattern
        if last == -1 { return true }
        
        // knight moves OR adjacency moves
        if (cur+last)%2 == 1 {
            return true
        }
        
        // diagonal
        let mid = (cur+last)/2
        if mid == 4 {
            return map[4]
        }
        
        // adjacency on digonal
        if cur%3 != last%3, cur/3 != last/3 {
            return true
        }
        
        return map[mid]
    }
}