'''
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

'''


'''
Solution 1
BFS

use queue to store [i, j, len]
use visited to mark visited i,j cell
each time, find next possible cell

Time Complexity: O(mn)
Space Complexity: O(mn)
'''
class Solution:
    def shortestPathBinaryMatrix(self, grid: List[List[int]]) -> int:
        if grid[0][0] == 1:
            return -1

        m = len(grid)
        n = len(grid[0])

        visited = [[False for j in range(n)] for i in range(m)]
        visited[0][0] = True

        # bfs [r, c, len]
        queue = [[0, 0, 1]]

        direction = [-1, -1, 1, -1, 0, 1, 1, 0, -1]

        while queue:
            [r, c, l] = queue.pop(0)
            if r == m-1 and c == n-1:
                return l

            for d in range(8):
                i = r+direction[d]
                j = c+direction[d+1]
                if i >= 0 and i < m and j >= 0 and j < n and grid[i][j] == 0 and visited[i][j] == False:
                    visited[i][j] = True
                    queue.append([i, j, l+1])

        return -1

