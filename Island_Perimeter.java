/*
You are given row x col grid representing a map where grid[i][j] = 1 represents land and grid[i][j] = 0 represents water.

Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells).

The island doesn't have "lakes", meaning the water inside isn't connected to the water around the island. One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.



Example 1:


Input: grid = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
Output: 16
Explanation: The perimeter is the 16 yellow stripes in the image above.
Example 2:

Input: grid = [[1]]
Output: 4
Example 3:

Input: grid = [[1,0]]
Output: 4


Constraints:

row == grid.length
col == grid[i].length
1 <= row, col <= 100
grid[i][j] is 0 or 1.
There is exactly one island in grid.
*/

/*
Solution 1:
go through all cells, check its 4 connected cells

if current is island, check if any 4 connected cell is also island, if so, val -= 1
because, only have 1 island, no inside lakes

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    public int islandPerimeter(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int perimeter = 0;
        int[] dir = new int[] {0, 1, 0, -1, 0};

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    continue;
                }

                int val = 4;
                for (int d = 0; d < 4; d++) {
                    int r = i + dir[d];
                    int c = j + dir[d+1];
                    if (r >= 0 && r < m && c >= 0 && c < n && grid[r][c] == 1) {
                        val -= 1;
                    }
                }
                perimeter += val;
            }
        }
        return perimeter;
    }
}