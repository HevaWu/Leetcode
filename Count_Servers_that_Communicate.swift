/*
You are given a map of a server center, represented as a m * n integer matrix grid, where 1 means that on that cell there is a server and 0 means that it is no server. Two servers are said to communicate if they are on the same row or on the same column.

Return the number of servers that communicate with any other server.



Example 1:



Input: grid = [[1,0],[0,1]]
Output: 0
Explanation: No servers can communicate with others.
Example 2:



Input: grid = [[1,0],[1,1]]
Output: 3
Explanation: All three servers can communicate with at least one other server.
Example 3:



Input: grid = [[1,1,0,0],[0,0,1,0],[0,0,1,0],[0,0,0,1]]
Output: 4
Explanation: The two servers in the first row can communicate with each other. The two servers in the third column can communicate with each other. The server at right bottom corner can't communicate with any other server.


Constraints:

m == grid.length
n == grid[i].length
1 <= m <= 250
1 <= n <= 250
grid[i][j] == 0 or 1
*/

/*
Solution 1:
DFS

use grid to help record the current cell's server status
grid[i][j] == 0: no server
grid[i][j] == 1: not visited server
grid[i][j] == -1: visited server

once find a un-visited server, try to find its communicated server
if communicated server count is > 1, add this servers into result

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func countServers(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count

        // grid[i][j] == 0: no server
        // grid[i][j] == 1: not visited server
        // grid[i][j] == -1: visited server
        var grid = grid

        // record the number of communicate servers
        var connected = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    let server = dfs(i, j, m, n, &grid)
                    connected += (server > 1 ? server : 0)
                }
            }
        }

        return connected
    }

    // dfs to find number of communicated server
    // which grid[i][j] could connect
    func dfs(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
             _ grid: inout [[Int]]) -> Int {
        // number of finded communicated servers
        var server = 1

        var stack: [(i: Int, j: Int)] = [(i, j)]
        grid[i][j] = -1

        while !stack.isEmpty {
            let (r, c) = stack.removeLast()

            // check same row elements (r, nc)
            for nc in 0..<n {
                guard grid[r][nc] >= 0 else { continue }
                if grid[r][nc] == 1 {
                    server += 1
                    stack.append((r, nc))
                }
                grid[r][nc] = -1
            }

            // check same col elements (nr, c)
            for nr in 0..<m {
                guard grid[nr][c] >= 0 else { continue }
                if grid[nr][c] == 1 {
                    server += 1
                    stack.append((nr, c))
                }
                grid[nr][c] = -1
            }
        }

        return server
    }
}