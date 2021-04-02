/*
There is an m by n grid with a ball. Given the start coordinate (i,j) of the ball, you can move the ball to adjacent cell or cross the grid boundary in four directions (up, down, left, right). However, you can at most move N times. Find out the number of paths to move the ball out of grid boundary. The answer may be very large, return it after mod 109 + 7.



Example 1:

Input: m = 2, n = 2, N = 2, i = 0, j = 0
Output: 6
Explanation:

Example 2:

Input: m = 1, n = 3, N = 3, i = 0, j = 1
Output: 12
Explanation:



Note:

Once you move the ball out of boundary, you cannot move it back.
The length and height of the grid is in range [1,50].
N is in range [0,50].
*/

/*
Solution 2:
DP

dp[i][j] -> number of ways (i,j) can be reached given some particular number of moves

dp[i][j] = dp[i-1][j] + dp[i+1][j] + dp[i][j-1] + dp[i][j+1]

Time Complexity: O(mnN)
Space Complexity: O(mn)
*/
class Solution {
    func findPaths(_ m: Int, _ n: Int, _ N: Int, _ i: Int, _ j: Int) -> Int {
        if N == 0 { return 0 }

        let mod = Int(1e9 + 7)
        let dir = [0, 1, 0, -1, 0]

        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )

        dp[i][j] = 1
        var count = 0

        for moves in 1...N {
            var temp = Array(
                repeating: Array(repeating: 0, count: n),
                count: m
            )
            for r in 0..<m {
                for c in 0..<n {
                    if r == m-1 {
                        count = (count + dp[r][c]) % mod
                    }
                    if c == n-1 {
                        count = (count + dp[r][c]) % mod
                    }
                    if r == 0 {
                        count = (count + dp[r][c]) % mod
                    }
                    if c == 0 {
                        count = (count + dp[r][c]) % mod
                    }
                    temp[r][c] = ((
                        (r > 0 ? dp[r-1][c] : 0) + (c > 0 ? dp[r][c-1] : 0)
                    ) % mod + (
                        (r < m-1 ? dp[r+1][c] : 0) + (c < n-1 ? dp[r][c+1] : 0)
                    ) % mod) % mod
                }
            }
            dp = temp
        }

        return count
    }
}

/*
Solution 1:
recursion with memoization

use memo[i][j][k]
to record number of possible moves leading to a path out of boundary
when ball at [i][j], with remaining k moves left

Time Complexity: O(mnN)
Space Complexity: O(mnN)
*/
class Solution {
    func findPaths(_ m: Int, _ n: Int, _ N: Int, _ i: Int, _ j: Int) -> Int {
        if N == 0 { return 0 }

        let mod = Int(1e9 + 7)
        let dir = [0, 1, 0, -1, 0]

        // memo[i][j][k] store number of possible moves leading to a path out
        // if current pos is [i][j] and moves left k
        var memo = Array(
            repeating: Array(
                repeating: Array(repeating: -1, count: N+1),
                count: n
            ),
            count: m
        )

        return dfs(i, j, m, n, N, dir, mod, &memo)
    }

    func dfs(_ i: Int, _ j: Int,
             _ m: Int, _ n: Int,
             _ N: Int,
             _ dir: [Int], _ mod: Int,
             _ memo: inout [[[Int]]]) -> Int {

        if i >= m || i < 0 || j >= n || j < 0 { return 1 }
        if N == 0 { return 0 }

        if memo[i][j][N] >= 0 { return memo[i][j][N] }

        memo[i][j][N] = 0
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            memo[i][j][N] = (memo[i][j][N] + dfs(r, c, m, n, N-1, dir, mod, &memo)) % mod
        }

        return memo[i][j][N]
    }
}