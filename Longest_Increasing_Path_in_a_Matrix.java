/*
Given an integer matrix, find the length of the longest increasing path.

From each cell, you can either move to four directions: left, right, up or down. You may NOT move diagonally or move outside of the boundary (i.e. wrap-around is not allowed).

Example 1:

Input: nums =
[
  [9,9,4],
  [6,6,8],
  [2,1,1]
]
Output: 4
Explanation: The longest increasing path is [1, 2, 6, 9].
Example 2:

Input: nums =
[
  [3,4,5],
  [3,2,6],
  [2,2,1]
]
Output: 4
Explanation: The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.
*/

/*
Solution 2: DFS + memorization
Cache the results for the recursion so that any subproblem will be calculated only once.
use a set to prevent the repeat visit in one DFS search. This optimization will reduce the time complexity for each DFS to O(mn)O(mn) and the total algorithm to O(m^2n^2)
//
Time complexity : O(mn). Each vertex/cell will be calculated once and only once, and each edge will be visited once and only once. The total time complexity is then O(V+E). V is the total number of vertices and E is the total number of edges. In our problem, O(V) = O(mn), O(E) = O(4V) = O(mn).
Space complexity : O(mn). The cache dominates the space complexity.
*/
public class Solution {
    public int longestIncreasingPath(int[][] matrix) {
        int rows = matrix.length;
        if(rows == 0) return 0;
        int cols = matrix[0].length;

        int[][] longPath = new int[rows][cols];
        int res = 0;
        for(int i = 0; i < rows; i++){
            for(int j = 0; j < cols; j++){
                res = Math.max(res,
                        increasePath(matrix, longPath, rows, cols, i, j));
            }
        }
        return res;

    }
    public int increasePath(int[][] matrix, int[][] longPath, int rows, int cols, int x, int y){
        if(longPath[x][y] != 0) return longPath[x][y];
        int[][] choos = {{-1,0}, {1,0}, {0,1}, {0,-1}}; //define four directions
        // for(int i = 0; i < choos.length; i++){
        //     int xx = x + choos[i][0];
        //     int yy = y + choos[i][1];
        //     if(xx<0 || xx>=rows || yy<0 || yy>=cols)
        //         continue;
        //     if(matrix[xx][yy] <= matrix[x][y])
        //         continue;
        //     longPath[x][y] = Math.max(longPath[x][y], increasePath(matrix, longPath, rows, cols, xx, yy));
        // }
        for(int[] dir:choos){
            int xx = x + dir[0];
            int yy = y + dir[1];

            if(xx<0 || xx>=rows || yy<0 || yy>=cols){
                continue;
            }
            if(matrix[xx][yy] <= matrix[x][y]){
                continue;
            }

            longPath[x][y] = Math.max(longPath[x][y],
                            increasePath(matrix, longPath, rows, cols, xx, yy));
        }
        return ++longPath[x][y];
    }
}