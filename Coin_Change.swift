// You are given coins of different denominations and a total amount of money amount. Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

// Example 1:

// Input: coins = [1, 2, 5], amount = 11
// Output: 3 
// Explanation: 11 = 5 + 5 + 1
// Example 2:

// Input: coins = [2], amount = 3
// Output: -1
// Note:
// You may assume that you have an infinite number of each kind of coin.

// Solution 1: DP (top down)
// It use backtracking and cut the partial solutions in the recursive tree, which doesn't lead to a viable solution. Тhis happens when we try to make a change of a coin with a value greater than the amount SS. To improve time complexity we should store the solutions of the already calculated subproblems in a table.
// 
// Time complexity : O(S*n)O(S∗n). where S is the amount, n is denomination count. In the worst case the recursive tree of the algorithm has height of SS and the algorithm solves only SS subproblems because it caches precalculated solutions in a table. Each subproblem is computed with nn iterations, one by coin denomination. Therefore there is O(S*n)O(S∗n) time complexity.
// Space complexity : O(S)O(S), where SS is the amount to change We use extra space for the memoization table.
class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard !coins.isEmpty else { return -1 }
        var arr = Array(repeating: 0, count: amount)
        return check(coins, amount, &arr)
    }
    
    private func check(_ coins: [Int], _ remain: Int, _ arr: inout [Int]) -> Int {
        if remain < 0 { return -1 }
        if remain == 0 { return 0 }
        
        if arr[remain-1] != 0 { return arr[remain-1] }
        
        var min = Int.max
        for coin in coins {
            let temp = check(coins, remain-coin, &arr)
            if temp >= 0, temp < min {
                min = temp + 1
            }
        }
        arr[remain-1] = (min == Int.max) ? -1 : min
        
        return arr[remain-1]
    }
}

// Solution 2: Bottom up
// For the iterative solution, we think in bottom-up manner. Before calculating F(i)F(i), we have to compute all minimum counts for amounts up to ii. On each iteration ii of the algorithm F(i)F(i) is computed as \min_{j=0 \ldots n-1}{F(i -c_j)} + 1
// F[i] = min(F[i-coin]+1, F[i])
// 
// Time complexity : O(S*n)O(S∗n). On each step the algorithm finds the next F(i)F(i) in nn iterations, where 1\leq i \leq S1≤i≤S. Therefore in total the iterations are S*nS∗n.
// Space complexity : O(S)O(S). We use extra space for the memoization table.
class Solution {
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        guard !coins.isEmpty, amount > 0 else { return 0 }
        
        var dp = Array(repeating: amount + 1, count: amount+1)
        dp[0] = 0
        
        for i in 1...amount {
            for coin in coins {
                if coin <= i {
                    dp[i] = min(dp[i], dp[i-coin] + 1)
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount]        
    }
}
