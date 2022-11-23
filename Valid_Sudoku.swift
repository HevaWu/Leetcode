/*
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
*/

/*
Solution 3:
use bit instead of Set
1<<1,2,3,4,5,6,7,8,9 represent the bit shifting

Time Complexity: O(9*9)
Space Complexity: O(3*9*9)
*/
class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var rowCheck = Array(repeating: 0, count: 9)
        var colCheck = Array(repeating: 0, count: 9)
        var boxCheck = Array(repeating: 0, count: 9)

        for i in 0..<9 {
            for j in 0..<9 {
                guard let val = board[i][j].wholeNumberValue else {
                    continue
                }
                let num = 1<<val
                let boxIndex = (i/3) * 3 + (j/3)
                if ((rowCheck[i] & num) != 0)
                || ((colCheck[j] & num) != 0)
                || ((boxCheck[boxIndex] & num) != 0){
                    return false
                }

                rowCheck[i] |= num
                colCheck[j] |= num
                boxCheck[boxIndex] |= num
            }
        }
        return true
    }
}

/*
Solution 2:
use Array instead of Set

Time Complexity: O(9*9)
Space Complexity: O(3*9*9)
*/
class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var row = Array(
            repeating: Array(repeating: false, count: 10),
            count: 9
        )
        var col = Array(
            repeating: Array(repeating: false, count: 10),
            count: 9
        )
        var sub = Array(
            repeating: Array(repeating: false, count: 10),
            count: 9
        )

        for i in 0..<9 {
            for j in 0..<9 {
                if let val = board[i][j].wholeNumberValue {
                    if row[i][val] { return false }
                    if col[j][val] { return false }
                    let subIndex = i / 3 * 3 + j / 3
                    if sub[subIndex][val] { return false }

                    row[i][val] = true
                    col[j][val] = true
                    sub[subIndex][val] = true
                }
            }
        }

        return true
    }
}

/*
Solution 1:
based on the validation rule
make 3 map to check if each part of them are validated

Time Complexity: O(9*9)
Space Complexity: O(3*9*9)
*/
class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var row = [Int: Set<Character>]()
        var col = [Int: Set<Character>]()
        var sub = [Int: Set<Character>]()

        for r in 0..<9 {
            for c in 0..<9 {
                let cur = board[r][c]
                if cur == "." { continue }

				// use r / 3 * 3 + c / 3 to find correct sub
                let k = r / 3 * 3 + c / 3
                if (row[r]?.contains(cur) ?? false)
                || (col[c]?.contains(cur) ?? false)
                || (sub[k]?.contains(cur) ?? false) {
                    return false
                }

                row[r, default: Set<Character>()].insert(cur)
                col[c, default: Set<Character>()].insert(cur)
                sub[k, default: Set<Character>()].insert(cur)
            }
        }
        return true
    }
}

