/*
An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.

Given an integer n, return true if n is an ugly number.



Example 1:

Input: n = 6
Output: true
Explanation: 6 = 2 × 3
Example 2:

Input: n = 1
Output: true
Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
Example 3:

Input: n = 14
Output: false
Explanation: 14 is not ugly since it includes the prime factor 7.


Constraints:

-231 <= n <= 231 - 1
*/

/*
Solution 1:
keep divide n from 2 to 6
if remain n == 1 return true

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func isUgly(_ n: Int) -> Bool {
        var n = n
        for i in 2...6 {
            guard n > 1 else { break }
            while n%i == 0 {
                n /= i
            }
        }
        return n == 1
    }
}
