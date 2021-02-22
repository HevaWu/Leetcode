/*
Given a column title as appear in an Excel sheet, return its corresponding column number.

For example:

    A -> 1
    B -> 2
    C -> 3
    ...
    Z -> 26
    AA -> 27
    AB -> 28 
    ...
Example 1:

Input: "A"
Output: 1
Example 2:

Input: "AB"
Output: 28
Example 3:

26*26+25
26^1 * 26 + 26^0 * 25
Input: "ZY"
Output: 701
 

Constraints:

1 <= s.length <= 7
s consists only of uppercase English letters.
s is between "A" and "FXSHRXW".
*/

/*
Solution 1
iterative go through string s

res += s[i]* 26^(n-1-i)

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func titleToNumber(_ s: String) -> Int {
        var s = Array(s)
        let n = s.count
        
        var res: Double = 0
        let asciiA = Character("A").asciiValue!
        for i in 0..<n {
            var cur = pow(Double(26), Double(n-1-i))
            cur *= Double(s[i].asciiValue! - asciiA + 1)
            res += cur
        }
        return Int(res)
    }
}