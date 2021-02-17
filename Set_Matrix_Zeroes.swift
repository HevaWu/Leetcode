/*
Given an m x n matrix. If an element is 0, set its entire row and column to 0. Do it in-place.

Follow up:

A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?
 

Example 1:


Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
Output: [[1,0,1],[0,0,0],[1,0,1]]
Example 2:


Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
 

Constraints:

m == matrix.length
n == matrix[0].length
1 <= m, n <= 200
-231 <= matrix[i][j] <= 231 - 1
*/

/*
Solution 1

if cell[i][j] == 0 {
    cell[i][0] = 0
    cell[0][j] = 0
}

then iterate to update i row, j col

use isFirstCol to help checking if first col also need to be updated

Time Complexity: O(mn)
Space Complexity: O(1)
*/

class Solution {
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        var isFirstCol = false
        
        for i in 0..<m {
            if matrix[i][0] == 0 {
                isFirstCol = true
            }
            for j in 1..<n {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        // check 1..<m, 1..<n cell
        for i in 1..<m {
            for j in 1..<n {
                // use ||
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        
        if matrix[0][0] == 0 {
            for j in 0..<n {
                matrix[0][j] = 0
            }
        }
        
        if isFirstCol {
            for i in 0..<m {
                matrix[i][0] = 0
            }
        }
    }
}