/*
Given an m x n matrix board containing 'X' and 'O', capture all regions surrounded by 'X'.

A region is captured by flipping all 'O's into 'X's in that surrounded region.

 

Example 1:


Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]
Explanation: Surrounded regions should not be on the border, which means that any 'O' on the border of the board are not flipped to 'X'. Any 'O' that is not on the border and it is not connected to an 'O' on the border will be flipped to 'X'. Two cells are connected if they are adjacent cells connected horizontally or vertically.
Example 2:

Input: board = [["X"]]
Output: [["X"]]
 

Constraints:

m == board.length
n == board[i].length
1 <= m, n <= 200
board[i][j] is 'X' or 'O'.
*/

/*
Solution 1:
BFS

search all connected O cells
mark if they should be flipped
if so, flip them

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    var dir = [0,-1,0,1,0]
    
    func solve(_ board: inout [[Character]]) {
        let m = board.count
        let n = board[0].count

        var visited = Array(repeating: Array(repeating: false, count: n),
                           count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if board[i][j] == "O", !visited[i][j] {
                    visited[i][j] = true
                    flipIfNeeded(i, j, m, n, &visited, &board)
                }
            }
        }
    }
    
    func flipIfNeeded(_ i: Int, _ j: Int, 
                     _ m: Int, _ n: Int,
                     _ visited: inout [[Bool]],
                     _ board: inout [[Character]]) {
        var connected = [(i, j)]
        
        var queue = [(i, j)]
        var notFlip = (i == 0 || j == 0 || i == m-1 || j == n-1)
        
        while !queue.isEmpty {
            let (r, c) = queue.removeFirst()
            
            for d in 0..<4 {
                let r1 = r+dir[d]
                let c1 = c+dir[d+1]
                
                if r1 >= 0, r1 < m, c1 >= 0, c1 < n, 
                !visited[r1][c1], board[r1][c1] == "O" {
                    visited[r1][c1] = true
                    
                    // find a connected cell which is not visited yet
                    connected.append((r1, c1))
                    queue.append((r1, c1))
                    
                    // update notFlip if needed
                    // print(r1, c1, r1 == m-1)
                    if !notFlip, (r1 == 0 || c1 == 0 || r1 == m-1 || c1 == n-1) { 
                        notFlip = true 
                    }
                }
            }
        }
        
        // print(i, j, notFlip, connected)
        // flip connected cell if needed
        if !notFlip {
            for (r, c) in connected {
                board[r][c] = "X"
            }
        }
    }
}