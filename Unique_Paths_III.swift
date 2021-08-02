/*
On a 2-dimensional grid, there are 4 types of squares:

1 represents the starting square.  There is exactly one starting square.
2 represents the ending square.  There is exactly one ending square.
0 represents empty squares we can walk over.
-1 represents obstacles that we cannot walk over.
Return the number of 4-directional walks from the starting square to the ending square, that walk over every non-obstacle square exactly once.



Example 1:

Input: [[1,0,0,0],[0,0,0,0],[0,0,2,-1]]
Output: 2
Explanation: We have the following two paths:
1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2)
2. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2)
Example 2:

Input: [[1,0,0,0],[0,0,0,0],[0,0,0,2]]
Output: 4
Explanation: We have the following four paths:
1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2),(2,3)
2. (0,0),(0,1),(1,1),(1,0),(2,0),(2,1),(2,2),(1,2),(0,2),(0,3),(1,3),(2,3)
3. (0,0),(1,0),(2,0),(2,1),(2,2),(1,2),(1,1),(0,1),(0,2),(0,3),(1,3),(2,3)
4. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2),(2,3)
Example 3:

Input: [[0,1],[2,0]]
Output: 0
Explanation:
There is no path that walks over every empty square exactly once.
Note that the starting and ending square can be anywhere in the grid.


Note:

1 <= grid.length * grid[0].length <= 20
*/

/*
Solution 1:
backTracking

find start cell,
count number of 0 cell

backTrack to find possible paths

Time Complexity: O(3^(mn))
Space Complexity: O(mn)
*/
class Solution {
    func uniquePathsIII(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count

        var grid = grid
        var path = 0
        var start = (i: -1, j: -1)
        var cell = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    //i,j is start point
                    start = (i, j)
                } else if grid[i][j] == 0 {
                    cell += 1
                }
            }
        }

        // print(start)
        grid[start.i][start.j] = -2
        check(start.i, start.j, m, n, &grid, cell, &path)
        return path
    }

    let dir = [0, 1, 0, -1, 0]
    func check(_ i: Int, _ j: Int,
               _ m: Int, _ n: Int,
               _ grid: inout [[Int]], _ cell: Int,
               _ path: inout Int) {
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, grid[r][c] >= 0 {
                if grid[r][c] == 2 {
                    if cell == 0 {
                        path += 1
                    }
                } else if cell > 0 {
                    grid[r][c] = -2
                    check(r, c, m, n, &grid, cell-1, &path)
                    grid[r][c] = 0
                }
            }
        }
    }
}