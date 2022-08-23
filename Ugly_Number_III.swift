/*
An ugly number is a positive integer that is divisible by a, b, or c.

Given four integers n, a, b, and c, return the nth ugly number.



Example 1:

Input: n = 3, a = 2, b = 3, c = 5
Output: 4
Explanation: The ugly numbers are 2, 3, 4, 5, 6, 8, 9, 10... The 3rd is 4.
Example 2:

Input: n = 4, a = 2, b = 3, c = 4
Output: 6
Explanation: The ugly numbers are 2, 3, 4, 6, 8, 9, 10, 12... The 4th is 6.
Example 3:

Input: n = 5, a = 2, b = 11, c = 13
Output: 10
Explanation: The ugly numbers are 2, 4, 6, 8, 10, 11, 12, 13... The 5th is 10.


Constraints:

1 <= n, a, b, c <= 109
1 <= a * b * c <= 1018
It is guaranteed that the result will be in range [1, 2 * 109].
*/

/*
Solution 1:
binary search to find possible ugly number

give range for [1, 2*1e9]
use f(k) to help find number of ugly number which < k
f(k) = number of ugly number which < k
f(k) = a + b + c - a ∩ c - a ∩ b - b ∩ c + a ∩ b ∩ c
f(k) = k/a + k/b + k/c - k/lcm(a,c) - k/lcm(a,b) - k/lcm(b,c) + k/lcm(a,b,c)

Time Complexity: O(log (2*1e9))
Space Complexity: O(1)
*/
class Solution {
    func nthUglyNumber(_ n: Int, _ a: Int, _ b: Int, _ c: Int) -> Int {
        // f(k) = number of ugly number which < k
        // f(k) = a + b + c - a ∩ c - a ∩ b - b ∩ c + a ∩ b ∩ c
        // f(k) = k/a + k/b + k/c - k/lcm(a,c) - k/lcm(a,b) - k/lcm(b,c) + k/lcm(a,b,c)

        // calculate each lcm(least common multiple)
        let ac = a * c / gcd(a, c)
        let ab = a * b / gcd(a, b)
        let bc = b * c / gcd(b, c)
        let abc = a * bc / gcd(a, bc)

        var l = 1
        var r = 2 * Int(1e9)
        while l < r {
            let mid = l + (r-l)/2
            let val = mid/a + mid/b + mid/c - mid/ac - mid/ab - mid/bc + mid/abc
            if val < n {
                l = mid + 1
            } else {
                r = mid
            }
        }
        return l
    }

    // global common divisor
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        var t = 0
        while b != 0 {
            t = a
            a = b
            b = t % a
        }
        return a
    }
}