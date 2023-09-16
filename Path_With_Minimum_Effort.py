'''
You are a hiker preparing for an upcoming hike. You are given heights, a 2D array of size rows x columns, where heights[row][col] represents the height of cell (row, col). You are situated in the top-left cell, (0, 0), and you hope to travel to the bottom-right cell, (rows-1, columns-1) (i.e., 0-indexed). You can move up, down, left, or right, and you wish to find a route that requires the minimum effort.

A route's effort is the maximum absolute difference in heights between two consecutive cells of the route.

Return the minimum effort required to travel from the top-left cell to the bottom-right cell.



Example 1:



Input: heights = [[1,2,2],[3,8,2],[5,3,5]]
Output: 2
Explanation: The route of [1,3,5,3,5] has a maximum absolute difference of 2 in consecutive cells.
This is better than the route of [1,2,2,2,5], where the maximum absolute difference is 3.
Example 2:



Input: heights = [[1,2,3],[3,8,4],[5,3,5]]
Output: 1
Explanation: The route of [1,2,3,4,5] has a maximum absolute difference of 1 in consecutive cells, which is better than route [1,3,5,3,5].
Example 3:


Input: heights = [[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]
Output: 0
Explanation: This route does not require any effort.


Constraints:

rows == heights.length
columns == heights[i].length
1 <= rows, columns <= 100
1 <= heights[i][j] <= 106

Hint 1:
Consider the grid as a graph, where adjacent cells have an edge with cost of the difference between the cells
Hint 2:
If you are given threshold k, check if it is possible to go from (0, 0) to (n-1, m-1) using only edges of ≤ k cost.

Hint 3:
Binary search the k value.
'''

'''
Solution 1:
binary search
if we can find a route has <= k cost

Time Complexity: O(mnlogn)
Space Complexity: O(mn)
'''
class Solution:
    def minimumEffortPath(self, heights: List[List[int]]) -> int:
        dir = [0, 1, 0, -1, 0]

        m = len(heights)
        n = len(heights[0])

        if m == 1 and n == 1: return 0

        def canFind(target: int) -> bool:
            nonlocal heights, m, n
            queue = [[0,0]]
            visited = [[False for _ in range(n)] for _ in range(m)]
            visited[0][0] = True

            while queue:
                [curR, curC] = queue.pop(0)

                if curR == m-1 and curC == n-1:
                    return True

                for d in range(4):
                    row = curR+dir[d]
                    col = curC+dir[d+1]

                    if row >= 0 and row < m and col >= 0 and col < n and not visited[row][col] and abs(heights[row][col] - heights[curR][curC]) <= target:
                        queue.append([row, col])
                        visited[row][col] = True
            return False

        left = 0
        right = 1000000-1
        while left < right:
            mid = left + (right-left)//2
            if canFind(mid):
                right = mid
            else:
                left = mid+1
        return left


