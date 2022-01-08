'''
Given a rows x cols matrix grid representing a field of cherries. Each cell in grid represents the number of cherries that you can collect.

You have two robots that can collect cherries for you, Robot #1 is located at the top-left corner (0,0) , and Robot #2 is located at the top-right corner (0, cols-1) of the grid.

Return the maximum number of cherries collection using both robots  by following the rules below:

From a cell (i,j), robots can move to cell (i+1, j-1) , (i+1, j) or (i+1, j+1).
When any robot is passing through a cell, It picks it up all cherries, and the cell becomes an empty cell (0).
When both robots stay on the same cell, only one of them takes the cherries.
Both robots cannot move outside of the grid at any moment.
Both robots should reach the bottom row in the grid.


Example 1:



Input: grid = [[3,1,1],[2,5,1],[1,5,5],[2,1,1]]
Output: 24
Explanation: Path of robot #1 and #2 are described in color green and blue respectively.
Cherries taken by Robot #1, (3 + 2 + 5 + 2) = 12.
Cherries taken by Robot #2, (1 + 5 + 5 + 1) = 12.
Total of cherries: 12 + 12 = 24.
Example 2:



Input: grid = [[1,0,0,0,0,0,1],[2,0,0,0,0,3,0],[2,0,9,0,0,0,0],[0,3,0,5,4,0,0],[1,0,2,3,0,0,6]]
Output: 28
Explanation: Path of robot #1 and #2 are described in color green and blue respectively.
Cherries taken by Robot #1, (1 + 9 + 5 + 2) = 17.
Cherries taken by Robot #2, (1 + 3 + 4 + 3) = 11.
Total of cherries: 17 + 11 = 28.
Example 3:

Input: grid = [[1,0,0,3],[0,0,0,3],[0,0,3,3],[9,0,3,3]]
Output: 22
Example 4:

Input: grid = [[1,1],[1,1]]
Output: 4


Constraints:

rows == grid.length
cols == grid[i].length
2 <= rows, cols <= 70
0 <= grid[i][j] <= 100

Use dynammic programming, define DP[i][j][k]: The maximum cherries that both robots can take starting on the ith row, and column j and k of Robot 1 and 2 respectively.
'''

'''
Solution 2:
bottom up DP

Time Compexity: O(m * n^2)
Space Complexity: O(m * n *n)
'''
class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])
        dp = [[[0 for r in range(n)] for c1 in range(n)] for c2 in range(m)]

        for r in range(m-1, -1, -1):
            for c1 in range(n):
                for c2 in range(n):
                    val = 0
                    if r < m-1:
                        for nextC1 in [c1-1, c1, c1+1]:
                            for nextC2 in [c2-1, c2, c2+1]:
                                if nextC1 >= 0 and nextC1 < n and nextC2 >= 0 and nextC2 < n:
                                    val = max(val, dp[r+1][nextC1][nextC2])
                    val += grid[r][c1] + (0 if c1 == c2 else grid[r][c2])
                    dp[r][c1][c2] = val

        return dp[0][0][n-1]



'''
Solution 1:
DP, dfsCherry_Pickup_II

count cherries
dp[r][c1][c2] // for r-th row, robot 1 in c1, robot 2 in c2
- i in [-1,0,1]
- j in [-1,0,1]
- res = max(res, dfs(r,c1+i, c2+j))

TimeCompexity:
O(9 * m * n^2)
'''
class Solution:
    def cherryPickup(self, grid: List[List[int]]) -> int:
        m = len(grid)
        n = len(grid[0])

        @lru_cache(None)
        def dfs(r, c1, c2):
            if r == m:
                return 0
            val = 0
            for s1 in [-1, 0, 1]:
                for s2 in [-1, 0, 1]:
                    nextC1 = c1 + s1
                    nextC2 = c2 + s2
                    if nextC1 >= 0 and nextC1 < n and nextC2 >= 0 and nextC2 < n:
                        val = max(val, dfs(r+1, nextC1, nextC2))
            val += grid[r][c1] + (0 if c1 == c2 else grid[r][c2])
            return val

        return dfs(0, 0, n-1)


