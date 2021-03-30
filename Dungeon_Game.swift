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
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        let m = dungeon.count
        let n = dungeon[0].count

        // dp[i][j] minimum damage knight will accept
        var dp = Array(repeating: Int.max, count: n+1)
        dp[n-1] = 1

        for i in stride(from: m-1, through: 0, by: -1) {
            for j in stride(from: n-1, through: 0, by: -1) {
                dp[j] = min(dp[j], dp[j+1]) - dungeon[i][j]
                dp[j] = max(1, dp[j])
            }
        }
        return dp[0]
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
    func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
        let m = dungeon.count
        let n = dungeon[0].count

        // dp[i][j] minimum damage knight will accept
        var dp = Array(
            repeating: Array(
                repeating: Int.max,
                count: n+1),
            count: m+1
        )

        dp[m][n-1] = 1
        dp[m-1][n] = 1

        for i in stride(from: m-1, through: 0, by: -1) {
            for j in stride(from: n-1, through: 0, by: -1) {
                let require = min(dp[i+1][j], dp[i][j+1]) - dungeon[i][j]
                dp[i][j] = require <= 0 ? 1 : require
            }
        }
        return dp[0][0]
    }
}