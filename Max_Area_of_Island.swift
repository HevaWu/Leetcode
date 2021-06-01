/*
You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

The area of an island is the number of cells with a value 1 in the island.

Return the maximum area of an island in grid. If there is no island, return 0.



Example 1:


Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
Output: 6
Explanation: The answer is not 11, because the island must be connected 4-directionally.
Example 2:

Input: grid = [[0,0,0,0,0,0,0,0]]
Output: 0


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 50
grid[i][j] is either 0 or 1.
*/

/*
Solution 1:
DFS

once find a 1 cell, dfs to count this island
then compare it with area

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count

        var area = 0
        var grid = grid
        for i in 0..<m {
            for j in 0..<n where grid[i][j] == 1 {
                var cur = 0
                countArea(i, j, m, n, &grid, &cur)
                area = max(area, cur)
                // print(cur, grid)
            }
        }
        return area
    }

    let dir = [0, 1, 0, -1, 0]
    func countArea(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
                   _ grid: inout [[Int]], _ cur: inout Int) {
        cur += 1
        grid[i][j] = 0

        for d in 0..<4 {
            let r = i+dir[d]
            let c = j+dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, grid[r][c] == 1 {
                countArea(r, c, m, n, &grid, &cur)
            }
        }
    }
}