/*
Given a 2D grid consists of 0s (land) and 1s (water).  An island is a maximal 4-directionally connected group of 0s and a closed island is an island totally (all left, top, right, bottom) surrounded by 1s.

Return the number of closed islands.



Example 1:



Input: grid = [[1,1,1,1,1,1,1,0],[1,0,0,0,0,1,1,0],[1,0,1,0,1,1,1,0],[1,0,0,0,0,1,0,1],[1,1,1,1,1,1,1,0]]
Output: 2
Explanation:
Islands in gray are closed because they are completely surrounded by water (group of 1s).
Example 2:



Input: grid = [[0,0,1,0,0],[0,1,0,1,0],[0,1,1,1,0]]
Output: 1
Example 3:

Input: grid = [[1,1,1,1,1,1,1],
               [1,0,0,0,0,0,1],
               [1,0,1,1,1,0,1],
               [1,0,1,0,1,0,1],
               [1,0,1,1,1,0,1],
               [1,0,0,0,0,0,1],
               [1,1,1,1,1,1,1]]
Output: 2


Constraints:

1 <= grid.length, grid[0].length <= 100
0 <= grid[i][j] <=1
*/

/*
Solution 1:
first dfs to change un-closed water to island
then once find water, they must be closed in island

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func closedIsland(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var grid = grid
        for i in 0..<m {
            dfs(&grid, i, 0, m, n)
            dfs(&grid, i, n-1, m, n)
        }
        for j in 0..<n {
            dfs(&grid, 0, j, m, n)
            dfs(&grid, m-1, j, m, n)
        }

        var island = 0
        for i in 1..<m {
            for j in 1..<n {
                if grid[i][j] == 0 {
                    island += 1
                    dfs(&grid, i, j, m, n);
                }
            }
        }
        return island
    }

    let dir = [0, -1, 0, 1, 0]
    func dfs(_ grid: inout [[Int]], _ i: Int, _ j: Int, _ m: Int, _ n: Int) {
        guard i >= 0, i < m, j >= 0, j < n, grid[i][j] == 0 else {
            return
        }
        grid[i][j] = 1
        for d in 0..<4 {
            dfs(&grid, i+dir[d], j+dir[d+1], m, n)
        }
    }
}
