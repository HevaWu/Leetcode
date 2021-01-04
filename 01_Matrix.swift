/*
Given a matrix consists of 0 and 1, find the distance of the nearest 0 for each cell.

The distance between two adjacent cells is 1.

 

Example 1:

Input:
[[0,0,0],
 [0,1,0],
 [0,0,0]]

Output:
[[0,0,0],
 [0,1,0],
 [0,0,0]]
Example 2:

Input:
[[0,0,0],
 [0,1,0],
 [1,1,1]]

Output:
[[0,0,0],
 [0,1,0],
 [1,2,1]]
 

Note:

The number of elements of the given matrix will not exceed 10,000.
There are at least one 0 in the given matrix.
The cells are adjacent in only four directions: up, down, left and right.
*/

/*
Solution 2:
DP
1. first find all 0 cells
2. update dist by:
- a. update from top and left: 
     dist[i][j] = min(dist[i][j],
	 				  min(dist[i-1][j], dist[i][j-1])+1)
- b. update from bottom and right:
	 dist[i][j] = min(dist[i][j],
	 				  min(dist[i+1][j], dist[i][j+1])+1)

Time Complexity: O(nm), 2 passes of r,c search
Space Complexity: O(nm)
*/

class Solution {
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { 
            return matrix 
        }
        
        let n = matrix.count
        let m = matrix[0].count
        
        // in case of out the limit, set value as Int.max-10000, because cell will at most have 10000 elements
        var dp = Array(repeating: Array(repeating: Int.max - 10000, count: m),
                      count: n)
        
        for i in 0..<n {
            for j in 0..<m {
                // 1. find all 0 cells
                if matrix[i][j] == 0 {
                    dp[i][j] = 0
                } else {
                    // 2. check from left and top
                    if i > 0 {
                        dp[i][j] = min(dp[i][j], dp[i-1][j] + 1)
                    }
                    if j > 0 {
                        dp[i][j] = min(dp[i][j], dp[i][j-1] + 1)
                    }
                }
            }
        }
        
        // 3. check from right and bottom
        for i in stride(from: n-1, through: 0, by: -1) {
            for j in stride(from: m-1, through: 0, by: -1) {
                if i < n-1 {
                    dp[i][j] = min(dp[i][j], dp[i+1][j] + 1)
                }
                if j < m-1 {
                    dp[i][j] = min(dp[i][j], dp[i][j+1] + 1)
                }
            }
        }
        
        return dp
    }
}

/*
Solution 1:
BFS

1. find all 0 cells and push them into queue
2. check each 0 cells 4 direction cell, update each of them if it is needed(direction cell dist > cur cell dist + 1), push them into queue

Time Complexity: O(nm)
- each cell will only be pushed into queue once

Space Complexity: O(nm)
*/
class Solution {
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return matrix }
        
        let n = matrix.count
        let m = matrix[0].count
        
        var dist = Array(repeating: Array(repeating: Int.max, count: m),
                        count: n)
        
        // bfs store cells (r, c)
        var queue = [(Int, Int)]()
        
        // find all 0 cells first
        for i in 0..<n {
            for j in 0..<m {
                if matrix[i][j] == 0 {
                    dist[i][j] = 0
                    queue.append((i,j))
                }
            }
        }
        
        // 4 directions
        let dir: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            for d in dir {
                let r = cur.0 + d.0
                let c = cur.1 + d.1
                if r >= 0, r < n, c >= 0, c < m {
                    if dist[r][c] > dist[cur.0][cur.1] + 1 {
                        dist[r][c] = dist[cur.0][cur.1] + 1
                        queue.append((r,c))
                    }
                }
            }
        }
        
        return dist
    }
}