/*
ou are given an m x n integer matrix grid where each cell is either 0 (empty) or 1 (obstacle). You can move up, down, left, or right from and to an empty cell in one step.

Return the minimum number of steps to walk from the upper left corner (0, 0) to the lower right corner (m - 1, n - 1) given that you can eliminate at most k obstacles. If it is not possible to find such walk return -1.



Example 1:

Input:
grid =
[[0,0,0],
 [1,1,0],
 [0,0,0],
 [0,1,1],
 [0,0,0]],
k = 1
Output: 6
Explanation:
The shortest path without eliminating any obstacle is 10.
The shortest path with one obstacle elimination at position (3,2) is 6. Such path is (0,0) -> (0,1) -> (0,2) -> (1,2) -> (2,2) -> (3,2) -> (4,2).
Example 2:

Input:
grid =
[[0,1,1],
 [1,1,1],
 [1,0,0]],
k = 1
Output: -1
Explanation:
We need to eliminate at least two obstacles to find such a walk.


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 40
1 <= k <= m * n
grid[i][j] == 0 or 1
grid[0][0] == grid[m - 1][n - 1] == 0
*/

/*
Solution 1:
BFS

record i,j,remain,steps

Time Complexity: O(m*n*k) time complexity
This is because for every cell (m*n), in the worst case we have to put that cell into the queue/bfs k times.
Space Complexity: O(mnk)
*/
class Solution {
    func shortestPath(_ grid: [[Int]], _ k: Int) -> Int {
        let m = grid.count
        let n = grid[0].count

        if m == 1, n == 1 { return 0 }

        var queue = [[Int]]()
        queue.append([0, 0, k, 0])

        var visited = Set<[Int]>()
        visited.insert([0, 0, k])

        let dir = [0, 1, 0, -1, 0]
        while !queue.isEmpty {
            let cur = queue.removeFirst()

            let i = cur[0]
            let j = cur[1]
            let remain = cur[2]
            let step = cur[3]

            for d in 0..<4 {
                let r = i + dir[d]
                let c = j + dir[d+1]

                if r >= 0, r < m, c >= 0, c < n {
                    if grid[r][c] == 1, remain > 0, !visited.contains([r, c, remain-1]) {
                        visited.insert([r, c, remain-1])
                        queue.append([r, c, remain-1, step+1])
                    } else if grid[r][c] == 0, !visited.contains([r, c, remain]) {
                        if r == m-1, c == n-1 {
                            return step+1
                        }

                        visited.insert([r, c, remain])
                        queue.append([r, c, remain, step+1])
                    }
                }
            }
        }

        return -1
    }
}