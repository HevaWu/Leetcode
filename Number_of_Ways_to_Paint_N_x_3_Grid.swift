/*
You have a grid of size n x 3 and you want to paint each cell of the grid with exactly one of the three colors: Red, Yellow, or Green while making sure that no two adjacent cells have the same color (i.e., no two cells that share vertical or horizontal sides have the same color).

Given n the number of rows of the grid, return the number of ways you can paint this grid. As the answer may grow large, the answer must be computed modulo 109 + 7.



Example 1:


Input: n = 1
Output: 12
Explanation: There are 12 possible way to paint the grid as shown.
Example 2:

Input: n = 2
Output: 54
Example 3:

Input: n = 3
Output: 246
Example 4:

Input: n = 7
Output: 106494
Example 5:

Input: n = 5000
Output: 30228214


Constraints:

n == grid.length
grid[i].length == 3
1 <= n <= 5000
*/

/*
Solution 2:
DP

Two pattern for each row, 121 and 123.
121, the first color same as the third in a row.
123, one row has three different colors.

We consider the state of the first row,
pattern 121: 121, 131, 212, 232, 313, 323.
pattern 123: 123, 132, 213, 231, 312, 321.
So we initialize a121 = 6, a123 = 6.

We consider the next possible for each pattern:
Patter 121 can be followed by: 212, 213, 232, 312, 313
Patter 123 can be followed by: 212, 231, 312, 232

121 => three 121, two 123
123 => two 121, two 123

So we can write this dynamic programming transform equation:
b121 = a121 * 3 + a123 * 2
b123 = a121 * 2 + a123 * 2

We calculate the result iteratively
and finally return the sum of both pattern a121 + a123

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func numOfWays(_ n: Int) -> Int {
        let mod = Int(1e9 + 7)

        // b121 = a121 * 3 + a123 * 2
        // b123 = a121 * 2 + a123 * 2
        var a121 = 6
        var a123 = 6
        var b121 = 0
        var b123 = 0

        for i in 1..<n {
            b121 = a121 * 3 + a123 * 2
            b123 = a121 * 2 + a123 * 2
            a121 = b121 % mod
            a123 = b123 % mod
        }

        return (a121 + a123) % mod
    }
}

/*
Solution 1:
DFS + DP

Time Complexity: O(3*3*3*n)
Space Complexity: O(3*3*3*n)
*/
class Solution {
    func numOfWays(_ n: Int) -> Int {
        let mod = Int(1e9 + 7)

        // dp[i][c1][c2][c3], ith row with c1, c2, c3 color
        // color 1,2,3 means red, yellow, green
        var dp = Array(
            repeating: Array(
                repeating: Array(
                    repeating: Array(repeating: 0, count: 4),
                    count: 4
                ),
                count: 4
            ),
            count: n+1
        )

        return dfs(n, 0, 0, 0, &dp, mod)
    }

    func dfs(_ n: Int, _ c1: Int, _ c2: Int, _ c3: Int,
             _ dp: inout [[[[Int]]]], _ mod: Int) -> Int {
        if n == 0 { return 1 }
        if dp[n][c1][c2][c3] != 0 { return dp[n][c1][c2][c3] }

        var val = 0
        for a in 1...3 {
            // check if same color with below neighbor
            if c1 == a { continue }
            for b in 1...3 {
                // check if same color with below neighbor and left neighbor
                if c2 == b || a == b { continue }
                for c in 1...3 {
                    // check if same color with below neighbor and left neighbor
                    if c3 == c || b == c { continue }
                    val += dfs(n-1, a, b, c, &dp, mod)
                    val = val % mod
                }
            }
        }

        dp[n][c1][c2][c3] = val
        return val
    }
}