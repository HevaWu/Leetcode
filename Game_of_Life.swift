/*
According to Wikipedia's article: "The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970."

The board is made up of an m x n grid of cells, where each cell has an initial state: live (represented by a 1) or dead (represented by a 0). Each cell interacts with its eight neighbors (horizontal, vertical, diagonal) using the following four rules (taken from the above Wikipedia article):

Any live cell with fewer than two live neighbors dies as if caused by under-population.
Any live cell with two or three live neighbors lives on to the next generation.
Any live cell with more than three live neighbors dies, as if by over-population.
Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
The next state is created by applying the above rules simultaneously to every cell in the current state, where births and deaths occur simultaneously. Given the current state of the m x n grid board, return the next state.

 

Example 1:


Input: board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
Output: [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]
Example 2:


Input: board = [[1,1],[1,0]]
Output: [[1,1],[1,1]]
 

Constraints:

m == board.length
n == board[i].length
1 <= m, n <= 25
board[i][j] is 0 or 1.
 

Follow up:

Could you solve it in-place? Remember that the board needs to be updated simultaneously: You cannot update some cells first and then use their updated values to update other cells.
In this question, we represent the board using a 2D array. In principle, the board is infinite, which would cause problems when the active area encroaches upon the border of the array (i.e., live cells reach the border). How would you address these problems?
*/

/*
Solution 1:
in place 

cell only have 2 state:
if original 1, changed to 0, mark it as -1, "-" means dead, "1" means previously it is 1
if original 0, changed to 1, mark it as 2, positive value means live, "2" means previously it is dead

iteratively update board state
update board values

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func gameOfLife(_ board: inout [[Int]]) {
        let m = board.count
        let n = board[0].count
        
        var dir = [0, 1, -1, 1, 1, 0, -1, -1, 0]
        
        for i in 0..<m {
            for j in 0..<n {
                
                // count arround live 
                var live = 0
                for d in 0..<8 {
                    let r = i+dir[d]
                    let c = j+dir[d+1]
                    if r >= 0, r < m, c >= 0, c < n {
                        // 0, 1, -1, 2
                        // prev: 0, 1, 1, 0
                        // abs(board[r][c]) == 1
                        // check if previously this cell is live cell
                        live += (abs(board[r][c]) == 1 ? 1 : 0)
                    }
                }
                
                // print(i, j, live, board)
                if board[i][j] == 1 {
                    if live < 2 || live > 3 {
                        // 1 -> 0 
                        board[i][j] = -1
                    }
                } else {
                    if live == 3 {
                        // 0 -> 1
                        board[i][j] = 2
                    }
                }
                
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                board[i][j] = (board[i][j] > 0 ? 1 : 0)
            }
        }
    }
}
