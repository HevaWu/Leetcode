/*
Given a rows x cols matrix mat, where mat[i][j] is either 0 or 1, return the number of special positions in mat.

A position (i,j) is called special if mat[i][j] == 1 and all other elements in row i and column j are 0 (rows and columns are 0-indexed).



Example 1:

Input: mat = [[1,0,0],
              [0,0,1],
              [1,0,0]]
Output: 1
Explanation: (1,2) is a special position because mat[1][2] == 1 and all other elements in row 1 and column 2 are 0.
Example 2:

Input: mat = [[1,0,0],
              [0,1,0],
              [0,0,1]]
Output: 3
Explanation: (0,0), (1,1) and (2,2) are special positions.
Example 3:

Input: mat = [[0,0,0,1],
              [1,0,0,0],
              [0,1,1,0],
              [0,0,0,0]]
Output: 2
Example 4:

Input: mat = [[0,0,0,0,0],
              [1,0,0,0,0],
              [0,1,0,0,0],
              [0,0,1,0,0],
              [0,0,0,1,1]]
Output: 3


Constraints:

rows == mat.length
cols == mat[i].length
1 <= rows, cols <= 100
mat[i][j] is 0 or 1.
*/

/*
Solution 1:

row sum, row[i], sum of ith row
col sum, col[j], sum of jth col

Time Complexity: O(mn)
Space Complexity: O(m + n)
*/
class Solution {
    func numSpecial(_ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count

        var row = Array(repeating: 0, count: m)
        var col = Array(repeating: 0, count: n)

        for i in 0..<m {
            for j in 0..<n {
                row[i] += mat[i][j]
                col[j] += mat[i][j]
            }
        }

        var special = 0
        for i in 0..<m {
            for j in 0..<n {
                if mat[i][j] == 1, row[i] == 1, col[j] == 1 {
                    special += 1
                }
            }
        }
        return special
    }
}