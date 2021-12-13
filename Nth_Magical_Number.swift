/*
A positive integer is magical if it is divisible by either a or b.

Given the three integers n, a, and b, return the nth magical number. Since the answer may be very large, return it modulo 109 + 7.



Example 1:

Input: n = 1, a = 2, b = 3
Output: 2
Example 2:

Input: n = 4, a = 2, b = 3
Output: 6
Example 3:

Input: n = 5, a = 2, b = 4
Output: 10
Example 4:

Input: n = 3, a = 6, b = 4
Output: 8


Constraints:

1 <= n <= 109
2 <= a, b <= 4 * 104
*/

/*
Solution 1:
Say L = \text{lcm}(A, B)L=lcm(A,B), the least common multiple of AA and BB; and let f(x)f(x) be the number of magical numbers less than or equal to xx. A well known result says that L = \frac{A * B}{\text{gcd}(A, B)}, and that we can calculate the function \gcdgcd. For more information on least common multiples and greatest common divisors, please visit Wikipedia - Lowest Common Multiple.

Then f(x) = \lfloor \frac{x}{A} \rfloor + \lfloor \frac{x}{B} \rfloor - \lfloor \frac{x}{L} \rfloor. Why? There are \lfloor \frac{x}{A} \rf numbers A, 2A, 3A, \cdotsA,2A,3A,⋯ that are divisible by AA, there are \lfloor \frac{x}{B} \rfloor numbers divisible by BB, and we need to subtract the \lfloor \frac{x}{L} \rfloor numbers divisible by AA and BB that we double counted.

Finally, the answer must be between 00 and N * \min(A, B)N∗min(A,B).
Without loss of generality, suppose A \geq BA≥B, so that it remains to show

\lfloor \frac{N * \min(A, B)}{A} \rfloor + \lfloor \frac{N * \min(A, B)}{B} \rfloor - \lfloor \frac{N * \min(A, B)}{\text{lcm}(A, B)} \rfloor \geq
⇔ \lfloor \frac{N*A}{A} \rfloor + \lfloor \frac{N*A}{B} \rfloor - \lfloor \frac{N*A*\gcd(A, B)}{A*B} \rfloor \geq N
⇔A≥gcd(A,B)

as desired.

Afterwards, the binary search on ff is straightforward. For more information on binary search, please visit [LeetCode Explore - Binary Search].

Time Complexity: O(log(N∗min(A,B))).

Space Complexity: O(1).
*/
class Solution {
    func nthMagicalNumber(_ n: Int, _ a: Int, _ b: Int) -> Int {
        if a > b {
            return nthMagicalNumber(n, b, a)
        }

        // always a <= b
        let mod = Int(1e9 + 7)

        // least common multiple
        let L = a / gcd(a, b) * b

        var left = 0
        var right = n * min(a, b)
        while left < right {
            let mid = left + (right - left) / 2
            if (mid / a + mid / b - mid / L) < n {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left % mod
    }

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