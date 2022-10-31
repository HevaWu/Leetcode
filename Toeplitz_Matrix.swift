/*
Given an m x n matrix, return true if the matrix is Toeplitz. Otherwise, return false.

A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.



Example 1:


Input: matrix = [[1,2,3,4],[5,1,2,3],[9,5,1,2]]
Output: true
Explanation:
In the above grid, the diagonals are:
"[9]", "[5, 5]", "[1, 1, 1]", "[2, 2, 2]", "[3, 3]", "[4]".
In each diagonal all elements are the same, so the answer is True.
Example 2:


Input: matrix = [[1,2],[2,2]]
Output: false
Explanation:
The diagonal "[1, 2]" has different elements.


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 20
0 <= matrix[i][j] <= 99


Follow up:

What if the matrix is stored on disk, and the memory is limited such that you can only load at most one row of the matrix into the memory at once?
What if the matrix is so large that you can only load up a partial row into the memory at once?

*/

/*
Solution 2:
iterate by row
for matrix[i][j]
- if j>=i, compare it with matrix[0][j-i]
- if i>j, compare it with matrix[i-j][0]

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
        let m = matrix.count
        let n = matrix[0].count

        for i in 0..<m {
            for j in 0..<n {
                if (j >= i && matrix[i][j] != matrix[0][j-i])
                || (i > j && matrix[i][j] != matrix[i-j][0]) {
                    return false
                }
            }
        }
        return true
    }
}

/*
Solution 1:
iterate matrix by frist column, first row
try to check if element in diagonal start from this cell is equal to each other or not

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func isToeplitzMatrix(_ matrix: [[Int]]) -> Bool {
        let m = matrix.count
        let n = matrix[0].count

        if m == 1 || n == 1 { return true }

        for i in stride(from: m-2, through: 0, by: -1) {
            let val = matrix[i][0]

            // i+len<m
            // len < n
            for len in 1..<min(n, m-i) {
                if matrix[i+len][len] != val { return false }
            }
        }

        for j in 1..<n {
            let val = matrix[0][j]

            // len < m
            // j+len < n
            for len in 1..<min(m, n-j) {
                if matrix[len][j+len] != val { return false }
            }
        }

        return true
    }
}
