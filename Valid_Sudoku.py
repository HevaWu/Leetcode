'''
Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

Each row must contain the digits 1-9 without repetition.
Each column must contain the digits 1-9 without repetition.
Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
Note:

A Sudoku board (partially filled) could be valid but is not necessarily solvable.
Only the filled cells need to be validated according to the mentioned rules.


Example 1:


Input: board =
[["5","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
Output: true
Example 2:

Input: board =
[["8","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
Output: false
Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.


Constraints:

board.length == 9
board[i].length == 9
board[i][j] is a digit or '.'.
'''

'''
Solution 3:
use bit instead of Set
1<<1,2,3,4,5,6,7,8,9 represent the bit shifting

Time Complexity: O(9*9)
Space Complexity: O(3*9*9)
'''
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        rowCheck = [0 for i in range(9)]
        colCheck = [0 for i in range(9)]
        boxCheck = [0 for i in range(9)]

        for i in range(9):
            for j in range(9):
                val = ord(board[i][j]) - ord('0')
                if val < 1 or val > 9: continue
                num = 1 << val
                boxIndex = (i//3)*3 + j//3
                if (rowCheck[i] & num) != 0 or (colCheck[j] & num) != 0 or (boxCheck[boxIndex] & num) != 0:
                    return False
                rowCheck[i] |= num
                colCheck[j] |= num
                boxCheck[boxIndex] |= num

        return True
