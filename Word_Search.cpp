/*
Given an m x n board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where
"adjacent" cells are horizontally or vertically neighboring. The same letter
cell may not be used more than once.



Example 1:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word =
"ABCCED" Output: true Example 2:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word =
"SEE" Output: true Example 3:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word =
"ABCB" Output: false


Constraints:

m == board.length
n = board[i].length
1 <= m, n <= 200
1 <= word.length <= 103
board and word consists only of lowercase and uppercase English letters.
*/

/*
Solution 2:
optimize solution 1
change board directly to mark visited status

Time Complexity: O(mn * 4^k)
Space Complexity: O(mn)
*/
class Solution {
 public:
  bool exist(vector<vector<char>>& board, string word) {
    int m = board.size();
    int n = board[0].size();
    int nw = word.size();

    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if (word[0] == board[i][j] && canFind(i, j, m, n, board, 0, nw, word)) {
          return true;
        }
      }
    }
    return false;
  }

  int dir[5] = {0, 1, 0, -1, 0};
  // back track
  bool canFind(int i, int j, int m, int n, vector<vector<char>>& board,
               int index, int nw, string word) {
    if (index == nw - 1) {
      return true;
    }

    // board[i][j] is letter, means unvisited
    // board[i][j] is '.' means visited
    char c = board[i][j];

    // mark visited
    board[i][j] = '.';

    // check 4 directions
    for (int d = 0; d < 4; d++) {
      int r = i + dir[d];
      int c = j + dir[d + 1];
      if (r >= 0 && r < m && c >= 0 && c < n &&
          board[r][c] == word[index + 1]) {
        if (canFind(r, c, m, n, board, index + 1, nw, word)) {
          return true;
        }
      }
    }

    // backtrack put back
    board[i][j] = c;

    return false;
  }
};
