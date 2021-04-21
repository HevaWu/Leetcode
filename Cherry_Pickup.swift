/*
You are given an n x n grid representing a field of cherries, each cell is one of three possible integers.

0 means the cell is empty, so you can pass through,
1 means the cell contains a cherry that you can pick up and pass through, or
-1 means the cell contains a thorn that blocks your way.
Return the maximum number of cherries you can collect by following the rules below:

Starting at the position (0, 0) and reaching (n - 1, n - 1) by moving right or down through valid path cells (cells with value 0 or 1).
After reaching (n - 1, n - 1), returning to (0, 0) by moving left or up through valid path cells.
When passing through a path cell containing a cherry, you pick it up, and the cell becomes an empty cell 0.
If there is no valid path between (0, 0) and (n - 1, n - 1), then no cherries can be collected.


Example 1:


Input: grid = [[0,1,-1],[1,0,-1],[1,1,1]]
Output: 5
Explanation: The player started at (0, 0) and went down, down, right right to reach (2, 2).
4 cherries were picked up during this single trip, and the matrix becomes [[0,1,-1],[0,0,-1],[0,0,0]].
Then, the player went left, up, up, left to return home, picking up one more cherry.
The total number of cherries picked up is 5, and this is the maximum possible.
Example 2:

Input: grid = [[1,1,-1],[1,-1,1],[-1,1,1]]
Output: 0


Constraints:

n == grid.length
n == grid[i].length
1 <= n <= 50
grid[i][j] is -1, 0, or 1.
grid[0][0] != -1
grid[n - 1][n - 1] != -1
*/

/*
Solution 2:
DP (Bottom Up)

Say r1 + c1 = t is the t-th layer. Since our recursion only references the next layer, we only need to keep two layers in memory at a time.

At time t, let dp[c1][c2] be the most cherries that we can pick up for two people going from (0, 0) to (r1, c1) and (0, 0) to (r2, c2), where r1 = t-c1, r2 = t-c2. Our dynamic program proceeds similarly to Approach #2.
*/
class Solution {
    func cherryPickup(_ grid: [[Int]]) -> Int {
        let n = grid.count
        if n == 1 { return grid[0][0] == 1 ? 1 : 0 }

        // dp[c1][c2] be the most number of cherries obtained by
        // 2 people at (r1, c1) (r2, c2) -> r1 = t-c1, r2 = t-c2
        // r1 + c1 = r2 + c2 = t which means 2 people walk t steps
        var dp: [[Int]] = Array(
            repeating: Array(
                repeating: Int.min,
                count: n
            ),
            count: n
        )

        // fill init
        dp[0][0] = grid[0][0]

        for t in 1...(2*n-2) {
            var temp = Array(
                repeating: Array(
                    repeating: Int.min,
                    count: n
                ),
                count: n
            )

            for c1 in max(0, t-n+1)...min(n-1, t) {
                for c2 in max(0, t-n+1)...min(n-1, t) {
                    if grid[t-c1][c1] == -1 || grid[t-c2][c2] == -1 { continue }
                    var cur = grid[t-c1][c1]
                    if c1 != c2 { cur += grid[t-c2][c2] }

                    temp[c1][c2] = max(temp[c1][c2], dp[c1][c2] + cur)
                    if c1-1 >= 0 { temp[c1][c2] = max(temp[c1][c2], dp[c1-1][c2] + cur) }
                    if c2-1 >= 0 { temp[c1][c2] = max(temp[c1][c2], dp[c1][c2-1] + cur) }
                    if c1-1 >= 0, c2-1 >= 0 { temp[c1][c2] = max(temp[c1][c2], dp[c1-1][c2-1] + cur) }
                }
            }
            dp = temp
        }

        return max(0, dp[n-1][n-1])
    }
}

/*
Solution 1:
DP (Top Down)

Instead of walking from end to beginning, let's reverse the second leg of the path, so we are only considering two paths from the beginning to the end.

Notice after t steps, each position (r, c) we could be, is on the line r + c = t. So if we have two people at positions (r1, c1) and (r2, c2), then r2 = r1 + c1 - c2. That means the variables r1, c1, c2 uniquely determine 2 people who have walked the same r1 + c1 number of steps. This sets us up for dynamic programming quite nicely.

Let dp[r1][c1][c2] be the most number of cherries obtained by two people starting at (r1, c1) and (r2, c2) and walking towards (N-1, N-1) picking up cherries, where r2 = r1+c1-c2.

If grid[r1][c1] and grid[r2][c2] are not thorns, then the value of dp[r1][c1][c2] is (grid[r1][c1] + grid[r2][c2]), plus the maximum of dp[r1+1][c1][c2], dp[r1][c1+1][c2], dp[r1+1][c1][c2+1], dp[r1][c1+1][c2+1] as appropriate. We should also be careful to not double count in case (r1, c1) == (r2, c2).

Why did we say it was the maximum of dp[r+1][c1][c2] etc.? It corresponds to the 4 possibilities for person 1 and 2 moving down and right:

Person 1 down and person 2 down: dp[r1+1][c1][c2];
Person 1 right and person 2 down: dp[r1][c1+1][c2];
Person 1 down and person 2 right: dp[r1+1][c1][c2+1];
Person 1 right and person 2 right: dp[r1][c1+1][c2+1];

Time Complexity: O(n^3)
Space Complexity: O(n^3)
*/
class Solution {
    func cherryPickup(_ grid: [[Int]]) -> Int {
        let n = grid.count
        if n == 1 { return grid[0][0] == 1 ? 1 : 0 }

        // dp[r1][c1][c2] be the most number of cherries obtained by
        // 2 people at (r1, c1) (r2, c2) -> r2 = r1+c1-c2
        // r1 + c1 = r2 + c2 = t which means 2 people walk t steps
        var dp: [[[Int?]]] = Array(
            repeating: Array(
                repeating: Array(
                    repeating: nil,
                    count: n
                ),
                count: n
            ),
            count: n
        )

        return max(0, check(0, 0, 0, n, grid, &dp))
    }

    func check(_ r1: Int, _ c1: Int, _ c2: Int, _ n: Int,
               _ grid: [[Int]], _ dp: inout [[[Int?]]]) -> Int {
        let r2 = r1+c1-c2
        // invalid case
        if r1 == n || c1 == n || r2 == n || c2 == n
        || grid[r1][c1] == -1 || grid[r2][c2] == -1 {
            return Int.min
        }

        if r1 == n-1, c1 == n-1 { return grid[r1][c1] }
        if let val = dp[r1][c1][c2] { return val }

        var res = grid[r1][c1]
        // avoid 2 person pick same cherry
        if c1 != c2 { res += grid[r2][c2] }

        res += max(
            max(
                check(r1, c1+1, c2+1, n, grid, &dp),
                check(r1, c1+1, c2, n, grid, &dp)
            ),
            max(
                check(r1+1, c1, c2+1, n, grid, &dp),
                check(r1+1, c1, c2, n, grid, &dp)
            )
        )

        dp[r1][c1][c2] = res
        return res
    }
}