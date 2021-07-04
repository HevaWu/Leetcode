/*
A digit string is good if the digits (0-indexed) at even indices are even and the digits at odd indices are prime (2, 3, 5, or 7).

For example, "2582" is good because the digits (2 and 8) at even positions are even and the digits (5 and 2) at odd positions are prime. However, "3245" is not good because 3 is at an even index but is not even.
Given an integer n, return the total number of good digit strings of length n. Since the answer may be large, return it modulo 109 + 7.

A digit string is a string consisting of digits 0 through 9 that may contain leading zeros.



Example 1:

Input: n = 1
Output: 5
Explanation: The good numbers of length 1 are "0", "2", "4", "6", "8".
Example 2:

Input: n = 4
Output: 400
Example 3:

Input: n = 50
Output: 564908303


Constraints:

1 <= n <= 1015
*/

/*
Solution 1:
20^(count)

need to be careful to use pow with mod
*/
class Solution {
    func countGoodNumbers(_ n: Int) -> Int {
        if n == 1 { return 5 }
        if n == 2 { return 20 }

        let mod = Int(1e9 + 7)
        let count = helpPow(20, n/2, mod)
        if n % 2 == 0 {
            return count
        } else {
            return (count * 5) % mod
        }
    }

    func helpPow(_ a: Int, _ power: Int, _ mod: Int) -> Int {
        var res = 1
        var a = a
        var power = power
        while power != 0 {
            // power % 2 == 1
            if power & 1 == 1 {
                res = res * a % mod
            }
            // power/2
            power >>= 1
            a = (a * a) % mod
        }
        return res
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func countGoodNumbers(_ n: Int) -> Int {
        let mod = Int(1e9 + 7)
        if n == 1 { return 5 }

        var res = 1
        for i in 0..<n {
            res *= (i % 2 == 0 ? 5 : 4)
            res %= mod
        }
        return res
    }
}