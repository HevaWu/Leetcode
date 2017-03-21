/*63. Unique Paths II Add to List
Description  Submission  Solutions
Total Accepted: 93262
Total Submissions: 299818
Difficulty: Medium
Contributors: Admin
Follow up for "Unique Paths":

Now consider if some obstacles are added to the grids. How many unique paths would there be?

An obstacle and empty space is marked as 1 and 0 respectively in the grid.

For example,
There is one obstacle in the middle of a 3x3 grid as illustrated below.

[
  [0,0,0],
  [0,1,0],
  [0,0,0]
]
The total number of unique paths is 2.

Note: m and n will be at most 100.

Hide Company Tags Bloomberg
Hide Tags Array Dynamic Programming
Hide Similar Problems (M) Unique Paths
 */






/*
DP Dynamic Programming
grid[j] means the number of paths in each col
first check each row
then plus the paths number
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        if(obstacleGrid.length == 0 || obstacleGrid[0].length == 0) return -1;
        int n = obstacleGrid[0].length;
        int[] grid = new int[n];
        grid[0] = 1;
        for(int[] row: obstacleGrid){
            for(int j = 0; j < n; ++j){
                if(row[j] == 1){
                    grid[j] = 0;
                } else if(j>0){ //remember mark j>0
                    grid[j] += grid[j-1];
                }
            }
        }
        return grid[n-1];
    }
}
