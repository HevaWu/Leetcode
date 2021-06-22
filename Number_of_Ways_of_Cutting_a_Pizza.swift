/*
Given a rectangular pizza represented as a rows x cols matrix containing the following characters: 'A' (an apple) and '.' (empty cell) and given the integer k. You have to cut the pizza into k pieces using k-1 cuts.

For each cut you choose the direction: vertical or horizontal, then you choose a cut position at the cell boundary and cut the pizza into two pieces. If you cut the pizza vertically, give the left part of the pizza to a person. If you cut the pizza horizontally, give the upper part of the pizza to a person. Give the last piece of pizza to the last person.

Return the number of ways of cutting the pizza such that each piece contains at least one apple. Since the answer can be a huge number, return this modulo 10^9 + 7.



Example 1:



Input: pizza = ["A..","AAA","..."], k = 3
Output: 3
Explanation: The figure above shows the three ways to cut the pizza. Note that pieces must contain at least one apple.
Example 2:

Input: pizza = ["A..","AA.","..."], k = 3
Output: 1
Example 3:

Input: pizza = ["A..","A..","..."], k = 1
Output: 1


Constraints:

1 <= rows, cols <= 50
rows == pizza.length
cols == pizza[i].length
1 <= k <= 10
pizza consists of characters 'A' and '.' only.
*/

/*
Solution 1:
preSum + dp

- build preSum for recording sum of pizza in [0..<i][0..<j]
- dp[i][j][k] for number of ways cut using k cuts that current piece of pizza has upper left at [i][j] and lower right at [m-1][n-1]
recursively check it

Time Complexity: O(mnk)
Space Complexity: O(mnk)
*/
class Solution {
    let mod = Int(1e9 + 7)

    func ways(_ pizza: [String], _ k: Int) -> Int {
        let m = pizza.count
        let n = pizza[0].count

        // preSum[i][j] sum of pizza in [0..<i][0..<j]
        var preSum = Array(
            repeating: Array(repeating: 0, count: n+1),
            count: m+1
        )

        for i in 0..<m {
            var cols = Array(pizza[i])
            for j in 0..<n {
                preSum[i+1][j+1] = (cols[j] == "A" ? 1 : 0) + preSum[i+1][j] + preSum[i][j+1] - preSum[i][j]
            }
        }

        // print(preSum)

        // dp[i][j][k], number of ways cut using k cuts that current piece of pizza has upper left at [i][j] and lower right at [m-1][n-1]
        var dp: [[[Int?]]] = Array(
            repeating: Array(
                repeating: Array(repeating: nil, count: k),
                count: n
            ),
            count: m
        )
        return check(0, 0, k-1, m, n, preSum, &dp)
    }

    func check(_ i: Int, _ j: Int, _ k: Int,
               _ m: Int, _ n: Int, _ preSum: [[Int]],
               _ dp: inout [[[Int?]]]) -> Int {
        // print(i, j, k, m, n)
        guard i < m, j < n, k >= 0 else { return 0 }
        if k == 0 { return 1 }

        if let val = dp[i][j][k] { return val }
        if i == m-1, n == n-1 {
            // still have remain k cuts, not a proper way
            return 0
        }

        var val = 0

        if i+1 < m {
            // cut horizontally
            for r in (i+1)..<m {
                // i,j to r-1, n-1
                let ijrn = preSum[r][n] - preSum[r][j] - preSum[i][n] + preSum[i][j]
                // r,j to m-1,n-1
                let rjmn = preSum[m][n] - preSum[m][j] - preSum[r][n] + preSum[r][j]
                // print("row first", val, ijrn, rjmn, i, j, r, n)
                if ijrn >= 1, rjmn >= 1{
                    // can try to cut at r-th row
                    val = (val + check(r, j, k-1, m, n, preSum, &dp)) % mod
                    // print("row", val, ijrn, rjmn, i, j, r, n)
                }
            }
        }

        if j+1 < n {
            // cut vertically
            for c in (j+1)..<n {
                // i,j to m-1, c-1
                let ijmc = preSum[m][c] - preSum[i][c] - preSum[m][j] + preSum[i][j]
                // i,c to m-1, n-1
                let icmn = preSum[m][n] - preSum[i][n] - preSum[m][c] + preSum[i][c]
                // print("col first", val, ijmc, icmn, i, j, m, c)
                if ijmc >= 1, icmn >= 1{
                    // can try to cut at r-th row
                    val = (val + check(i, c, k-1, m, n, preSum, &dp)) % mod
                }
            }
        }

        dp[i][j][k] = val
        return val
    }
}