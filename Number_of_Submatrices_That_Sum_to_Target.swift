// Given a matrix, and a target, return the number of non-empty submatrices that sum to target.

// A submatrix x1, y1, x2, y2 is the set of all cells matrix[x][y] with x1 <= x <= x2 and y1 <= y <= y2.

// Two submatrices (x1, y1, x2, y2) and (x1', y1', x2', y2') are different if they have some coordinate that is different: for example, if x1 != x1'.

 

// Example 1:

// Input: matrix = [[0,1,0],[1,1,1],[0,1,0]], target = 0
// Output: 4
// Explanation: The four 1x1 submatrices that only contain 0.
// Example 2:

// Input: matrix = [[1,-1],[-1,1]], target = 0
// Output: 5
// Explanation: The two 1x2 submatrices, plus the two 2x1 submatrices, plus the 2x2 submatrix.
 

// Note:

// 1 <= matrix.length <= 300
// 1 <= matrix[0].length <= 300
// -1000 <= matrix[i] <= 1000
// -10^8 <= target <= 10^8

// Solution 1: 
// For each row, calculate the prefix sum.
// For each pair of columns,
// calculate the accumulated sum of rows.
// Now this problem is same to, "Find the Subarray with Target Sum".
// 
// Time O(N^3)
// Space O(N)
class Solution {
    func numSubmatrixSumTarget(_ matrix: [[Int]], _ target: Int) -> Int {
        let n = matrix.count
        let m = matrix[0].count
        
        var matrix = matrix
        for i in 0..<n {
            for j in 1..<m {
                matrix[i][j] = matrix[i][j-1] + matrix[i][j]
            }
        }
        
        var count = 0
        for y1 in 0..<m {
            for y2 in y1..<m {
                var map: [Int: Int] = [0: 1]
                var temp = 0
                for x in 0..<n {
                    temp += matrix[x][y2] - (y1>0 ? matrix[x][y1-1] : 0)
                    count += map[temp - target, default: 0]
                    map[temp, default: 0] += 1
                }
            }
        }
        return count
    }
}