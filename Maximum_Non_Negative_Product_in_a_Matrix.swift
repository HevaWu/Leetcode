/*
You are given a rows x cols matrix grid. Initially, you are located at the top-left corner (0, 0), and in each step, you can only move right or down in the matrix.

Among all possible paths starting from the top-left corner (0, 0) and ending in the bottom-right corner (rows - 1, cols - 1), find the path with the maximum non-negative product. The product of a path is the product of all integers in the grid cells visited along the path.

Return the maximum non-negative product modulo 109 + 7. If the maximum product is negative return -1.

Notice that the modulo is performed after getting the maximum product.



Example 1:

Input: grid = [[-1,-2,-3],
               [-2,-3,-3],
               [-3,-3,-2]]
Output: -1
Explanation: It's not possible to get non-negative product in the path from (0, 0) to (2, 2), so return -1.
Example 2:

Input: grid = [[1,-2,1],
               [1,-2,1],
               [3,-4,1]]
Output: 8
Explanation: Maximum non-negative product is in bold (1 * 1 * -2 * -4 * 1 = 8).
Example 3:

Input: grid = [[1, 3],
               [0,-4]]
Output: 0
Explanation: Maximum non-negative product is in bold (1 * 0 * -4 = 0).
Example 4:

Input: grid = [[ 1, 4,4,0],
               [-2, 0,0,1],
               [ 1,-1,1,1]]
Output: 2
Explanation: Maximum non-negative product is in bold (1 * -2 * 1 * -1 * 1 * 1 = 2).


Constraints:

1 <= rows, cols <= 15
-4 <= grid[i][j] <= 4
*/

/*
Solution 2:
optimize Solution 1 code

init top, right first, kind of clean code

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func maxProductPath(_ grid: [[Int]]) -> Int {
        let mod = Int(1e9+7)
        let m = grid.count
        let n = grid[0].count

        // dp[i][j] is [highest product, lowest product] until grid[i][j]
        var dp: [[[Int]]] = Array(
            repeating: Array(repeating: [0, 0], count: n),
            count: m
        )
        dp[0][0] = [grid[0][0], grid[0][0]]

        // init right
        for i in 1..<m {
            let val = grid[i][0] * dp[i-1][0][0]
            dp[i][0] = [val, val]
        }

        // init top
        for j in 1..<n {
            let val = grid[0][j] * dp[0][j-1][0]
            dp[0][j] = [val, val]
        }

        for i in 1..<m {
            for j in 1..<n {
                if grid[i][j] > 0 {
                    dp[i][j] = [
                        max(grid[i][j]*dp[i-1][j][0], grid[i][j]*dp[i][j-1][0]),
                        min(grid[i][j]*dp[i-1][j][1], grid[i][j]*dp[i][j-1][1]),
                    ]
                } else {
                    dp[i][j] = [
                        max(grid[i][j]*dp[i-1][j][1], grid[i][j]*dp[i][j-1][1]),
                        min(grid[i][j]*dp[i-1][j][0], grid[i][j]*dp[i][j-1][0]),
                    ]
                }
            }
        }

        // print(dp)
        return dp[m-1][n-1][0] >= 0 ? dp[m-1][n-1][0] % mod : -1
    }
}

/*
Solution 1:
DP

dp[i][j] record [highest product, lowest product]

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func maxProductPath(_ grid: [[Int]]) -> Int {
        let mod = Int(1e9+7)
        let m = grid.count
        let n = grid[0].count

        // dp[i][j] is [highest product, lowest product] until grid[i][j]
        var dp: [[[Int]]] = Array(
            repeating: Array(repeating: [Int.min, Int.max], count: n),
            count: m
        )
        dp[0][0] = [grid[0][0], grid[0][0]]

        for i in 0..<m {
            for j in 0..<n {
                if i > 0 {
                    if grid[i][j] > 0 {
                        dp[i][j] = [
                            max(
                                dp[i][j][0],
                                grid[i][j] * dp[i-1][j][0]
                            ),
                            min(
                                dp[i][j][1],
                                grid[i][j] * dp[i-1][j][1]
                            )
                        ]
                    } else {
                        dp[i][j] = [
                            max(
                                dp[i][j][0],
                                grid[i][j] * dp[i-1][j][1]
                            ),
                            min(
                                dp[i][j][1],
                                grid[i][j] * dp[i-1][j][0]
                            )
                        ]
                    }
                }
                if j > 0 {
                    if grid[i][j] > 0 {
                        dp[i][j] = [
                            max(
                                dp[i][j][0],
                                grid[i][j] * dp[i][j-1][0]
                            ),
                            min(
                                dp[i][j][1],
                                grid[i][j] * dp[i][j-1][1]
                            )
                        ]
                    } else {
                        dp[i][j] = [
                            max(
                                dp[i][j][0],
                                grid[i][j] * dp[i][j-1][1]
                            ),
                            min(
                                dp[i][j][1],
                                grid[i][j] * dp[i][j-1][0]
                            )
                        ]
                    }
                }
            }
        }

        // print(dp)
        return dp[m-1][n-1][0] >= 0 ? dp[m-1][n-1][0] % mod : -1
    }
}