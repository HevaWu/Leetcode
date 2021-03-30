/*
Given an integer n, return the nth ugly number.

Ugly number is a positive number whose prime factors only include 2, 3, and/or 5.



Example 1:

Input: n = 10
Output: 12
Explanation: [1, 2, 3, 4, 5, 6, 8, 9, 10, 12] is the sequence of the first 10 ugly numbers.
Example 2:

Input: n = 1
Output: 1
Explanation: 1 is typically treated as an ugly number.


Constraints:

1 <= n <= 1690
*/

/*
Solution 1:
DP

We have an array k of first n ugly number. We only know, at the beginning, the first one, which is 1. Then

- k[1] = min( k[0]x2, k[0]x3, k[0]x5). The answer is k[0]x2. So we move 2's pointer to 1. Then we test:
- k[2] = min( k[1]x2, k[0]x3, k[0]x5). And so on. Be careful about the cases such as 6, in which we need to forward both pointers of 2 and 3.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func nthUglyNumber(_ n: Int) -> Int {
        if n == 1 { return 1 }
        var dp = Array(repeating: 0, count: n)
        dp[0] = 1

        var i2 = 0
        var i3 = 0
        var i5 = 0
        for i in 1..<n {
            dp[i] = min(dp[i2]*2, min(dp[i3]*3, dp[i5]*5))
            if dp[i] == dp[i2]*2 { i2 += 1 }
            if dp[i] == dp[i3]*3 { i3 += 1 }
            if dp[i] == dp[i5]*5 { i5 += 1 }
        }
        return dp[n-1]
    }
}