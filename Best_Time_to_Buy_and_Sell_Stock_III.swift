/*
You are given an array prices where prices[i] is the price of a given stock on the ith day.

Find the maximum profit you can achieve. You may complete at most two transactions.

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).



Example 1:

Input: prices = [3,3,5,0,0,3,1,4]
Output: 6
Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
Example 2:

Input: prices = [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.
Example 3:

Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.
Example 4:

Input: prices = [1]
Output: 0


Constraints:

1 <= prices.length <= 105
0 <= prices[i] <= 105
*/

/*
Solution 1: DP
"sold2" --- the maximum if we've just sold 2nd stock so far
"buy2" --- the maximum if we've jest buy 2nd stock
"sold1" --- the maximum if we've just sold 1st stock so far
"buy1" --- the maximum if we've jest buy 1st stock

return s2 would enough
sold always higher than buy
s2 = max(s2, b2 + p)
b2 = max(b2, s1 - p)
==> s2 = max(s2, s1), s2 always the higher one

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        let n = prices.count

        var buy1 = Int.min
        var buy2 = Int.min
        var sell1 = 0
        var sell2 = 0

        for price in prices {
            sell2 = max(sell2, buy2 + price)
            buy2 = max(buy2, sell1 - price)

            sell1 = max(sell1, buy1 + price)
            buy1 = max(buy1, -price)
        }

        // sell2 always higher than sell1
        return sell2
    }
}
