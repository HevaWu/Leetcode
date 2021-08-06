/*
You are given an m x n binary matrix grid, where 0 represents a sea cell and 1 represents a land cell.

A move consists of walking from one land cell to another adjacent (4-directionally) land cell or walking off the boundary of the grid.

Return the number of land cells in grid for which we cannot walk off the boundary of the grid in any number of moves.



Example 1:


Input: grid = [[0,0,0,0],[1,0,1,0],[0,1,1,0],[0,0,0,0]]
Output: 3
Explanation: There are three 1s that are enclosed by 0s, and one 1 that is not enclosed because its on the boundary.
Example 2:


Input: grid = [[0,1,1,0],[0,0,1,0],[0,0,1,0],[0,0,0,0]]
Output: 0
Explanation: All 1s are either on the boundary or can reach the boundary.


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 500
grid[i][j] is either 0 or 1.

*/

/*
Solution 1:
DFS

once find land, go through board check all connected land, if there is any land in boundary,
valid is false
in the end, if valid, append current connected land into result

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func numEnclaves(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count

        var grid = grid
        var res = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    var count = 1
                    var valid = true
                    if i == 0 || i == m-1 || j == 0 || j == n-1 {
                        valid = false
                    }
                    // -1 indicate is visited
                    grid[i][j] = -1

                    dfs(i, j, m, n, &count, &valid, &grid)
                    if valid {
                        res += count
                    }

                    // print(grid)
                }
            }
        }

        return res
    }

    let dir = [0, 1, 0, -1, 0]
    func dfs(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
             _ count: inout Int,
             _ valid: inout Bool, _ grid: inout [[Int]]) {
        for d in 0..<4 {
            let r = i+dir[d]
            let c = j+dir[d+1]

            if r >= 0, r < m, c >= 0, c < n, grid[r][c] > 0 {
                grid[r][c] = -1

                count += 1
                if r == 0 || r == m-1 || c == 0 || c == n-1 {
                    valid = false
                }
                dfs(r, c, m, n, &count, &valid, &grid)
            }
        }
    }
}