/*
On an n x n chessboard, a knight starts at the cell (row, column) and attempts to make exactly k moves. The rows and columns are 0-indexed, so the top-left cell is (0, 0), and the bottom-right cell is (n - 1, n - 1).

A chess knight has eight possible moves it can make, as illustrated below. Each move is two cells in a cardinal direction, then one cell in an orthogonal direction.


Each time the knight is to move, it chooses one of eight possible moves uniformly at random (even if the piece would go off the chessboard) and moves there.

The knight continues moving until it has made exactly k moves or has moved off the chessboard.

Return the probability that the knight remains on the board after it has stopped moving.



Example 1:

Input: n = 3, k = 2, row = 0, column = 0
Output: 0.06250
Explanation: There are two moves (to (1,2), (2,1)) that will keep the knight on the board.
From each of those positions, there are also two moves that will keep the knight on the board.
The total probability the knight stays on the board is 0.0625.
Example 2:

Input: n = 1, k = 0, row = 0, column = 0
Output: 1.00000


Constraints:

1 <= n <= 25
0 <= k <= 100
0 <= row, column <= n - 1
*/

/*
Solution 1:
backtrack

find number of all possible on board
then divide it with pow(8, k)

Time Complexity: O(n*n*k)
Space Complexity: O(n*n*k)
*/
class Solution {
    func knightProbability(_ n: Int, _ k: Int, _ row: Int, _ column: Int) -> Double {
        if k == 0 { return 1.0 }

        // dp[i][j][k] the onboard number with k moves
        var dp:[[[Double?]]] = Array(
            repeating: Array(
                repeating: Array(repeating: nil, count: k+1),
                count: n
            ),
            count: n
        )

        return check(row, column, n, k, &dp) / (pow(Double(8), Double(k)))
    }

    func check(_ r: Int, _ c: Int, _ n: Int, _ k: Int, _ dp: inout [[[Double?]]]) -> Double {
        if let val = dp[r][c][k] { return val }
        if k == 0 {
            dp[r][c][k] = 1
            return 1
        }

        var val = 0.0
        for (i, j) in [(-2, -1), (-2, 1), (-1, -2), (-1, 2), (2, -1), (2, 1), (1, -2), (1, 2)] {
            let nr = r + i
            let nc = c + j
            if nr >= 0, nr < n, nc >= 0, nc < n {
                val += check(nr, nc, n, k-1, &dp)
            }
        }

        dp[r][c][k] = val
        return val
    }
}
