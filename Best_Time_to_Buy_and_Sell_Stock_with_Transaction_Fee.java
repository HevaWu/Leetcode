/*
You are given an array prices where prices[i] is the price of a given stock on the ith day, and an integer fee representing a transaction fee.

Find the maximum profit you can achieve. You may complete as many transactions as you like, but you need to pay the transaction fee for each transaction.

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).



Example 1:

Input: prices = [1,3,2,8,4,9], fee = 2
Output: 8
Explanation: The maximum profit can be achieved by:
- Buying at prices[0] = 1
- Selling at prices[3] = 8
- Buying at prices[4] = 4
- Selling at prices[5] = 9
The total profit is ((8 - 1) - 2) + ((9 - 4) - 2) = 8.
Example 2:

Input: prices = [1,3,7,5,10,3], fee = 3
Output: 6


Constraints:

1 < prices.length <= 5 * 104
0 < prices[i], fee < 5 * 104
*/

/*
Solution 1:
DP

- cash: current profit/money
- hold: current hold stocks

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public int maxProfit(int[] prices, int fee) {
        int n = prices.length;
        int cash = 0;
        int hold = -prices[0];
        for (int i = 1; i < n; i++) {
            cash = Math.max(cash, hold+prices[i]-fee);
            hold = Math.max(hold, cash-prices[i]);
        }
        return cash;
    }
}
