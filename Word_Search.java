/*
Given an m x n grid of characters board and a string word, return true if word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.



Example 1:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true
Example 2:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true
Example 3:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false


Constraints:

m == board.length
n = board[i].length
1 <= m, n <= 6
1 <= word.length <= 15
board and word consists of only lowercase and uppercase English letters.


Follow up: Could you use search pruning to make your solution faster with a larger board?
*/

/*
Solution 1
backTrack

1. find board[i][j] = word[0], then start from (i,j), use canFind check if we can find a word
2. canFind, use visited and dir to check if there exist next element

Time Complexity: O(mn * 4^k)
Space Complexity: O(mn)
*/
class Solution {
    public boolean exist(char[][] board, String word) {
        int m = board.length;
        int n = board[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == word.charAt(0)) {
                    boolean[][] visited = new boolean[m][n];
                    visited[i][j] = true;
                    if (canFind(i, j, m, n, board, word, 1, visited)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    int[] dir = {0, 1, 0, -1, 0};
    public boolean canFind(int i, int j,
                           int m, int n,
                           char[][] board, String word,
                           int index, boolean[][] visited) {
        if (index == word.length()) {
            return true;
        }

        for (int d = 0; d < 4; d++) {
            int r = i + dir[d];
            int c = j + dir[d+1];
            if (r >= 0 && r < m && c >= 0 && c < n
                && visited[r][c] == false
                && board[r][c] == word.charAt(index)) {
                visited[r][c] = true;
                if (canFind(r, c, m, n, board, word, index+1, visited)) {
                    return true;
                }
                visited[r][c] = false;
            }
        }
        return false;
    }
}