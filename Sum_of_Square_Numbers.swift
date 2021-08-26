/*
Given a non-negative integer c, decide whether there're two integers a and b such that a2 + b2 = c.



Example 1:

Input: c = 5
Output: true
Explanation: 1 * 1 + 2 * 2 = 5
Example 2:

Input: c = 3
Output: false
Example 3:

Input: c = 4
Output: true
Example 4:

Input: c = 2
Output: true
Example 5:

Input: c = 1
Output: true


Constraints:

0 <= c <= 231 - 1
*/

/*
Solution 1:
take a for 1...(sqrt(c)),
to see if there is any b can make a*a + b*b == c,
if find it, return true

Time Complexity: O(sqrt(c))
Space Complexity: O(1)
*/
class Solution {
    func judgeSquareSum(_ c: Int) -> Bool {
        if c <= 1 { return true }

        let limit = Int(sqrt(Double(c))) ?? 0
        if limit * limit == c { return true }
        // use ...limit at here
        for a in 1...limit {
            let b = Int(sqrt(Double(c - a*a))) ?? 0
            if a*a + b*b == c { return true }
        }
        return false
    }
}