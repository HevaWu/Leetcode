/*289. Game of Life  QuestionEditorial Solution  My Submissions
Total Accepted: 29773 Total Submissions: 83072 Difficulty: Medium
According to the Wikipedia's article: "The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970."

Given a board with m by n cells, each cell has an initial state live (1) or dead (0). Each cell interacts with its eight neighbors (horizontal, vertical, diagonal) using the following four rules (taken from the above Wikipedia article):

Any live cell with fewer than two live neighbors dies, as if caused by under-population.
Any live cell with two or three live neighbors lives on to the next generation.
Any live cell with more than three live neighbors dies, as if by over-population..
Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
Write a function to compute the next state (after one update) of the board given its current state.

Follow up:
Could you solve it in-place? Remember that the board needs to be updated at the same time: You cannot update some cells first and then use their updated values to update other cells.
In this question, we represent the board using a 2D array. In principle, the board is infinite, which would cause problems when the active area encroaches the border of the array. How would you address these problems?
Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Dropbox Google Snapchat
Hide Tags Array
Hide Similar Problems (M) Set Matrix Zeroes
*/



/*O(1) space O(mn) time
use 2bits to store to states live (1) or dead (0)
[2nd bit, 1st bit] = [next state, current state]
- 00  dead (next) <- dead (current)
- 01  dead (next) <- live (current)
- 10  live (next) <- dead (current)
- 11  live (next) <- live (current)

for each cell's first bit, check the 8 pixels around itself, and set the cell's 2nd bit
at the begin, every cell is either 00 or 01
to transfer 01->11: when board == 1 and lives >= 2 && lives <= 3
to transfer 00->10: when board == 0 and lives == 3
To get the current state, simply do --- board[i][j] & 1
To get the next state, simply do --- board[i][j] >> 1
*/


//C++
class Solution {
public:
    void gameOfLife(vector<vector<int>>& board) {
        if(board.size()==0 || board[0].size()==0) return;
        int m = board.size();
        int n = board[0].size();
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                //count how many lives around the cell
                int lives = liveNeighbor(board, m, n, i, j);
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

    int liveNeighbor(vector<vector<int>>& board, int m, int n, int i, int j){
        int lives = 0;
        for(int x = max(i-1,0); x <= min(i+1,m-1); ++x){ // since <= should be m-1
            for(int y = max(j-1,0); y <= min(j+1,n-1); ++y){
                lives += board[x][y] & 1;
            }
        }
        lives -= board[i][j] & 1; //except the cur cell lives
        return lives;
    }
};

