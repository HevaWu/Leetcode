/*
On an 8 x 8 chessboard, there is exactly one white rook 'R' and some number of white bishops 'B', black pawns 'p', and empty squares '.'.

When the rook moves, it chooses one of four cardinal directions (north, east, south, or west), then moves in that direction until it chooses to stop, reaches the edge of the board, captures a black pawn, or is blocked by a white bishop. A rook is considered attacking a pawn if the rook can capture the pawn on the rook's turn. The number of available captures for the white rook is the number of pawns that the rook is attacking.

Return the number of available captures for the white rook.



Example 1:


Input: board = [[".",".",".",".",".",".",".","."],[".",".",".","p",".",".",".","."],[".",".",".","R",".",".",".","p"],[".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".","."],[".",".",".","p",".",".",".","."],[".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".","."]]
Output: 3
Explanation: In this example, the rook is attacking all the pawns.
Example 2:


Input: board = [[".",".",".",".",".",".",".","."],[".","p","p","p","p","p",".","."],[".","p","p","B","p","p",".","."],[".","p","B","R","B","p",".","."],[".","p","p","B","p","p",".","."],[".","p","p","p","p","p",".","."],[".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".","."]]
Output: 0
Explanation: The bishops are blocking the rook from attacking any of the pawns.
Example 3:


Input: board = [[".",".",".",".",".",".",".","."],[".",".",".","p",".",".",".","."],[".",".",".","p",".",".",".","."],["p","p",".","R",".","p","B","."],[".",".",".",".",".",".",".","."],[".",".",".","B",".",".",".","."],[".",".",".","p",".",".",".","."],[".",".",".",".",".",".",".","."]]
Output: 3
Explanation: The rook is attacking the pawns at positions b5, d6, and f5.


Constraints:

board.length == 8
board[i].length == 8
board[i][j] is either 'R', '.', 'B', or 'p'
There is exactly one cell with board[i][j] == 'R'
*/

/*
Soluton 1:
find rock position first
go through 4 directions to collect rock

Time Complexity: O(8*8)
Space Complexity: O(1)
*/
class Solution {
    func numRookCaptures(_ board: [[Character]]) -> Int {
        let n = 8

        // find rock position
        var rock: (x: Int, y: Int) = (-1, -1)
        for i in 0..<n {
            for j in 0..<n {
                if board[i][j] == "R" {
                    rock = (i, j)
                    break
                }
            }
            if rock.x != -1 {
                break
            }
        }

        var collect = 0

        // up
        var i = rock.x
        var j = rock.y
        while i >= 0, board[i][j] != "B" {
            if board[i][j] == "p" {
                collect += 1
                break
            }
            i -= 1
        }

        // down
        i = rock.x
        while i < n, board[i][j] != "B" {
            if board[i][j] == "p" {
                collect += 1
                break
            }
            i += 1
        }

        // left
        i = rock.x
        j = rock.y
        while j >= 0, board[i][j] != "B" {
            if board[i][j] == "p" {
                collect += 1
                break
            }
            j -= 1
        }

        // right
        i = rock.x
        j = rock.y
        while j < n, board[i][j] != "B" {
            if board[i][j] == "p" {
                collect += 1
                break
            }
            j += 1
        }

        return collect
    }
}