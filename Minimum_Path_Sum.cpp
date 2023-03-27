/*
Given a m x n grid filled with non-negative numbers, find a path from top left
to bottom right, which minimizes the sum of all numbers along its path.

Note: You can only move either down or right at any point in time.



Example 1:


Input: grid = [[1,3,1],[1,5,1],[4,2,1]]
Output: 7
Explanation: Because the path 1 → 3 → 1 → 1 → 1 minimizes the sum.
Example 2:

Input: grid = [[1,2,3],[4,5,6]]
Output: 12


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 200
0 <= grid[i][j] <= 100
*/

/*
Solution 3:
one array dp

Time Complexity: O(mn)
Space Complexity: O(n)
*/
class Solution {
 public:
  int minPathSum(vector<vector<int>>& grid) {
    int m = grid.size();
    int n = grid[0].size();

    vector<int> dp = vector<int>(n, INT_MAX);
    dp[0] = grid[0][0];

    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (i > 0) {
          dp[j] += grid[i][j];
        }

        if (j > 0) {
          dp[j] = min(dp[j], dp[j - 1] + grid[i][j]);
        }
      }
    }

    return dp[n - 1];
  }
};
