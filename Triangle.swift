/*
Given a triangle array, return the minimum path sum from top to bottom.

For each step, you may move to an adjacent number of the row below. More formally, if you are on index i on the current row, you may move to either index i or index i + 1 on the next row.



Example 1:

Input: triangle = [[2],[3,4],[6,5,7],[4,1,8,3]]
Output: 11
Explanation: The triangle looks like:
   2
  3 4
 6 5 7
4 1 8 3
The minimum path sum from top to bottom is 2 + 3 + 5 + 1 = 11 (underlined above).
Example 2:

Input: triangle = [[-10]]
Output: -10


Constraints:

1 <= triangle.length <= 200
triangle[0].length == 1
triangle[i].length == triangle[i - 1].length + 1
-104 <= triangle[i][j] <= 104


Follow up: Could you do this using only O(n) extra space, where n is the total number of rows in the triangle?
*/

/*
Solution 3:
DP - Bottom Up

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution3 {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        if n == 1 { return triangle[0][0] }
        var dp = triangle[n-1]
        for i in stride(from: n-2, through: 0, by: -1) {
            var temp = Array(repeating: 10001, count: n)
            for j in 0...i {
                let minJ = min(dp[j], dp[j+1]) + triangle[i][j]
                temp[j] = min(temp[j], minJ)
            }
            dp = temp
        }
        return dp[0]
    }
}

/*
Solution 2:
DP - Top Down

dp[i] means minimum sum final fall at col i
update dp n times for each row

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution2 {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        if n == 1 { return triangle[0][0] }

        // dp[i]
        // minimum sum final fall at col i
        var dp = Array(repeating: 10001, count: n)
        dp[0] = triangle[0][0]

        for i in 1..<n {
            var temp = Array(repeating: 10001, count: n)
            for j in 0...i {
                temp[j] = min(temp[j], dp[j] + triangle[i][j])
                if j > 0 {
                    temp[j] = min(temp[j], dp[j-1] + triangle[i][j])
                }
            }
            dp = temp
        }

        var minSum = dp[0]
        for i in 1..<n {
            minSum = min(minSum, dp[i])
        }
        return minSum
    }
}

/*
Solution 1:
Time Limit Exceeded

Brute force
dfs

Time Complexity: O(2^n)
Space Complexity: O(1)
*/
class Solution1 {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let n = triangle.count
        if n == 1 { return triangle[0][0] }

        var minSum = Int.max
        dfs(0, 0, n, triangle, triangle[0][0], &minSum)
        return minSum
    }

    func dfs(_ i: Int, _ j: Int, _ n: Int, _ triangle: [[Int]],
             _ curSum: Int, _ minSum: inout Int) {
        if i == n-1 {
            minSum = min(minSum, curSum)
            return
        }

        if i < n-1 {
            dfs(i+1, j, n, triangle, curSum+triangle[i+1][j], &minSum)
            if j <= i {
                dfs(i+1, j+1, n, triangle, curSum+triangle[i+1][j+1], &minSum)
            }
        }
    }
}