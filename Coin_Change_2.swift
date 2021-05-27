/*
You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return 0.

You may assume that you have an infinite number of each kind of coin.

The answer is guaranteed to fit into a signed 32-bit integer.



Example 1:

Input: amount = 5, coins = [1,2,5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1
Example 2:

Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.
Example 3:

Input: amount = 10, coins = [10]
Output: 1


Constraints:

1 <= coins.length <= 300
1 <= coins[i] <= 5000
All the values of coins are unique.
0 <= amount <= 5000
*/

/*
Solution 3:
1D DP

Time Complexity: O(amount*n)
Space Complexity: O(amount)
*/
class Solution {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        guard amount > 0 else { return 1 }

        let n = coins.count

        var dp = Array(repeating: 0, count: amount+1)
        dp[0] = 1

        for i in 1...n {
            for j in 1...amount {
                dp[j] += (j >= coins[i-1] ? dp[j-coins[i-1]] : 0)
            }
        }
        return dp[amount]
    }
}

/*
Solution 2:
DP 2D array

dp[i][j] : the number of combinations to make up amount j by using the first i types of coins
State transition:

- not using the ith coin, only using the first i-1 coins to make up amount j, then we have dp[i-1][j] ways.
- using the ith coin, since we can use unlimited same coin, we need to know how many ways to make up amount j - coins[i-1] by using first i coins(including ith), which is dp[i][j-coins[i-1]]
Initialization: dp[i][0] = 1

Time Complexity: O(amount*n)
Space Complexity: O(amount*n)
*/
class Solution {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        guard amount > 0 else { return 1 }

        let n = coins.count

        var dp = Array(
            repeating: Array(repeating: 0, count: amount+1),
            count: n+1
        )
        dp[0][0] = 1

        for i in 1...n {
            dp[i][0] = 1
            for j in 1...amount {
                dp[i][j] = dp[i-1][j] + (j >= coins[i-1] ? dp[i][j-coins[i-1]] : 0)
            }
        }
        return dp[n][amount]
    }
}

/*
Solution 1:
backTrack
TLE
*/
class Solution {
    func change(_ amount: Int, _ coins: [Int]) -> Int {
        var coins = coins.sorted()
        let n = coins.count
        var res = 0
        check(0, n, coins, amount, &res)
        return res
    }

    func check(_ index: Int, _ n: Int, _ coins: [Int],
               _ amount: Int, _ res: inout Int) {
        if amount < 0 { return }
        if amount == 0 {
            res += 1
            return
        }

        for i in index..<n {
            check(i, n, coins, amount-coins[i], &res)
        }
    }
}