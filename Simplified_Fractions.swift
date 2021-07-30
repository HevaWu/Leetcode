/*
Given an integer n, return a list of all simplified fractions between 0 and 1 (exclusive) such that the denominator is less-than-or-equal-to n. The fractions can be in any order.



Example 1:

Input: n = 2
Output: ["1/2"]
Explanation: "1/2" is the only unique fraction with a denominator less-than-or-equal-to 2.
Example 2:

Input: n = 3
Output: ["1/2","1/3","2/3"]
Example 3:

Input: n = 4
Output: ["1/2","1/3","1/4","2/3","3/4"]
Explanation: "2/4" is not a simplified fraction because it can be simplified to "1/2".
Example 4:

Input: n = 1
Output: []


Constraints:

1 <= n <= 100
*/

/*
Solution 1:
check greatest common divisor

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func simplifiedFractions(_ n: Int) -> [String] {
        if n == 1 { return [String]() }

        var frac = [String]()
        for i in 1...(n-1) {
            for j in (i+1)...n {
                if gcd(i, j) == 1 {
                    frac.append("\(i)/\(j)")
                }
            }
        }
        return frac
    }

    // get greatest common divisor
    func gcd(_ a: Int, _ b: Int) -> Int {
        if a > b { return gcd(b, a) }

        var t = 0
        var a1 = a
        var b1 = b
        while b1 != 0 {
            t = a1
            a1 = b1
            b1 = t % a1
        }
        return a1
    }
}