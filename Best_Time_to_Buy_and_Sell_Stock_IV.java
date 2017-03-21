/*188. Best Time to Buy and Sell Stock IV
Description  Submission  Solutions  Add to List
Total Accepted: 40435
Total Submissions: 169243
Difficulty: Hard
Contributors: Admin
Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete at most k transactions.

Note:
You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).

Credits:
Special thanks to @Freezen for adding this problem and creating all test cases.

Hide Tags Dynamic Programming
Hide Similar Problems (E) Best Time to Buy and Sell Stock (E) Best Time to Buy and Sell Stock II (H) Best Time to Buy and Sell Stock III
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*DP, Dynamic Programming
first check if k>=len/2, if it is, do QuickProfit
set profit[k+1][len], a 2D array
check the profit for the first i-1 transactions
then determine the i transaction should do what

tempMax means the maximum profit of just doing at most i-1 transactions,
using at most first j-1 prices,
and buying the stock at price[j] - used for the next loop

at the end, return the profit[k][len-1]

QuickProfit():
just find the maximum profit you can get,
didnot need to consider how many transactions limit
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int maxProfit(int k, int[] prices) {
        if(k<=0 || prices.length<=0) return 0;

        int len = prices.length;
        if(k >= len/2) return QuickProfit(prices);

        int[][] profit = new int[k+1][len];

        for(int i = 1; i <= k; ++i){
            int tempMax = -prices[0];
            for(int j = 1; j < len; ++j){
                //Maximum profit if we sell at this price
                profit[i][j] = Math.max(profit[i][j-1], prices[j] + tempMax);
                //buy at this price and leave this value for prices[j+1]
                //tempMax means the maximum profit of just doing at most i-1 transaction
                //using at most j-1 prices, and buy the stock at price[j]-used for the next loop
                tempMax = Math.max(tempMax, profit[i-1][j-1]-prices[j]);
            }
        }

        return profit[k][len-1];
    }

    public int QuickProfit(int[] prices){
        int profit = 0;
        for(int i = 1; i < prices.length; ++i){ //i start from 1
            if(prices[i] > prices[i-1]){  //sell and buy at the same day, means we can sell this product later
            //as long as there is a price gap, add it to the profit
                profit += prices[i]-prices[i-1];
            }
        }
        return profit;
    }
}

