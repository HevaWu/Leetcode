/*53. Maximum Subarray Add to List
Description  Submission  Solutions
Total Accepted: 174312
Total Submissions: 446677
Difficulty: Easy
Contributors: Admin
Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

For example, given the array [-2,1,-3,4,-1,2,1,-5,4],
the contiguous subarray [4,-1,2,1] has the largest sum = 6.

click to show more practice.

More practice:
If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

Hide Company Tags LinkedIn Bloomberg Microsoft
Hide Tags Array Dynamic Programming Divide and Conquer
Hide Similar Problems (E) Best Time to Buy and Sell Stock (M) Maximum Product Subarray
 */






/*
Solution 1: DP (22 ms/ 202 test)
dp[i] --- current contiguous subarray to i
dp[i] = nums[i] + Math.max(dp[i-1], 0);
each time update largeSum = Math.max(largeSum, dp[i]);
could save space, only use "int dp = nums[0]" is enough, each time update dp

 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int maxSubArray(int[] nums) {
        if(nums == null || nums.length == 0) return 0;

        int len = nums.length;
        int[] dp = new int[len];
        dp[0] = nums[0];
        int largeSum = nums[0];
        for(int i = 1; i< len; ++i){
            dp[i] = nums[i] + Math.max(dp[i-1], 0);
            if(dp[i] > largeSum){
                largeSum = dp[i];
            }
        }
        return largeSum;
    }
}

public class Solution {
    public int maxSubArray(int[] nums) {
        if(nums == null || nums.length == 0) return 0;

        int dp = nums[0];
        int largeSum = nums[0];
        for(int i = 1; i< nums.length; ++i){
            dp = nums[i] + Math.max(dp, 0);
            if(dp > largeSum){
                largeSum = dp;
            }
        }
        return largeSum;
    }
}
