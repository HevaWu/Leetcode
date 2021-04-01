/*
Given an integer n, break it into the sum of k positive integers, where k >= 2, and maximize the product of those integers.

Return the maximum product you can get.



Example 1:

Input: n = 2
Output: 1
Explanation: 2 = 1 + 1, 1 × 1 = 1.
Example 2:

Input: n = 10
Output: 36
Explanation: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36.


Constraints:

2 <= n <= 58

*/

/*
Solution 3:
same idea with Solution 2
use pow()

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func integerBreak(_ n: Int) -> Int {
        if n == 2 { return 1 }
        if n == 3 { return 2}

        var product = 1

        var remain = n%3
        var threeFactor = n/3
        if remain == 1 {
            remain = 4
            threeFactor -= 1
        } else if remain == 0 {
            remain = 1
        }

        return Int(pow(Double(3), Double(threeFactor))) * remain
    }
}

/*
Solution 2:
math

For convenience, say n is sufficiently large and can be broken into any smaller real positive numbers. We now try to calculate which real number generates the largest product.
Assume we break n into (n / x) x's, then the product will be xn/x, and we want to maximize it.

Taking its derivative gives us n * xn/x-2 * (1 - ln(x)).
The derivative is positive when 0 < x < e, and equal to 0 when x = e, then becomes negative when x > e,
which indicates that the product increases as x increases, then reaches its maximum when x = e, then starts dropping.

This reveals the fact that if n is sufficiently large and we are allowed to break n into real numbers,
the best idea is to break it into nearly all e's.
On the other hand, if n is sufficiently large and we can only break n into integers, we should choose integers that are closer to e.
The only potential candidates are 2 and 3 since 2 < e < 3, but we will generally prefer 3 to 2. Why?

Of course, one can prove it based on the formula above, but there is a more natural way shown as follows.

6 = 2 + 2 + 2 = 3 + 3. But 2 * 2 * 2 < 3 * 3.
Therefore, if there are three 2's in the decomposition, we can replace them by two 3's to gain a larger product.

All the analysis above assumes n is significantly large. When n is small (say n <= 10), it may contain flaws.
For instance, when n = 4, we have 2 * 2 > 3 * 1.
To fix it, we keep breaking n into 3's until n gets smaller than 10, then solve the problem by brute-force.


If an optimal product contains a factor f >= 4, then you can replace it with factors 2 and f-2 without losing optimality, as 2*(f-2) = 2f-4 >= f. So you never need a factor greater than or equal to 4, meaning you only need factors 1, 2 and 3 (and 1 is of course wasteful and you'd only use it for n=2 and n=3, where it's needed).

For the rest I agree, 3*3 is simply better than 2*2*2, so you'd never use 2 more than twice.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func integerBreak(_ n: Int) -> Int {
        if n == 2 { return 1 }
        if n == 3 { return 2}

        var n = n
        var product = 1
        while n > 4 {
            product *= 3
            n -= 3
        }
        product *= n
        return product
    }
}

/*
Solution 1:
DP

dp[i] is max product value for number i

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func integerBreak(_ n: Int) -> Int {
        if n == 2 { return 1 }
        if n == 3 { return 2}

        var dp = Array(0...n)
        dp[2] = 2
        dp[3] = 3

        for i in 3...n {
            for j in 2..<i {
                dp[i] = max(dp[i], dp[j]*(i-j))
            }
        }
        return dp[n]
    }
}