/*
There is only one character 'A' on the screen of a notepad. You can perform two operations on this notepad for each step:

Copy All: You can copy all the characters present on the screen (a partial copy is not allowed).
Paste: You can paste the characters which are copied last time.
Given an integer n, return the minimum number of operations to get the character 'A' exactly n times on the screen.



Example 1:

Input: n = 3
Output: 3
Explanation: Intitally, we have one character 'A'.
In step 1, we use Copy All operation.
In step 2, we use Paste operation to get 'AA'.
In step 3, we use Paste operation to get 'AAA'.
Example 2:

Input: n = 1
Output: 0


Constraints:

1 <= n <= 1000
*/

/*
Solution 2:
prime Factorization

We can break our moves into groups of (copy, paste, ..., paste). Let C denote copying and P denote pasting. Then for example, in the sequence of moves CPPCPPPPCP, the groups would be [CPP][CPPPP][CP].

Say these groups have lengths g_1, g_2, .... After parsing the first group, there are g_1 'A's. After parsing the second group, there are g_1 * g_2 'A's, and so on. At the end, there are g_1 * g_2 * ... * g_n 'A's.

We want exactly N = g_1 * g_2 * ... * g_n. If any of the g_i are composite, say g_i = p * q, then we can split this group into two groups (the first of which has one copy followed by p-1 pastes, while the second group having one copy and q-1 pastes).

Such a split never uses more moves: we use p+q moves when splitting, and pq moves previously. As p+q <= pq is equivalent to 1 <= (p-1)(q-1), which is true as long as p >= 2 and q >= 2.

Algorithm By the above argument, we can suppose g_1, g_2, ... is the prime factorization of N, and the answer is therefore the sum of these prime factors.

Time Complexity: O(\sqrt{N})
Space Complexity: O(1)
*/
class Solution {
    func minSteps(_ n: Int) -> Int {
        if n == 1 { return 0 }

        var n = n
        var steps = 0
        var d = 2
        while n > 1 {
            while n % d == 0 {
                steps += d
                n /= d
            }
            d += 1
        }

        return steps
    }
}

/*
Solution 1:
DP

if i%j == 0
dp[i] = dp[j] + (i/j)

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func minSteps(_ n: Int) -> Int {
        if n == 1 { return 0 }

        var dp = Array(repeating: 0, count: n+1)

        for i in 2...n {
            dp[i] = i
            for j in stride(from: i-1, through: 2, by: -1) {
                if i % j == 0 {
                    dp[i] = dp[j] + (i/j)
                    break
                }
            }
        }

        return dp[n]
    }
}