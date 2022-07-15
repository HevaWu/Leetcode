/*
You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

The area of an island is the number of cells with a value 1 in the island.

Return the maximum area of an island in grid. If there is no island, return 0.



Example 1:


Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
Output: 6
Explanation: The answer is not 11, because the island must be connected 4-directionally.
Example 2:

Input: grid = [[0,0,0,0,0,0,0,0]]
Output: 0


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 50
grid[i][j] is either 0 or 1.
*/

/*
Solution 1:
DFS + iterative

once find a 1 cell, dfs to count this island
then compare it with area

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    int[][] grid;
    int m;
    int n;
    public int maxAreaOfIsland(int[][] grid) {
        this.grid = grid;
        this.m = grid.length;
        this.n = grid[0].length;
        int area = 0;
        for(int i = 0; i < m; i++) {
            for(int j = 0; j < n; j++) {
                if(this.grid[i][j] == 1) {
                    area = Math.max(area, check(i, j));
                }
            }
        }
        return area;
    }

    int[] direction = new int[]{0, 1, 0, -1, 0};
    public int check(int i, int j) {
        int area = 0;
        Stack<int[]> stack = new Stack<>();
        stack.push(new int[]{i, j});
        area += 1;
        this.grid[i][j] = -1;

        while (stack.size() > 0) {
            int[] cur = stack.pop();
            int r = cur[0];
            int c = cur[1];

            for(int d = 0; d < 4; d++) {
                int r1 = r + direction[d];
                int c1 = c + direction[d+1];
                if (r1 >= 0 && r1 < this.m && c1 >= 0 && c1 < this.n && this.grid[r1][c1] == 1) {
                    this.grid[r1][c1] = -1;
                    area += 1;
                    stack.push(new int[]{r1, c1});
                }
            }
        }
        return area;
    }
}