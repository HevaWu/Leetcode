/*
The demons had captured the princess and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of m x n rooms laid out in a 2D grid. Our valiant knight was initially positioned in the top-left room and must fight his way through dungeon to rescue the princess.

The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.

Some of the rooms are guarded by demons (represented by negative integers), so the knight loses health upon entering these rooms; other rooms are either empty (represented as 0) or contain magic orbs that increase the knight's health (represented by positive integers).

To reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.

Return the knight's minimum initial health so that he can rescue the princess.

Note that any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.



Example 1:


Input: dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
Output: 7
Explanation: The initial health of the knight must be at least 7 if he follows the optimal path: RIGHT-> RIGHT -> DOWN -> DOWN.
Example 2:

Input: dungeon = [[0]]
Output: 1


Constraints:

m == dungeon.length
n == dungeon[i].length
1 <= m, n <= 200
-1000 <= dungeon[i][j] <= 1000

*/

/*
Solution 2:
1D DP

Time Complexity: O(mn)
Space Complexity: O(n)
*/
class Solution {
    public int calculateMinimumHP(int[][] dungeon) {
        int m = dungeon.length;
        int n = dungeon[0].length;

        int[] dp = new int[n+1];
        for (int i = 0; i <= n; i++) {
            // MAX_VALUE is required
            dp[i] = Integer.MAX_VALUE;
        }
        // 1 to make sure knight is alive
        dp[n-1] = 1;

        for (int i = m-1; i >= 0; i -= 1) {
            for (int j = n-1; j >= 0; j -= 1) {
                int val = Math.min(dp[j], dp[j+1]) - dungeon[i][j];
                dp[j] = Math.max(1, val);
            }
        }
        return dp[0];
    }
}

/*
Solution 1:
DP
Use hp[i][j] to store the min hp needed at position (i, j), then do the calculation from right-bottom to left-up.

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    public int calculateMinimumHP(int[][] dungeon) {
        int m = dungeon.length;
        int n = dungeon[0].length;

        int[][] dp = new int[m+1][n+1];
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[m][n-1] = 1;
        dp[m-1][n] = 1;

        for (int i = m-1; i >= 0; i -= 1) {
            for (int j = n-1; j >= 0; j -= 1) {
                int val = Math.min(dp[i+1][j], dp[i][j+1]) - dungeon[i][j];
                dp[i][j] = Math.max(1, val);
            }
        }
        return dp[0][0];
    }
}
