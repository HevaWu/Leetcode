/*
Given an n x n grid containing only values 0 and 1, where 0 represents water and 1 represents land, find a water cell such that its distance to the nearest land cell is maximized, and return the distance. If no land or water exists in the grid, return -1.

The distance used in this problem is the Manhattan distance: the distance between two cells (x0, y0) and (x1, y1) is |x0 - x1| + |y0 - y1|.



Example 1:


Input: grid = [[1,0,1],[0,0,0],[1,0,1]]
Output: 2
Explanation: The cell (1, 1) is as far as possible from all the land with distance 2.
Example 2:


Input: grid = [[1,0,0],[0,0,0],[0,0,0]]
Output: 4
Explanation: The cell (2, 2) is as far as possible from all the land with distance 4.


Constraints:

n == grid.length
n == grid[i].length
1 <= n <= 100
grid[i][j] is 0 or 1
*/

/*
Solution 1:
BFS

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func maxDistance(_ grid: [[Int]]) -> Int {
        let direction = [0, -1, 0, 1, 0]
        let n = grid.count
        var visited = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        var queue = [(x: Int, y: Int)]()
        for i in 0..<n {
            for j in 0..<n {
                visited[i][j] = grid[i][j]
                if grid[i][j] == 1 {
                    queue.append((i, j))
                }
            }
        }

        var dis = -1 // store current status
        while !queue.isEmpty {
            var size = queue.count
            while size > 0 {
                size -= 1
                let (x, y) = queue.removeFirst()
                for d in 0..<4 {
                    let r = x + direction[d]
                    let c = y + direction[d+1]
                    if r >= 0, r < n, c >= 0, c < n, visited[r][c] == 0 {
                        visited[r][c] = 1 // mark 1 to not visit it again
                        queue.append((r, c))
                    }
                }
            }
            dis += 1
        }

        // If the distance is 0, there is no water cell.
        return dis == 0 ? -1 : dis
    }
}
