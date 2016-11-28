/*
Determine if a Sudoku is valid, according to: Sudoku Puzzles - The Rules.

The Sudoku board could be partially filled, where empty cells are filled with the character '.'.


A partially filled sudoku which is valid.
*/

class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        vector<vector<int> > rboard(9, vector<int>(9,0));  //control the rows
        vector<vector<int> > cboard(9, vector<int>(9,0));  //control the columns
        vector<vector<int> > subboard(9, vector<int>(9,0));//control the subboards
        
        for(int i = 0; i < board.size(); i++){
            for(int j = 0; j < board[i].size(); j++){
                if(board[i][j] != '.'){
                    int num = board[i][j] - '0' - 1;
                    int k = i / 3 * 3 + j / 3; //control the position of the subboards
                    
                    if(rboard[i][num] || cboard[j][num] || subboard[k][num])  //check if this number has occur
                        return false;
                        
                    rboard[i][num] = cboard[j][num] = subboard[k][num] = 1;
                }
            }
        }
        
        return true;
    }
};