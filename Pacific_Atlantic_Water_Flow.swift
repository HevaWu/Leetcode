/*
Given an m x n matrix of non-negative integers representing the height of each unit cell in a continent, the "Pacific ocean" touches the left and top edges of the matrix and the "Atlantic ocean" touches the right and bottom edges.

Water can only flow in four directions (up, down, left, or right) from a cell to another one with height equal or lower.

Find the list of grid coordinates where water can flow to both the Pacific and Atlantic ocean.

Note:

The order of returned grid coordinates does not matter.
Both m and n are less than 150.


Example:

Given the following 5x5 matrix:

  Pacific ~   ~   ~   ~   ~
       ~  1   2   2   3  (5) *
       ~  3   2   3  (4) (4) *
       ~  2   4  (5)  3   1  *
       ~ (6) (7)  1   4   5  *
       ~ (5)  1   1   2   4  *
          *   *   *   *   * Atlantic

Return:

[[0, 4], [1, 3], [1, 4], [2, 2], [3, 0], [3, 1], [4, 0]] (positions with parentheses in above matrix).

*/

/*
Solution 1:
DFS

check from each ocean border, find the cell this water can flow to
(find height >= pre)
- visitP: mark pacific ocean water can flow to
- visitA: mark pacific ocean water can flow to
- go through visitP and visitA for find a cell can visit both 2 oceans

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func pacificAtlantic(_ matrix: [[Int]]) -> [[Int]] {
        var res = [[Int]]()
        if matrix.isEmpty || matrix[0].isEmpty { return res }

        let m = matrix.count
        let n = matrix[0].count

        // pacific visited mark
        var visitP = Array(repeating: Array(repeating: false, count: n),
                                    count: m)
        var visitA = Array(repeating: Array(repeating: false, count: n),
                                    count: m)

        for i in 0..<m {
            dfs(matrix, i, 0, m, n, &visitP, Int.min)
            dfs(matrix, i, n-1, m, n, &visitA, Int.min)
        }

        for j in 0..<n {
            dfs(matrix, 0, j, m, n, &visitP, Int.min)
            dfs(matrix, m-1, j, m, n, &visitA, Int.min)
        }

        for i in 0..<m {
            for j in 0..<n {
                if visitP[i][j], visitA[i][j] {
                    res.append([i, j])
                }
            }
        }

        return res
    }

    var dir = [0, 1, 0, -1, 0]
    func dfs(_ matrix: [[Int]],
             _ x: Int, _ y: Int,
             _ m: Int, _ n: Int,
             _ visited: inout [[Bool]], _ height: Int) {
        guard x >= 0, x < m, y >= 0, y < n, !visited[x][y], matrix[x][y] >= height else {
            return
        }
        visited[x][y] = true
        for d in 0..<4 {
            dfs(matrix, x+dir[d], y+dir[d+1], m, n, &visited, matrix[x][y])
        }
    }
}