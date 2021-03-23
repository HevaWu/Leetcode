/*
Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right, which minimizes the sum of all numbers along its path.

Note: You can only move either down or right at any point in time.

 

Example 1:


Input: grid = [[1,3,1],[1,5,1],[4,2,1]]
Output: 7
Explanation: Because the path 1 → 3 → 1 → 1 → 1 minimizes the sum.
Example 2:

Input: grid = [[1,2,3],[4,5,6]]
Output: 12
 

Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 200
0 <= grid[i][j] <= 100
*/

/*
Solution 3:
one array dp

Time Complexity: O(mn)
Space Complexity: O(n)
*/
class Solution {
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        
        var dp = Array(repeating: Int.max, count: n)
        dp[0] = grid[0][0]
        
        for i in 0..<m {
            for j in 0..<n {
                if i > 0 {
                    dp[j] += grid[i][j]
                }
                
                if j > 0 {
                    dp[j] = min(dp[j], dp[j-1] + grid[i][j])
                }                
            }
        }
        
        return dp[n-1]
    }
}

/*
Solution 2:
DP

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        
        // dp[i][j], minSum from top left to (i, j) cell
        var dp = Array(repeating: Array(repeating: Int.max, count: n), 
                       count: m)
        
        dp[0][0] = grid[0][0]
        for i in 0..<m {
            for j in 0..<n {
                if i > 0 {
                    dp[i][j] = min(dp[i][j], dp[i-1][j] + grid[i][j])
                }
                
                if j > 0 {
                    dp[i][j] = min(dp[i][j], dp[i][j-1] + grid[i][j])
                }
                
                // print(i, j, dp[i][j])
            }
        }
        
        return dp[m-1][n-1]
    }
}

/*
Solution 1:
dfs
Time limit exceeded

check all paths

Time Complexity: O(m*n)
Space Complexity: O(1)
*/
class Solution {
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        
        var sum = Int.max
        check(grid, 0, 0, m, n, grid[0][0], &sum)
        return sum
    }
    
    func check(_ grid: [[Int]], 
               _ i: Int, _ j: Int,
               _ m: Int, _ n: Int,
               _ cur: Int, _ sum: inout Int) {
        if i == m-1, j == n-1 { 
            sum = min(sum, cur)
            return
        }
        
        if i < m-1 {
            check(grid, i+1, j, m, n, cur+grid[i+1][j], &sum)
        }
        
        if j < n-1 {
            check(grid, i, j+1, m, n, cur+grid[i][j+1], &sum)
        }
    }
}