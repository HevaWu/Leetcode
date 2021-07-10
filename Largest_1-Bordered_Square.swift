/*
Given a 2D grid of 0s and 1s, return the number of elements in the largest square subgrid that has all 1s on its border, or 0 if such a subgrid doesn't exist in the grid.



Example 1:

Input: grid = [[1,1,1],[1,0,1],[1,1,1]]
Output: 9
Example 2:

Input: grid = [[1,1,0,0]]
Output: 1


Constraints:

1 <= grid.length <= 100
1 <= grid[0].length <= 100
grid[i][j] is 0 or 1
*/

/*
Solution 1:
build sumRow, sumCol

Time Complexity: O(mn + min(m,n)^3)
Space Complexity: O(mn)
*/
class Solution {
    func largest1BorderedSquare(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count

        // sumRow[i][j] sum of grid[i][0...j]
        var sumRow = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )
        // sumRow[i][j] sum of grid[0...i][j]
        var sumCol = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )

        for i in 0..<m {
            for j in 0..<n {
                sumRow[i][j] = (j > 0 ? sumRow[i][j-1] : 0) + grid[i][j]
                sumCol[i][j] = (i > 0 ? sumCol[i-1][j] : 0) + grid[i][j]
            }
        }

        for len in stride(from: min(m, n), through: 1, by: -1) {
            if canFind(len, m, n, sumRow, sumCol) {
                return len * len
            }
        }
        return 0
    }

    func canFind(_ len: Int,
                 _ m: Int, _ n: Int,
                 _ sumRow: [[Int]], _ sumCol: [[Int]]) -> Bool {
        for i1 in 0...(m-len) {
            for j1 in 0...(n-len) {
                let i2 = i1+len-1
                let j2 = j1+len-1

                if sumRow[i1][j2] - (j1 > 0 ? sumRow[i1][j1-1] : 0) == len,
                sumRow[i2][j2] - (j1 > 0 ? sumRow[i2][j1-1] : 0) == len,
                sumCol[i2][j1] - (i1 > 0 ? sumCol[i1-1][j1] : 0) == len,
                sumCol[i2][j2] - (i1 > 0 ? sumCol[i1-1][j2] : 0) == len {
                    return true
                }
            }
        }
        return false
    }
}