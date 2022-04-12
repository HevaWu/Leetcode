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

public class Solution {
    public void gameOfLife(int[][] board) {
        if(board==null || board.length==0 || board[0].length==0) return;
        int m = board.length;
        int n = board[0].length;
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                //count how many lives around the cell
                int lives = countLive(board, m, n, i, j);
                if(board[i][j]==1 && lives>=2 && lives <=3){
                     //still live in next generation, 01->11, which should be 3
                    board[i][j] = 3;
                }
                if(board[i][j]==0 && lives==3){
                    //cur die, live in next generation, 00->10, which should be 2
                    board[i][j] = 2;
                }
            }
        }

        //change to the next generation by board[i][j] >> 1
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                board[i][j] >>= 1;
            }
        }
    }

    public int countLive(int[][] board, int m, int n, int i, int j){
        int lives = 0;
        for(int x = Math.max(i-1,0); x <= Math.min(i+1,m-1); ++x){ // since <= should be m-1
            for(int y = Math.max(j-1,0); y <= Math.min(j+1,n-1); ++y){
                //get the cur lives by board[x][y] & 1
                lives += board[x][y] & 1;
            }
        }
        //except the cur cell lives
        return lives-(board[i][j] & 1);
    }
}
