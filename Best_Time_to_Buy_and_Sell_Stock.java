/*121. Best Time to Buy and Sell Stock Add to List
Description  Submission  Solutions
Total Accepted: 168640
Total Submissions: 424428
Difficulty: Easy
Contributors: Admin
Say you have an array for which the ith element is the price of a given stock on day i.

If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit.

Example 1:
Input: [7, 1, 5, 3, 6, 4]
Output: 5

max. difference = 6-1 = 5 (not 7-1 = 6, as selling price needs to be larger than buying price)
Example 2:
Input: [7, 6, 4, 3, 1]
Output: 0

In this case, no transaction is done, i.e. max profit = 0.
Hide Company Tags Amazon Microsoft Bloomberg Uber Facebook
Hide Tags Array Dynamic Programming
Hide Similar Problems (E) Maximum Subarray (E) Best Time to Buy and Sell Stock II (H) Best Time to Buy and Sell Stock III (H) Best Time to Buy and Sell Stock IV (M) Best Time to Buy and Sell Stock with Cooldown
*/






/*
Solution 2 faster than Solution 1

Solution 1:
same as "max subarray problem"
using "Kadane's Algorithm"
calculate the difference sum += prices[i]-prices[i-1] of the original array
and find the contiguous subarray giving maximum profit

Solution 2: (2 ms/ 200 test)
each time update "buy" and "profit"
We take prices array as [5, 6, 2, 4, 8, 9, 5, 1, 5]
In the given problem, we assume the first element as the stock with lowest price.
Prices:      [5, 6, 2, 4, 8, 9, 5, 1, 5]
Profit:       Bought:5     Sell:6               Profit:$1             max profit=$1
Now the next element is 2 which have lower price than the stock we bought previously which was 5.
Profit:      Bought:2     Sell:-              Profit:-                  max profit=$1
Next element is 4 which has higher price than the stock we bought. So if we sell the stock at this price.
Profit:      Bought:2     Sell:4              Profit:$2               max profit=$2
Profit:      Bought:2     Sell:8              Profit:$6                max profit=$6
Now next stock is of $9 which is also higher than the price we bought at ($2).
Profit:      Bought:2     Sell:9              Profit:$7                max profit=$7
Now the next stock is $5. If we sell at this price then we will earn profit of $3, but we already have a max profit of $7 because of our previous transaction.
Profit:      Bought:2     Sell:5              Profit:$3                max profit=$7
Now next stock price is $1 which is less than the stock we bought of $2. And if we buy this stock and sell it in future then obviously we will gain more profit. So the value of bought will become $1.
Profit:      Bought:1     Sell:-              Profit:-                   max profit=$7
Now next stock is of $5. So this price is higher than the stock we bought.
Profit:      Bought:1     Sell:5              Profit:$4                max profit=$7
But our maximum profit will be $7.
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int maxProfit(int[] prices) {
        if(prices.length == 0) return 0;
        int profit = 0;
        int sum = 0;
        for(int i = 1; i < prices.length; ++i){
            sum = Math.max(0, sum+=prices[i]-prices[i-1]); // remember compare current to 0,
            profit = Math.max(profit, sum); //compare current contiguous subarray with profit
        }
        return profit;
    }
}




//Solution 2
public class Solution {
    public int maxProfit(int[] prices) {
        if(prices.length == 0) return 0;
        int buy = prices[0];
        int profit = 0;
        for(int i = 1; i < prices.length; ++i){
            if(prices[i] > buy){
                profit = Math.max(profit, prices[i]-buy);
            } else {
                //prices[i] <= buy
                buy = prices[i];
            }
        }
        return profit;
    }
}
