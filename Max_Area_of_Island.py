'''
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
'''

'''
Solution 1:
DFS + iterative

once find a 1 cell, dfs to count this island
then compare it with area

Time Complexity: O(mn)
Space Complexity: O(mn)
'''
class Solution:
    def maxAreaOfIsland(self, grid: List[List[int]]) -> int:
        self.grid = grid
        self.m = len(grid)
        self.n = len(grid[0])
        self.direction = [0, 1, 0, -1, 0]

        area = 0
        for i in range(self.m):
            for j in range(self.n):
                if grid[i][j] == 1:
                    area = max(area, self.check(i, j))
        return area

    def check(self, i: int, j: int) -> int:
        area = 0
        stack = []
        stack.append([i, j])
        area += 1
        self.grid[i][j] = -1

        while stack:
            [r, c] = stack.pop(-1)
            for d in range(4):
                r1 = r + self.direction[d]
                c1 = c + self.direction[d+1]
                if r1 >= 0 and r1 < self.m and c1 >= 0 and c1 < self.n and self.grid[r1][c1] == 1:
                    self.grid[r1][c1] = -1
                    area += 1
                    stack.append([r1, c1])
        return area
