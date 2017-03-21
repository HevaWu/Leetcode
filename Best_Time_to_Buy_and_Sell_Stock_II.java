/*122. Best Time to Buy and Sell Stock II Add to List
Description  Submission  Solutions
Total Accepted: 128462
Total Submissions: 279625
Difficulty: Easy
Contributors: Admin
Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete as many transactions as you like (ie, buy one and sell one share of the stock multiple times). However, you may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).

Hide Company Tags Bloomberg
Hide Tags Array Greedy
Hide Similar Problems (E) Best Time to Buy and Sell Stock (H) Best Time to Buy and Sell Stock III (H) Best Time to Buy and Sell Stock IV (M) Best Time to Buy and Sell Stock with Cooldown
 */






/*
using "Kadane's Algorithm" (2 ms/ 198 test)
calculate the difference sum += prices[i]-prices[i-1] of the original array
and find the contiguous subarray giving maximum profit
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int maxProfit(int[] prices) {
        if(prices==null || prices.length==0) return 0;
        int profit = 0;
        for(int i = 1; i < prices.length; ++i){
            if(prices[i] > prices[i-1]){
                profit += prices[i]-prices[i-1];
            }
        }
        return profit;
    }
}
