'''
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
'''

'''
Solution 1:
backTracking

find start cell,
count number of 0 cell

backTrack to find possible paths

Time Complexity: O(3^(mn))
Space Complexity: O(mn)
'''
class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        start = [-1, -1]
        cell = 0

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    start = [i, j]
                elif grid[i][j] == 0:
                    cell += 1

        # mark start point as visited
        grid[start[0]][start[1]] = -1
        path = 0
        directions = [0, -1, 0, 1, 0]

        def check(i: int, j: int, cell: int):
            nonlocal m, n, directions, grid, path
            for d in range(4):
                r = i + directions[d]
                c = j + directions[d+1]

                if r >= 0 and r < m and c >= 0 and c < n and grid[r][c] >= 0:
                    if grid[r][c] == 2:
                        if cell == 0:
                            path += 1
                    elif cell > 0:
                        grid[r][c] = -1
                        check(r, c, cell-1)
                        grid[r][c] = 0

        check(start[0], start[1], cell)
        return path



