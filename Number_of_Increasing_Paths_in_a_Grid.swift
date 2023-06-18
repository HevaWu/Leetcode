/*
You are given an m x n integer matrix grid, where you can move from a cell to any adjacent cell in all 4 directions.

Return the number of strictly increasing paths in the grid such that you can start from any cell and end at any cell. Since the answer may be very large, return it modulo 109 + 7.

Two paths are considered different if they do not have exactly the same sequence of visited cells.



Example 1:


Input: grid = [[1,1],[3,4]]
Output: 8
Explanation: The strictly increasing paths are:
- Paths with length 1: [1], [1], [3], [4].
- Paths with length 2: [1 -> 3], [1 -> 4], [3 -> 4].
- Paths with length 3: [1 -> 3 -> 4].
The total number of paths is 4 + 3 + 1 = 8.
Example 2:

Input: grid = [[1],[2]]
Output: 3
Explanation: The strictly increasing paths are:
- Paths with length 1: [1], [2].
- Paths with length 2: [1 -> 2].
The total number of paths is 2 + 1 = 3.


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 1000
1 <= m * n <= 105
1 <= grid[i][j] <= 105
*/

/*
Solution 1:
DP

DFS to find the strictly increasing path start from i,j
add it to the result and mod it

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func countPaths(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        let dir = [0, 1, 0, -1, 0]
        var path = 0
        let mod = Int(1e9 + 7)
        var cache: [[Int?]] = Array(repeating: Array(repeating: nil, count: n), count: m)
        for i in 0..<m {
            for j in 0..<n {
                path = (path + check(i, j, m, n, grid, dir, &cache, mod)) % mod
            }
        }
        return path
    }

    // strictly increasing path, start from i, j
    // increased it to path
    func check(_ i: Int, _ j: Int, _ m: Int, _ n: Int, _ grid: [[Int]], _ dir: [Int], _ cache: inout [[Int?]], _ mod: Int) -> Int {
        if let val = cache[i][j] {
            return val
        }
        var val = 1 // it always have one path, which is [grid[i][j]]
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, grid[r][c] > grid[i][j] {
                val = (val + check(r, c, m, n, grid, dir, &cache, mod)) % mod
            }
        }
        cache[i][j] = val
        return val
    }
}
