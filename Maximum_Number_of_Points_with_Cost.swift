/*
You are given an m x n integer matrix points (0-indexed). Starting with 0 points, you want to maximize the number of points you can get from the matrix.

To gain points, you must pick one cell in each row. Picking the cell at coordinates (r, c) will add points[r][c] to your score.

However, you will lose points if you pick a cell too far from the cell that you picked in the previous row. For every two adjacent rows r and r + 1 (where 0 <= r < m - 1), picking cells at coordinates (r, c1) and (r + 1, c2) will subtract abs(c1 - c2) from your score.

Return the maximum number of points you can achieve.

abs(x) is defined as:

x for x >= 0.
-x for x < 0.


Example 1:


Input: points = [[1,2,3],[1,5,1],[3,1,1]]
Output: 9
Explanation:
The blue cells denote the optimal cells to pick, which have coordinates (0, 2), (1, 1), and (2, 0).
You add 3 + 5 + 3 = 11 to your score.
However, you must subtract abs(2 - 1) + abs(1 - 0) = 2 from your score.
Your final score is 11 - 2 = 9.
Example 2:


Input: points = [[1,5],[2,3],[4,2]]
Output: 11
Explanation:
The blue cells denote the optimal cells to pick, which have coordinates (0, 1), (1, 1), and (2, 0).
You add 5 + 3 + 4 = 12 to your score.
However, you must subtract abs(1 - 1) + abs(1 - 0) = 1 from your score.
Your final score is 12 - 1 = 11.


Constraints:

m == points.length
n == points[r].length
1 <= m, n <= 105
1 <= m * n <= 105
0 <= points[r][c] <= 105

*/

/*
Solution 3:

To further reduce the time complexity, I found that there is some similar calculation when we are trying to find the max. That is dp[i - 1][k] - k (or + k depends on the position). To reduce to the smaller problem, we assume that all the max value is from the left side of the current position. With this assumption, the abs(k - j) can be changed to j - k. Due to other values (e.g. points[i][j]) are fixed. The problem becomes to find the max dp[i - 1][k] + k in the left. That is

dp[i][j] = max(dp[i - 1][k] + k) + points[i][j] - j for all 0 <= k <= j
You may notice that some of the sign is reversed, that is because of we need to subtract the cost.

Now, the right side is similar. If we assume max value is from the right side. The relation will be:

dp[i][j] = max(dp[i - 1][k] - k) + points[i][j] + j for all j <= k <= points[i].size() - 1
The actual answer will be either from the left side or right side.

Time Complexity: O(m*n)
Space Complexity: O(n)
*/
class Solution {
    func maxPoints(_ points: [[Int]]) -> Int {
        let m = points.count
        let n = points[0].count

        var cur = points[0]
        if m > 1 {
            for r in 1..<m {
                var left = Array(repeating: 0, count: n)
                left[0] = cur[0]
                for c2 in 1..<n {
                    left[c2] = max(left[c2-1], cur[c2] + c2)
                }

                var right = Array(repeating: 0, count: n)
                right[n-1] = cur[n-1] - (n-1)
                for c2 in stride(from: n-2, through: 0, by: -1) {
                    right[c2] = max(right[c2+1], cur[c2] - c2)
                }

                for c1 in 0..<n {
                    cur[c1] = points[r][c1] + max(left[c1] - c1, right[c1] + c1)
                }
            }
        }

        return cur.max()!
    }
}

/*
Solution 2:
TLE

Time Complexity: O(m*n*n)
Space Complexity: O(n)
*/
class Solution {
    func maxPoints(_ points: [[Int]]) -> Int {
        let m = points.count
        let n = points[0].count

        var cur = points[0]
        if m > 1 {
            for r in 1..<m {
                var temp = cur
                for c2 in 0..<n {
                    var val = -n
                    for c1 in 0..<n {
                        val = max(val, cur[c1] - abs(c1 - c2))
                    }
                    temp[c2] = points[r][c2] + val
                }
                cur = temp
            }
        }

        return cur.max()!
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func maxPoints(_ points: [[Int]]) -> Int {
        let m = points.count
        let n = points[0].count

        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )
        dp[0] = points[0]

        if m > 1 {
            for r in 1..<m {
                for c2 in 0..<n {
                    var val = -n
                    for c1 in 0..<n {
                        val = max(val, dp[r-1][c1] - abs(c1 - c2))
                    }
                    dp[r][c2] = points[r][c2] + val
                }
            }
        }

        return dp[m-1].max()!
    }
}