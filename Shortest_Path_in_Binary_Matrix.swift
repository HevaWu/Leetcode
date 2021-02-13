/*
In an N by N square grid, each cell is either empty (0) or blocked (1).

A clear path from top-left to bottom-right has length k if and only if it is composed of cells C_1, C_2, ..., C_k such that:

Adjacent cells C_i and C_{i+1} are connected 8-directionally (ie., they are different and share an edge or corner)
C_1 is at location (0, 0) (ie. has value grid[0][0])
C_k is at location (N-1, N-1) (ie. has value grid[N-1][N-1])
If C_i is located at (r, c), then grid[r][c] is empty (ie. grid[r][c] == 0).
Return the length of the shortest such clear path from top-left to bottom-right.  If such a path does not exist, return -1.

 

Example 1:

Input: [[0,1],[1,0]]


Output: 2

Example 2:

Input: [[0,0,0],[1,1,0],[1,1,0]]


Output: 4

 

Note:

1 <= grid.length == grid[0].length <= 100
grid[r][c] is 0 or 1

*/


/*
Solution 1
BFS

use queue to store [i, j, len]
use visited to mark visited i,j cell
each time, find next possible cell

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func shortestPathBinaryMatrix(_ grid: [[Int]]) -> Int {
        // if init is block, there is no way
        if grid[0][0] == 1 { return -1 }
        
        let m = grid.count
        let n = grid[0].count
        
        var dir = [-1, -1, 0, -1, 1, 1, 0, 1, -1]
        
        // bfs
        // [i, j, len]
        var queue = [[Int]]()
        queue.append([0, 0, 1])
        
        var visited = Array(repeating: Array(repeating: false, count: n), 
                            count: m)
        visited[0][0] = true
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            let curR = cur[0]
            let curC = cur[1]
            let curLen = cur[2]
                        
            if curR == m-1, curC == n-1 { return curLen }
            
            for d in 0..<8 {
                let r = curR + dir[d]
                let c = curC + dir[d+1]
                
                if r >= 0, r < m, c >= 0, c < n, 
                grid[r][c] == 0, !visited[r][c] {
                    queue.append([r, c, curLen+1])
                    visited[r][c] = true
                }
            }
        }
        
        return -1
    }
}