/*
Given an m x n binary matrix mat, return the number of submatrices that have all ones.



Example 1:


Input: mat = [[1,0,1],[1,1,0],[1,1,0]]
Output: 13
Explanation:
There are 6 rectangles of side 1x1.
There are 2 rectangles of side 1x2.
There are 3 rectangles of side 2x1.
There is 1 rectangle of side 2x2.
There is 1 rectangle of side 3x1.
Total number of rectangles = 6 + 2 + 3 + 1 + 1 = 13.
Example 2:


Input: mat = [[0,1,1,0],[0,1,1,1],[1,1,1,0]]
Output: 24
Explanation:
There are 8 rectangles of side 1x1.
There are 5 rectangles of side 1x2.
There are 2 rectangles of side 1x3.
There are 4 rectangles of side 2x1.
There are 2 rectangles of side 2x2.
There are 2 rectangles of side 3x1.
There is 1 rectangle of side 3x2.
Total number of rectangles = 8 + 5 + 2 + 4 + 2 + 2 + 1 = 24.


Constraints:

1 <= m, n <= 150
mat[i][j] is either 0 or 1.

*/

/*
Solution 2:
build row matrix to record row's consecutive 1
- row[i][j] means ith row's consecutive 1 with end of col j

for each row,
count += row[i][j]
means find 1x{consecutive col} rectangle

for check previous row which could help build rectangle
(wth i,j is right bottom corner)
i2 is in 0..<i
pick min(row[i][j], row[i2][j]) will be all possible rectangle

Time Complexity: O(m*n*m)
Space Complexity: O(mn)
*/
class Solution {
    func numSubmat(_ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count

        var mat = mat
        var count = 0

        for i in 0..<m {
            for j in 0..<n {
                guard mat[i][j] == 1 else { continue }
                // current row's consecutive 1 with end of j col
                var val = (j > 0 ? mat[i][j-1] : 0) + 1
                mat[i][j] = val
                // get current row's consecutive rectangle
                count += val

                // find previous row's rectangle
                // with right bottom is i,j
                var i2 = i-1
                // use val > 0 check, not directly use mat[i2][j] > 0 check, because it will mis-count some value
                while i2 >= 0, val > 0 {
                    // update val at here
                    val = min(val, mat[i2][j])
                    count += val
                    i2 -= 1
                }
            }
        }

        return count
    }
}

/*
Solution 1:
use sum matrix
then check area is equal to sum of submatrix and update the count

Time Complexity: O(m^2 * n^2)
Space Complexity: O(mn)
*/
class Solution {
    func numSubmat(_ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count

        // sum[i][j] is sum of mat[0..<i][0..<j]
        var sum = Array(
            repeating: Array(repeating: 0, count: n+1),
            count: m+1
        )
        for i in 0..<m {
            for j in 0..<n {
                sum[i+1][j+1] = mat[i][j]
                + sum[i+1][j]
                + sum[i][j+1]
                - sum[i][j]
            }
        }

        var count = 0
        for i1 in 0..<m {
            for j1 in 0..<n {
                guard mat[i1][j1] == 1 else { continue }
                for i2 in i1..<m {
                    for j2 in j1..<n {
                        guard mat[i2][j2] == 1 else { continue }
                        let area = sum[i2+1][j2+1]
                        - sum[i1][j2+1]
                        - sum[i2+1][j1]
                        + sum[i1][j1]
                        if area == (i2-i1+1) * (j2-j1+1) {
                            count += 1
                        }
                    }
                }
            }
        }


        return count
    }
}