/*322. Coin Change   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 47895
Total Submissions: 184063
Difficulty: Medium
Contributors: Admin
You are given coins of different denominations and a total amount of money amount. Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

Example 1:
coins = [1, 2, 5], amount = 11
return 3 (11 = 5 + 5 + 1)

Example 2:
coins = [2], amount = 3
return -1.

Note:
You may assume that you have an infinite number of each kind of coin.

Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Tags Dynamic Programming
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*DP Dynamic Programming
O(n*amount) time --- n is the number of coins
bottom-up manner
counts the minimum coins used to composed to sum
the check the minimum coins used to composed for sum+1*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int coinChange(int[] coins, int amount) {
        if(amount < 1) return 0; //check if there is the result;

        int[] dp = new int[amount+1];
        for(int sum = 1; sum <= amount; ++sum){//start from 1
            int min = -1;
            for(int coin: coins){
                if(sum >= coin && dp[sum-coin] != -1){
                    int temp = dp[sum-coin] + 1;
                    min = min < 0 ? temp : (temp < min ? temp : min);
                }
            }
            dp[sum] = min;
        }
        return dp[amount];
    }
}

