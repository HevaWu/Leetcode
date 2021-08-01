/*
Given an integer n, return true if n has exactly three positive divisors. Otherwise, return false.

An integer m is a divisor of n if there exists an integer k such that n = k * m.



Example 1:

Input: n = 2
Output: false
Explantion: 2 has only two divisors: 1 and 2.
Example 2:

Input: n = 4
Output: true
Explantion: 4 has three divisors: 1, 2, and 4.


Constraints:

1 <= n <= 104
*/

class Solution {
    func isThree(_ n: Int) -> Bool {
        if n <= 3 { return false }
        var count = 0
        for i in 2...(n-1) {
            if n % i == 0 {
                count += 1
                // exactly 3 divisor
                if count > 1 { return false }
            }
        }
        return count == 1
    }
}