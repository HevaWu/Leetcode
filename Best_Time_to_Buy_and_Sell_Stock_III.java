/*123. Best Time to Buy and Sell Stock III Add to List
Description  Submission  Solutions
Total Accepted: 79172
Total Submissions: 277007
Difficulty: Hard
Contributors: Admin
Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete at most two transactions.

Note:
You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).

Hide Tags Array Dynamic Programming
Hide Similar Problems (E) Best Time to Buy and Sell Stock (E) Best Time to Buy and Sell Stock II (H) Best Time to Buy and Sell Stock IV
 */






/*
assume only have 0 money at first (4 ms/ 198 test)
"sold2" --- the maximum if we've just sold 2nd stock so far
"buy2" --- the maximum if we've jest buy 2nd stock
"sold1" --- the maximum if we've just sold 1st stock so far
"buy1" --- the maximum if we've jest buy 1st stock
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int maxProfit(int[] prices) {
        if(prices==null || prices.length==0) return 0;
        int buy1 = Integer.MIN_VALUE;
        int buy2 = Integer.MIN_VALUE;
        int sold1 = 0;
        int sold2 = 0;
        for(int price: prices){
            sold2 = Math.max(sold2, buy2 + price);
            buy2 = Math.max(buy2, sold1 - price);
            sold1 = Math.max(sold1, buy1 + price);
            buy1 = Math.max(buy1, -price);
        }
        //sold2 always higher than sold1
        return sold2;
    }
}
