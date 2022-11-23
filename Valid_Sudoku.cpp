/*
Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be
validated according to the following rules:

Each row must contain the digits 1-9 without repetition.
Each column must contain the digits 1-9 without repetition.
Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without
repetition. Note:

A Sudoku board (partially filled) could be valid but is not necessarily
solvable. Only the filled cells need to be validated according to the mentioned
rules.


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
Explanation: Same as Example 1, except with the 5 in the top left corner being
modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is
invalid.


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
 public:
  bool isValidSudoku(vector<vector<char>>& board) {
    // note: have to add default init value, otherwise, the result is not stable
    int rowCheck[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
    int colCheck[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};
    int boxCheck[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0};

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        int val = board[i][j] - '0';
        if (val < 1 || val > 9) {
          continue;
        }
        int num = 1 << val;
        int boxIndex = (i / 3) * 3 + (j / 3);
        if (((rowCheck[i] & num) != 0) || ((colCheck[j] & num) != 0) ||
            ((boxCheck[boxIndex] & num) != 0)) {
          return false;
        }
        rowCheck[i] |= num;
        colCheck[j] |= num;
        boxCheck[boxIndex] |= num;
      }
    }

    return true;
  }
};

/*
Solution 2:
use Array instead of Set

Time Complexity: O(9*9)
Space Complexity: O(3*9*9)
*/
class Solution {
 public:
  bool isValidSudoku(vector<vector<char>>& board) {
    vector<vector<int>> rboard(9, vector<int>(9, 0));    // control the rows
    vector<vector<int>> cboard(9, vector<int>(9, 0));    // control the columns
    vector<vector<int>> subboard(9, vector<int>(9, 0));  // control the
                                                         // subboards

    for (int i = 0; i < board.size(); i++) {
      for (int j = 0; j < board[i].size(); j++) {
        if (board[i][j] != '.') {
          int num = board[i][j] - '0' - 1;
          int k = i / 3 * 3 + j / 3;  // control the position of the subboards

          if (rboard[i][num] || cboard[j][num] ||
              subboard[k][num])  // check if this number has occur
            return false;

          rboard[i][num] = cboard[j][num] = subboard[k][num] = 1;
        }
      }
    }

    return true;
  }
};
