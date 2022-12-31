public class Unique_Paths_III {

}
/*
On a 2-dimensional grid, there are 4 types of squares:

1 represents the starting square.  There is exactly one starting square.
2 represents the ending square.  There is exactly one ending square.
0 represents empty squares we can walk over.
-1 represents obstacles that we cannot walk over.
Return the number of 4-directional walks from the starting square to the ending square, that walk over every non-obstacle square exactly once.



Example 1:

Input: [[1,0,0,0],[0,0,0,0],[0,0,2,-1]]
Output: 2
Explanation: We have the following two paths:
1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2)
2. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2)
Example 2:

Input: [[1,0,0,0],[0,0,0,0],[0,0,0,2]]
Output: 4
Explanation: We have the following four paths:
1. (0,0),(0,1),(0,2),(0,3),(1,3),(1,2),(1,1),(1,0),(2,0),(2,1),(2,2),(2,3)
2. (0,0),(0,1),(1,1),(1,0),(2,0),(2,1),(2,2),(1,2),(0,2),(0,3),(1,3),(2,3)
3. (0,0),(1,0),(2,0),(2,1),(2,2),(1,2),(1,1),(0,1),(0,2),(0,3),(1,3),(2,3)
4. (0,0),(1,0),(2,0),(2,1),(1,1),(0,1),(0,2),(0,3),(1,3),(1,2),(2,2),(2,3)
Example 3:

Input: [[0,1],[2,0]]
Output: 0
Explanation:
There is no path that walks over every empty square exactly once.
Note that the starting and ending square can be anywhere in the grid.


Note:

1 <= grid.length * grid[0].length <= 20
*/

/*
Solution 1:
backTracking

find start cell,
count number of 0 cell

backTrack to find possible paths

Time Complexity: O(3^(mn))
Space Complexity: O(mn)
*/
class Solution {
    private int[] dir = new int[]{0, -1, 0, 1, 0};
    private int path = 0;
    public int uniquePathsIII(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int[] start = new int[]{-1, -1};
        int cell = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    //i,j is start point
                    start[0] = i;
                    start[1] = j;
                } else if (grid[i][j] == 0) {
                    cell += 1;
                }
            }
        }

        grid[start[0]][start[1]] = -1;
        check(start[0], start[1], m, n, grid, cell);
        return path;
    }

    void check(int i, int j, int m, int n,
    int[][] grid, int cell) {
        for (int d = 0; d < 4; d++) {
            int r = i + dir[d];
            int c = j + dir[d+1];
            if (r >= 0 && r < m && c >= 0 && c < n && grid[r][c] >= 0) {
                if (grid[r][c] == 2) {
                    if (cell == 0) {
                        path += 1;
                    }
                } else if (cell > 0) {
                    grid[r][c] = -1;
                    check(r, c, m, n, grid, cell-1);
                    grid[r][c] = 0;
                }
            }
        }
    }
}
