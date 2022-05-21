'''
You are given coins of different denominations and a total amount of money amount. Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

Example 1:

Input: coins = [1, 2, 5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1
Example 2:

Input: coins = [2], amount = 3
Output: -1
Note:
You may assume that you have an infinite number of each kind of coin.
'''


'''
Solution 2: Bottom up
For the iterative solution, we think in bottom-up manner. Before calculating F(i)F(i), we have to compute all minimum counts for amounts up to ii. On each iteration ii of the algorithm F(i)F(i) is computed as \min_{j=0 \ldots n-1}{F(i -c_j)} + 1
F[i] = min(F[i-coin]+1, F[i])

Time complexity : O(S*n)O(S∗n). On each step the algorithm finds the next F(i)F(i) in nn iterations, where 1\leq i \leq S1≤i≤S. Therefore in total the iterations are S*nS∗n.
Space complexity : O(S)O(S). We use extra space for the memoization table.
'''
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        dp = [amount+1 for i in range(amount+1)]
        dp[0] = 0

        for num in range(1, amount+1):
            for coin in coins:
                if num >= coin:
                    dp[num] = min(dp[num], dp[num-coin]+1)

        return -1 if dp[amount] > amount else dp[amount]
