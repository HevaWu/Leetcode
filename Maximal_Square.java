/*
Given an m x n binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.



Example 1:


Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
Output: 4
Example 2:


Input: matrix = [["0","1"],["1","0"]]
Output: 1
Example 3:

Input: matrix = [["0"]]
Output: 0


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 300
matrix[i][j] is '0' or '1'.
*/

/*
 Solution 2: DP
 We initialize another matrix (dp) with the same dimensions as the original one initialized with all 0’s.
 dp(i,j) represents the side length of the maximum square whose bottom right corner is the cell with index (i,j) in the original matrix.
 Starting from index (0,0), for every 1 found in the original matrix, we update the value of the current element as
 dp(i,j)=min(dp(i−1,j),dp(i−1,j−1),dp(i,j−1))+1.
 We also remember the size of the largest square found so far. In this way, we traverse the original matrix once and find out the required maximum size. This gives the side length of the square (say maxsqlenmaxsqlen). The required result is the area masques^2

 Time complexity : O(mn)O(mn). Single pass.
 Space complexity : O(mn)O(mn). Another matrix of same size is used for dp.
 */
class Solution {
    public int maximalSquare(char[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;

        int pre = 0;
        int maxLen = 0;
        int[] dp = new int[n+1];
        for(int i = 0; i < m; i++) {
            for(int j = 0; j < n; j++) {
                int temp = dp[j+1];
                if(matrix[i][j] == '1') {
                    dp[j+1] = Math.min(pre, Math.min(dp[j], dp[j+1])) + 1;
                    maxLen = Math.max(maxLen, dp[j+1]);
                } else {
                    dp[j+1] = 0;
                }
                pre = temp;
            }
        }

        return maxLen * maxLen;
    }
}