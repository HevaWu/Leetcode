/*
A square triple (a,b,c) is a triple where a, b, and c are integers and a2 + b2 = c2.

Given an integer n, return the number of square triples such that 1 <= a, b, c <= n.



Example 1:

Input: n = 5
Output: 2
Explanation: The square triples are (3,4,5) and (4,3,5).
Example 2:

Input: n = 10
Output: 4
Explanation: The square triples are (3,4,5), (4,3,5), (6,8,10), and (8,6,10).


Constraints:

1 <= n <= 250

*/

/*
Solution 1:
Iterate over all possible pairs (a,b) and check that the square root of a * a + b * b is an integers less than or equal n

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func countTriples(_ n: Int) -> Int {
        var count = 0
        guard n > 1 else { return 0 }

        var double_n = Double(n)
        for a in 1...(n-1) {
            for b in a...(n-1) {
                let c = sqrt(Double(a * a + b * b))
                if c.truncatingRemainder(dividingBy: 1) == 0, c <= double_n {
                    // a,b,c or b,a,c
                    count += (a == b ? 1 : 2)
                }
                if c > double_n {
                    break
                }
            }
        }

        return count
    }
}