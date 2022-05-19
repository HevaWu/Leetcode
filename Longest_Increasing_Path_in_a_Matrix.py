'''
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
'''

'''
Solution 2: DFS + memorization
Cache the results for the recursion so that any subproblem will be calculated only once.
use a set to prevent the repeat visit in one DFS search. This optimization will reduce the time complexity for each DFS to O(mn)O(mn) and the total algorithm to O(m^2n^2)
//
Time complexity : O(mn). Each vertex/cell will be calculated once and only once, and each edge will be visited once and only once. The total time complexity is then O(V+E). V is the total number of vertices and E is the total number of edges. In our problem, O(V) = O(mn), O(E) = O(4V) = O(mn).
Space complexity : O(mn). The cache dominates the space complexity.
'''
class Solution:
    def longestIncreasingPath(self, matrix: List[List[int]]) -> int:
        m = len(matrix)
        n = len(matrix[0])

        direction = [0, -1, 0, 1, 0]

        @lru_cache(None)
        def check(i, j) -> int:
            path = 0
            for d in range(4):
                r = i + direction[d]
                c = j + direction[d+1]
                if r >= 0 and r < m and c >= 0 and c < n and matrix[r][c] > matrix[i][j]:
                    path = max(path, check(r, c))

            return path+1

        longestPath = 0
        for i in range(m):
            for j in range(n):
                longestPath = max(longestPath, check(i, j))

        return longestPath
