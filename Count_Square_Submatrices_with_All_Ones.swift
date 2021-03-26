/*
Given a m * n matrix of ones and zeros, return how many square submatrices have all ones.



Example 1:

Input: matrix =
[
  [0,1,1,1],
  [1,1,1,1],
  [0,1,1,1]
]
Output: 15
Explanation:
There are 10 squares of side 1.
There are 4 squares of side 2.
There is  1 square of side 3.
Total number of squares = 10 + 4 + 1 = 15.
Example 2:

Input: matrix =
[
  [1,0,1],
  [1,1,0],
  [1,1,0]
]
Output: 7
Explanation:
There are 6 squares of side 1.
There is 1 square of side 2.
Total number of squares = 6 + 1 = 7.

Constraints:

1 <= arr.length <= 300
1 <= arr[0].length <= 300
0 <= arr[i][j] <= 1
*/

/*
Solution 2:
build dp matrix for recording largest square len
then sum up the dp

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func countSquares(_ matrix: [[Int]]) -> Int {
        let m = matrix.count
        let n = matrix[0].count

        var count = 0
        // dp[i][j], len of largest square until this cell
        var dp = matrix

        for i in 0..<m {
            for j in 0..<n where matrix[i][j] == 1 {
                if i > 0, j > 0, matrix[i-1][j-1] == 1 {
                    dp[i][j] = min(dp[i-1][j-1], min(dp[i-1][j], dp[i][j-1])) + 1
                    count += dp[i][j]
                } else {
                    count += 1
                }
            }
        }

        return count
    }
}

/*
Solution 1:
build sum dictionary

Time Complexity: O(mn*min(m,n))
Space Complexity: O(mn)
*/
class Solution {
    func countSquares(_ matrix: [[Int]]) -> Int {
        let m = matrix.count
        let n = matrix[0].count

        var count = 0
        var sum = Array(repeating: Array(repeating: 0, count: n+1),
                        count: m+1)

        for i in 1...m {
            for j in 1...n {
                sum[i][j] = matrix[i-1][j-1]
                + sum[i-1][j] + sum[i][j-1]
                - sum[i-1][j-1]
            }
        }

        for i in 0..<m {
            for j in 0..<n where matrix[i][j] == 1 {
                count += 1
                for k in 1..<min(m-i, n-j) {
                    if sum[i+k+1][j+k+1] - sum[i+k+1][j] - sum[i][j+k+1] + sum[i][j] == (k+1)*(k+1) {
                        count += 1
                    }
                    // print(i, j, k, sum[i+k+1][j+k+1] - sum[i+1][j+1], (k+1)*(k+1))
                }
            }
        }

        return count
    }
}