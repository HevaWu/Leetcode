/*
Write a program to solve a Sudoku puzzle by filling the empty cells.

A sudoku solution must satisfy all of the following rules:

Each of the digits 1-9 must occur exactly once in each row.
Each of the digits 1-9 must occur exactly once in each column.
Each of the digits 1-9 must occur exactly once in each of the 9 3x3 sub-boxes of the grid.
The '.' character indicates empty cells.

 

Example 1:


Input: board = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
Output: [["5","3","4","6","7","8","9","1","2"],["6","7","2","1","9","5","3","4","8"],["1","9","8","3","4","2","5","6","7"],["8","5","9","7","6","1","4","2","3"],["4","2","6","8","5","3","7","9","1"],["7","1","3","9","2","4","8","5","6"],["9","6","1","5","3","7","2","8","4"],["2","8","7","4","1","9","6","3","5"],["3","4","5","2","8","6","1","7","9"]]
Explanation: The input board is shown above and the only valid solution is shown below:


 

Constraints:

board.length == 9
board[i].length == 9
board[i][j] is a digit or '.'.
It is guaranteed that the input board has only one solution.
*/

/*
Solution 1: 
backtrack

if cur num is dot, check if we can find a num put into the board,

Time Complexity: O(9*9*9)
*/
class Solution {
    var num: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var dot: Character = "."
    
    func solveSudoku(_ board: inout [[Character]]) {
        _solve(&board)
    }
    
    func _solve(_ board: inout [[Character]]) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == dot {
                    for c in num {
                        if isValid(board, i, j, c) {
                            board[i][j] = c
                            // check if there is a solution
                            if _solve(&board) { return true }
                            board[i][j] = dot
                        }
                    }
                    // can not find a correct num
                    return false
                }
            }
        }
        return true
    }
    
    func isValid(_ board: [[Character]], _ row: Int, _ col: Int, _ c: Character) -> Bool {
        for i in 0..<9 {
            if board[i][col] != dot, board[i][col] == c { return false }
            if board[row][i] != dot, board[row][i] == c { return false }
			// use [row/3*3+i/3][col/3*3+i%3] to find correct sub-matrix where to place c
            if board[row/3*3+i/3][col/3*3+i%3] != dot, board[row/3*3+i/3][col/3*3+i%3] == c { return false }
        }
        return true
    }
}