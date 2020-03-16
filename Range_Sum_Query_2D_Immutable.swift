// Given a 2D matrix matrix, find the sum of the elements inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).

// Range Sum Query 2D
// The above rectangle (with the red border) is defined by (row1, col1) = (2, 1) and (row2, col2) = (4, 3), which contains sum = 8.

// Example:
// Given matrix = [
//   [3, 0, 1, 4, 2],
//   [5, 6, 3, 2, 1],
//   [1, 2, 0, 1, 5],
//   [4, 1, 0, 1, 7],
//   [1, 0, 3, 0, 5]
// ]

// sumRegion(2, 1, 4, 3) -> 8
// sumRegion(1, 1, 2, 2) -> 11
// sumRegion(1, 2, 2, 4) -> 12
// Note:
// You may assume that the matrix does not change.
// There are many calls to sumRegion function.
// You may assume that row1 ≤ row2 and col1 ≤ col2.

// Solution 1: build colSum matrix
// 
// Time complexity: 
// - init: O(mn)
// - sumRegion: O(m)
class NumMatrix {
    var colSum = [[Int]]()
    
    init(_ matrix: [[Int]]) {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return }
        
        let n = matrix.count
        let m = matrix[0].count
        colSum = Array(repeating: Array(repeating: 0, count: m), count: n + 1)
        for i in 0..<n {
            for j in 0..<m {
                colSum[i+1][j] = colSum[i][j] + matrix[i][j]
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        for col in col1...col2 {
            sum += colSum[row2+1][col] - colSum[row1][col]
        }
        return sum
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */

// Solution 2: directly create sum[i+1][j+1] for i,j element
// Note that the region Sum(OA)Sum(OA) is covered twice by both Sum(OB)Sum(OB) and Sum(OC)Sum(OC). We could use the principle of inclusion-exclusion to calculate Sum(ABCD)Sum(ABCD) as following:
// Sum(ABCD) = Sum(OD) - Sum(OB) - Sum(OC) + Sum(OA)Sum(ABCD)=Sum(OD)−Sum(OB)−Sum(OC)+Sum(OA)
// 
// Time complexity : O(1)O(1) time per query, O(mn)O(mn) time pre-computation. The pre-computation in the constructor takes O(mn)O(mn) time. Each sumRegion query takes O(1)O(1) time.
// Space complexity : O(mn)O(mn). The algorithm uses O(mn)O(mn) space to store the cumulative region sum.

class NumMatrix {
    var sum = [[Int]]()
    
    init(_ matrix: [[Int]]) {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return }
        
        let n = matrix.count
        let m = matrix[0].count
        sum = Array(repeating: Array(repeating: 0, count: m+1), count: n + 1)
        for i in 0..<n {
            for j in 0..<m {
                sum[i+1][j+1] = sum[i+1][j] + sum[i][j+1] - sum[i][j] + matrix[i][j]
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        return sum[row2+1][col2+1] - sum[row2+1][col1] - sum[row1][col2+1] + sum[row1][col1]
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * let ret_1: Int = obj.sumRegion(row1, col1, row2, col2)
 */