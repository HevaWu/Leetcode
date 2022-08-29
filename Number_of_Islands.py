'''
Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.



Example 1:

Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
Output: 1
Example 2:

Input: grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
Output: 3


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 300
grid[i][j] is '0' or '1'.
'''

'''
Solution 1:
DFS with stack

grid[i][j] = "0" water
grid[i][j] = "1" un-visited island
grid[i][j] = "#" visited island

Time Complexity: O(mn)
Space Complexity: O(mn)
'''
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:
        m = len(grid)
        n = len(grid[0])

        island = 0

        def dfs(i: int, j: int):
            # mark i,j as visited island
            grid[i][j] = "#"
            direction = [0, 1, 0, -1, 0]

            stack = [(i, j)]
            while stack:
                (r, c) = stack.pop(-1)
                for d in range(4):
                    nr = r + direction[d]
                    nc = c + direction[d+1]
                    if nr >= 0 and nr < m and nc >= 0 and nc < n and grid[nr][nc] == "1":
                        grid[nr][nc] = "#"
                        stack.append((nr, nc))

        for i in range(m):
            for j in range(n):
                if grid[i][j] == "1":
                    island += 1
                    dfs(i, j)

        return island

