/*130. Surrounded Regions  QuestionEditorial Solution  My Submissions
Total Accepted: 60534
Total Submissions: 362069
Difficulty: Medium
Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.

A region is captured by flipping all 'O's into 'X's in that surrounded region.

For example,
X X X X
X O O X
X X O X
X O X X
After running your function, the board should be:

X X X X
X X X X
X X X X
X O X X
Subscribe to see which companies asked this question

Show Tags
Show Similar Problems
*/


/*First, check the four border of the matrix. If there is a element is
'O', alter it and all its neighbor 'O' elements to '1'.
Then ,alter all the 'O' to 'X'
At last,alter all the '1' to 'O'*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    void solve(vector<vector<char>>& board) {
       int i, j;
        int row = board.size();
        if(!row){
            return;
        }
        
        int col = board[0].size();
        for(i = 0; i < row; i++){
            check(board, i, 0, row, col);
            if(col>1){
                check(board, i, col-1, row, col);
            }
        }
        
        for(j = 1; j + 1 < col; j++){
            check(board, 0, j, row, col);
            if(row>1){
                check(board, row-1, j, row, col);
            }
        }
        
        for(i = 0; i < row; i++){
            for(j = 0; j < col; j++){
                if(board[i][j] == 'O'){
                    board[i][j] = 'X';
                }
            }
        }
        
        for(i = 0; i < row; i++){
            for(j = 0; j < col; j++){
                if(board[i][j] == '1'){
                    board[i][j] = 'O';
                }
            }
        }
    }
    
    void check(vector<vector<char> > &board, int i, int j, int row, int col){
        if(board[i][j]=='O'){
            board[i][j] = '1';
            if(i>1) check(board, i-1, j, row, col);
            if(j>1) check(board, i, j-1, row, col);
            if(i+1<row) check(board, i+1, j, row, col);
            if(j+1<col) check(board, i, j+1, row, col);
        }
    }
};







/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public void solve(char[][] board) {
        int i, j;
        int row = board.length;
        if(row == 0){
            return;
        }
        
        int col = board[0].length;
        for(i = 0; i < row; i++){
            check(board, i, 0, row, col);
            if(col>1){
                check(board, i, col-1, row, col);
            }
        }
        
        for(j = 1; j + 1 < col; j++){
            check(board, 0, j, row, col);
            if(row>1){
                check(board, row-1, j, row, col);
            }
        }
        
        for(i = 0; i < row; i++){
            for(j = 0; j < col; j++){
                if(board[i][j] == 'O'){
                    board[i][j] = 'X';
                }
            }
        }
        
        for(i = 0; i < row; i++){
            for(j = 0; j < col; j++){
                if(board[i][j] == '1'){
                    board[i][j] = 'O';
                }
            }
        }
    }
    
    public void check(char[][] board, int i, int j, int row, int col){
        if(board[i][j] == 'O'){
            board[i][j] = '1';
            if(i>1) check(board, i-1, j, row, col);
            if(j>1) check(board, i, j-1, row, col);
            if(i+1<row) check(board, i+1, j, row, col);
            if(j+1<col) check(board, i, j+1, row, col);
        }
    }
}