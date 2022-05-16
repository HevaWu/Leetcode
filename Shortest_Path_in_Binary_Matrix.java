/*
In an N by N square grid, each cell is either empty (0) or blocked (1).

A clear path from top-left to bottom-right has length k if and only if it is composed of cells C_1, C_2, ..., C_k such that:

Adjacent cells C_i and C_{i+1} are connected 8-directionally (ie., they are different and share an edge or corner)
C_1 is at location (0, 0) (ie. has value grid[0][0])
C_k is at location (N-1, N-1) (ie. has value grid[N-1][N-1])
If C_i is located at (r, c), then grid[r][c] is empty (ie. grid[r][c] == 0).
Return the length of the shortest such clear path from top-left to bottom-right.  If such a path does not exist, return -1.



Example 1:

Input: [[0,1],[1,0]]


Output: 2

Example 2:

Input: [[0,0,0],[1,1,0],[1,1,0]]


Output: 4



Note:

1 <= grid.length == grid[0].length <= 100
grid[r][c] is 0 or 1

*/


/*
Solution 1
BFS

use queue to store [i, j, len]
use visited to mark visited i,j cell
each time, find next possible cell

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    public int shortestPathBinaryMatrix(int[][] grid) {
        if (grid[0][0] == 1) {
            return -1;
        }

        int m = grid.length;
        int n = grid[0].length;

        int[] dir = new int[]{-1, -1, 1, -1, 0, 1, 1, 0, -1};

        // bfs, [r, c, len]
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 1});

        boolean[][] visited = new boolean[m][n];
        visited[0][0] = true;

        while (queue.size() > 0) {
            int[] cur = queue.poll();
            int r = cur[0];
            int c = cur[1];
            int len = cur[2];

            if (r == m-1 && c == n-1) {
                return len;
            }

            for (int d = 0; d < 8; d++) {
                int i = r + dir[d];
                int j = c + dir[d+1];
                if (i >= 0 && i < m && j >= 0 && j < n
                   && grid[i][j] == 0 && !visited[i][j]) {
                    visited[i][j] = true;
                    queue.offer(new int[]{i, j, len+1});
                }
            }
        }
        return -1;
    }
}