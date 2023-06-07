/*
Given 3 positives numbers a, b and c. Return the minimum flips required in some bits of a and b to make ( a OR b == c ). (bitwise OR operation).
Flip operation consists of change any single bit 1 to 0 or change the bit 0 to 1 in their binary representation.



Example 1:



Input: a = 2, b = 6, c = 5
Output: 3
Explanation: After flips a = 1 , b = 4 , c = 5 such that (a OR b == c)
Example 2:

Input: a = 4, b = 2, c = 7
Output: 1
Example 3:

Input: a = 1, b = 2, c = 3
Output: 0


Constraints:

1 <= a <= 10^9
1 <= b <= 10^9
1 <= c <= 10^9
*/

/*
Solution 1:
bit

check each bit from last to top
use >>= to right shift the number
until da | db == dc

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func minFlips(_ a: Int, _ b: Int, _ c: Int) -> Int {
        var a = a
        var b = b
        var c = c
        var flip = 0
        while a != 0 || b != 0 || c != 0 {
            let da = a & 1
            let db = b & 1
            let dc = c & 1
            a >>= 1
            b >>= 1
            c >>= 1
            if (da | db) != dc {
                if dc == 0 {
                    flip += (da == 1 ? 1 : 0)
                    flip += (db == 1 ? 1 : 0)
                } else {
                    // dc == 1
                    // case should be both da and db is 0
                    // flip any one of them would be fine
                    flip += 1
                }
            }
        }
        return flip
    }
}
