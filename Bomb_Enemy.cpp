/*361. Bomb Enemy  QuestionEditorial Solution  My Submissions
Total Accepted: 5085 Total Submissions: 13494 Difficulty: Medium
Given a 2D grid, each cell is either a wall 'W', an enemy 'E' or empty '0' (the number zero), return the maximum enemies you can kill using one bomb.
The bomb kills all the enemies in the same row and column from the planted point until it hits the wall since the wall is too strong to be destroyed.
Note that you can only put the bomb at an empty cell.

Example:
For the given grid

0 E 0 0
E 0 W E
0 E 0 0

return 3. (Placing a bomb at (1,1) kills 3 enemies)
Credits:
Special thanks to @memoryless for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Dynamic Programming
*/



/* O(mn) time, O(n) space
we count (int)row enemy and (int[])col enemy
once we met 'W', change the row and col */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int maxKilledEnemies(vector<vector<char>>& grid) {
        if(grid.size()==0 || grid[0].size()==0) return 0;
        int ret = 0;
        int m = grid.size();
        int n = grid[0].size();
        int row = 0;
        vector<int> col(n);  //initialize size n
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                //count row enemy
                if(!j || grid[i][j-1]=='W'){
                    row = 0;
                    for(int k = j; k<n && grid[i][k]!='W'; ++k){
                        if(grid[i][k]=='E'){
                            row++;
                        }
                    }
                }
                
                //count col enemy
                if(!i || grid[i-1][j]=='W'){
                    col[j] = 0;
                    for(int k = i; k<m && grid[k][j]!='W'; ++k){
                        if(grid[k][j]=='E'){
                            col[j]++;
                        }
                    }
                }
                
                //count the most enemy canbe booms
                if(grid[i][j]=='0'){
                    ret = max(ret, row+col[j]);
                }
            }
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int maxKilledEnemies(char[][] grid) {
        if(grid.length==0 || grid[0].length==0) return 0;
        int ret = 0;
        int m = grid.length;
        int n = grid[0].length;
        int row = 0;
        int[] col = new int[n];
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                //count row enemy
                if(j==0 || grid[i][j-1]=='W'){
                    row = 0;
                    for(int k = j; k<n && grid[i][k]!='W'; ++k){
                        if(grid[i][k]=='E'){
                            row++;
                        }
                    }
                }
                
                //count col enemy
                if(i==0 || grid[i-1][j]=='W'){
                    col[j] = 0;
                    for(int k = i; k<m && grid[k][j]!='W'; ++k){
                        if(grid[k][j]=='E'){
                            col[j]++;
                        }
                    }
                }
                
                //count the most enemy canbe booms
                if(grid[i][j]=='0'){
                    ret = Math.max(ret, row+col[j]);
                }
            }
        }
        
        return ret;
    }
}
