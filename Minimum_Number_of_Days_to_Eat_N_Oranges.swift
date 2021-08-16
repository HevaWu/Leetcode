/*
There are n oranges in the kitchen and you decided to eat some of these oranges every day as follows:

Eat one orange.
If the number of remaining oranges (n) is divisible by 2 then you can eat  n/2 oranges.
If the number of remaining oranges (n) is divisible by 3 then you can eat  2*(n/3) oranges.
You can only choose one of the actions per day.

Return the minimum number of days to eat n oranges.



Example 1:

Input: n = 10
Output: 4
Explanation: You have 10 oranges.
Day 1: Eat 1 orange,  10 - 1 = 9.
Day 2: Eat 6 oranges, 9 - 2*(9/3) = 9 - 6 = 3. (Since 9 is divisible by 3)
Day 3: Eat 2 oranges, 3 - 2*(3/3) = 3 - 2 = 1.
Day 4: Eat the last orange  1 - 1  = 0.
You need at least 4 days to eat the 10 oranges.
Example 2:

Input: n = 6
Output: 3
Explanation: You have 6 oranges.
Day 1: Eat 3 oranges, 6 - 6/2 = 6 - 3 = 3. (Since 6 is divisible by 2).
Day 2: Eat 2 oranges, 3 - 2*(3/3) = 3 - 2 = 1. (Since 3 is divisible by 3)
Day 3: Eat the last orange  1 - 1  = 0.
You need at least 3 days to eat the 6 oranges.
Example 3:

Input: n = 1
Output: 1
Example 4:

Input: n = 56
Output: 6


Constraints:

1 <= n <= 2*10^9
*/

/*
Solution 3:
optimize solution 1

DP
point: dp[n] = 1 + min(n % 2 + minDays(n / 2), n % 3 + minDays(n / 3))

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    var dp = [Int: Int]()
    func minDays(_ n: Int) -> Int {
        if n <= 2 { return n }
        if dp[n] == nil {
            dp[n] = 1 + min(n % 2 + minDays(n / 2), n % 3 + minDays(n / 3))
        }
        return dp[n]!
    }
}

/*
Solution 2:
bottom up DP
TLE
*/
class Solution {
    func minDays(_ n: Int) -> Int {
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        if n == 3 { return 2 }

        var dp: [Int] = Array(repeating: n, count: n+1)
        dp[1] = 1
        dp[2] = 2
        dp[3] = 2

        for i in 4...n {
            var val = i

            // eat one orange
            val = min(val, 1+dp[i-1])

            if i % 2 == 0 {
                val = min(val, 1+dp[i/2])
            }

            if i % 3 == 0 {
                val = min(val, 1+dp[i - 2*(i/3)])
            }

            dp[i] = val
        }

        return dp[n]
    }
}

/*
Solution 1:
recursive DP
top down

runtime error
*/
class Solution {
    func minDays(_ n: Int) -> Int {
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        if n == 3 { return 2 }

        var dp: [Int?] = Array(repeating: nil, count: n+1)
        dp[1] = 1
        dp[2] = 2
        dp[3] = 2

        return check(n, &dp)
    }

    // return min days to eat n oranges
    func check(_ n: Int, _ dp: inout [Int?]) -> Int {
        if let val = dp[n] { return val }
        var val = n

        // eat one orange
        val = min(val, 1+check(n-1, &dp))

        if n % 2 == 0 {
            val = min(val, 1+check(n/2, &dp))
        }

        if n % 3 == 0 {
            let remain = n - 2*(n/3)
            val = min(val, 1+check(remain, &dp))
        }

        dp[n] = val
        return val
    }
}