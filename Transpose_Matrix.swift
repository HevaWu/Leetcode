/*
Given a 2D integer array matrix, return the transpose of matrix.

The transpose of a matrix is the matrix flipped over its main diagonal, switching the matrix's row and column indices.





Example 1:

Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [[1,4,7],[2,5,8],[3,6,9]]
Example 2:

Input: matrix = [[1,2,3],[4,5,6]]
Output: [[1,4],[2,5],[3,6]]


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 1000
1 <= m * n <= 105
-109 <= matrix[i][j] <= 109
*/

/*
Solution 1:
iterate m,n

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        let m = matrix.count
        let n = matrix[0].count

        var transpose = Array(
            repeating: Array(repeating: 0, count: m),
            count: n
        )
        for i in 0..<n {
            for j in 0..<m {
                transpose[i][j] = matrix[j][i]
            }
        }
        return transpose
    }
}