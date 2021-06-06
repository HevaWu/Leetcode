/*
Given two n x n binary matrices mat and target, return true if it is possible to make mat equal to target by rotating mat in 90-degree increments, or false otherwise.



Example 1:


Input: mat = [[0,1],[1,0]], target = [[1,0],[0,1]]
Output: true
Explanation: We can rotate mat 90 degrees clockwise to make mat equal target.
Example 2:


Input: mat = [[0,1],[1,1]], target = [[1,0],[0,1]]
Output: false
Explanation: It is impossible to make mat equal to target by rotating mat.
Example 3:


Input: mat = [[0,0,0],[0,1,0],[1,1,1]], target = [[1,1,1],[0,1,0],[0,0,0]]
Output: true
Explanation: We can rotate mat 90 degrees clockwise two times to make mat equal target.


Constraints:

n == mat.length == target.length
n == mat[i].length == target[i].length
1 <= n <= 10
mat[i][j] and target[i][j] are either 0 or 1.
*/

class Solution {
    func findRotation(_ mat: [[Int]], _ target: [[Int]]) -> Bool {
        let n = mat.count
        var mat = mat
        for i in 0..<4 {
            if equal(mat, target) {
                return true
            }
            rotate(&mat)
        }
        return false
    }

    func rotate(_ matrix: inout [[Int]]) {
        let n = matrix.count
        for i in 0..<n/2 {
            // set n/2+n%2 for the odd n, ex: 3*3 matrix, check 0,0 to 1,0
            for j in 0..<(n/2 + n%2) {
                // rotate 4 rectangle
                let temp = matrix[i][j]
                // check the corresponding index
                matrix[i][j] = matrix[n-j-1][i]
                matrix[n-j-1][i] = matrix[n-i-1][n-j-1]
                matrix[n-i-1][n-j-1] = matrix[j][n-i-1]
                matrix[j][n-i-1] = temp
            }
        }
    }

    func equal(_ mat: [[Int]], _ target: [[Int]]) -> Bool {
        let n = mat.count
        for i in 0..<n {
            for j in 0..<n {
                if mat[i][j] != target[i][j] {
                    return false
                }
            }
        }
        return true
    }
}