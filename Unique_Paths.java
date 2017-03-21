/* 62. Unique Paths Add to List
Description  Submission  Solutions
Total Accepted: 125295
Total Submissions: 315662
Difficulty: Medium
Contributors: Admin
A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

How many possible unique paths are there?


Above is a 3 x 7 grid. How many possible unique paths are there?

Note: m and n will be at most 100.

Hide Company Tags Bloomberg
Hide Tags Array Dynamic Programming
Hide Similar Problems (M) Unique Paths II (M) Minimum Path Sum (H) Dungeon Game
*/






/*
Solution 3 faster than Solution 2,1

DP Dynamic Programming
Solution 1
use int[m][n] grid array to help solve this problem
grid[i][j] means the number of paths from (0,0) to (i,j)
init the first row as 1, the first col as 1
then grid[i][j] = grid[i-1][j] + grid[i][j-1]
since the robot can only move down or right
return grid[m-1][n-1]

Solution 2
only use one array to control the grid number

Solution 3: Math
we need to do "n+m-2" movement : n-1 + m-1
choose (n-1) movements form (m+n-2)
rest (m-1) is combinations
k = m-1
count combination Combination(N, k) = n! / (k!(n - k)!)
            reduce the numerator and denominator and get
            C = ( (n - k + 1) * (n - k + 2) * ... * n ) / k!

 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int uniquePaths(int m, int n) {
        int[][] grid = new int[m][n];
        for(int i = 0; i < m; ++i){
            grid[i][0] = 1;
        }
        for(int j = 0; j < n; ++j){
            grid[0][j] = 1;
        }

        for(int i = 1; i < m; ++i){
            for(int j = 1; j < n; ++j){
                grid[i][j] = grid[i-1][j] + grid[i][j-1];
            }
        }
        return grid[m-1][n-1];
    }
}


//Solution 2
public class Solution {
    public int uniquePaths(int m, int n) {
        int[] grid = new int[n];
        grid[0] = 1;
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(j>0){
                    grid[j] += grid[j-1];
                }
            }
        }
        return grid[n-1];
    }
}



//Solution 3
public class Solution {
    public int uniquePaths(int m, int n) {
        int N = n+m-2;
        int k = m-1;
        double path = 1;
        for(int i = 1; i <= k; ++i){
            path = path * (N-k+i)/i;
        }
        return (int)path;
    }
}
