/*
You are a hiker preparing for an upcoming hike. You are given heights, a 2D
array of size rows x columns, where heights[row][col] represents the height of
cell (row, col). You are situated in the top-left cell, (0, 0), and you hope to
travel to the bottom-right cell, (rows-1, columns-1) (i.e., 0-indexed). You can
move up, down, left, or right, and you wish to find a route that requires the
minimum effort.

A route's effort is the maximum absolute difference in heights between two
consecutive cells of the route.

Return the minimum effort required to travel from the top-left cell to the
bottom-right cell.



Example 1:



Input: heights = [[1,2,2],[3,8,2],[5,3,5]]
Output: 2
Explanation: The route of [1,3,5,3,5] has a maximum absolute difference of 2 in
consecutive cells. This is better than the route of [1,2,2,2,5], where the
maximum absolute difference is 3. Example 2:



Input: heights = [[1,2,3],[3,8,4],[5,3,5]]
Output: 1
Explanation: The route of [1,2,3,4,5] has a maximum absolute difference of 1 in
consecutive cells, which is better than route [1,3,5,3,5]. Example 3:


Input: heights = [[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]
Output: 0
Explanation: This route does not require any effort.


Constraints:

rows == heights.length
columns == heights[i].length
1 <= rows, columns <= 100
1 <= heights[i][j] <= 106

Hint 1:
Consider the grid as a graph, where adjacent cells have an edge with cost of the
difference between the cells.

Hint 2:
If you are given threshold k, check if it is possible to go from (0, 0) to (n-1,
m-1) using only edges of ≤ k cost.

Hint 3:
Binary search the k value.
*/

/*
Solution 1:
Dijkstra

Time Complexity: O(M∗N∗log(10 6))
Space Complexity: O(mn)
*/
class Solution {
 private:
  int effort[105][105];       // Store effort for each cell
  int dx[4] = {0, 1, -1, 0};  // Changes in x coordinate for each direction
  int dy[4] = {1, 0, 0, -1};  // Changes in y coordinate for each direction

 public:
  // Dijkstra's Algorithm to find minimum effort
  int dijkstra(vector<vector<int>>& heights) {
    int rows = heights.size();
    int cols = heights[0].size();

    // Priority queue to store {effort, {x, y}}
    std::priority_queue<std::pair<int, std::pair<int, int>>> pq;
    pq.push({0, {0, 0}});  // Start from the top-left cell
    effort[0][0] = 0;      // Initial effort at the starting cell

    while (!pq.empty()) {
      auto current = pq.top().second;
      int cost = -pq.top().first;  // Effort for the current cell
      pq.pop();

      int x = current.first;
      int y = current.second;

      // Skip if we've already found a better effort for this cell
      if (cost > effort[x][y]) continue;

      // Stop if we've reached the bottom-right cell
      if (x == rows - 1 && y == cols - 1) return cost;

      // Explore each direction (up, down, left, right)
      for (int i = 0; i < 4; i++) {
        int new_x = x + dx[i];
        int new_y = y + dy[i];

        // Check if the new coordinates are within bounds
        if (new_x < 0 || new_x >= rows || new_y < 0 || new_y >= cols) continue;

        // Calculate new effort for the neighboring cell
        int new_effort = std::max(
            effort[x][y], std::abs(heights[x][y] - heights[new_x][new_y]));

        // Update effort if a lower effort is found for the neighboring cell
        if (new_effort < effort[new_x][new_y]) {
          effort[new_x][new_y] = new_effort;
          pq.push({-new_effort, {new_x, new_y}});
        }
      }
    }
    return effort[rows - 1][cols - 1];  // Minimum effort for the path to the
                                        // bottom-right cell
  }

  // Function to find the minimum effort path
  int minimumEffortPath(vector<vector<int>>& heights) {
    // Initialize effort for each cell to maximum value
    for (int i = 0; i < heights.size(); i++) {
      for (int j = 0; j < heights[i].size(); j++) {
        effort[i][j] = INT_MAX;
      }
    }
    return dijkstra(heights);  // Find minimum effort using dijkstra
  }
};
