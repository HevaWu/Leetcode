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
// update(3, 2, 2)
// sumRegion(2, 1, 4, 3) -> 10
// Note:
// The matrix is only modifiable by the update function.
// You may assume the number of calls to update and sumRegion function is distributed evenly.
// You may assume that row1 ≤ row2 and col1 ≤ col2.

// Solution 1:
// add one more matrix for helping counting the columns sum
// 
// Time complexity: 
// update: O(n)
// sumRegion: O(m)
// 
// Space complexity: O((n+1)*m)
class NumMatrix {
    var sumCol = [[Int]]()
    var matrix = [[Int]]()

    init(_ matrix: [[Int]]) {
        // init checking
        guard !matrix.isEmpty else { return }
        
        self.matrix = matrix
        let n = matrix.count
        let m = matrix[0].count
        sumCol = Array(repeating: Array(repeating: 0, count: m), count: n+1)
        for i in 1...n {
            for j in 0..<m {
                sumCol[i][j] = sumCol[i-1][j] + matrix[i-1][j]
            }
        }
    }
    
    func update(_ row: Int, _ col: Int, _ val: Int) {
        // start from row+1
        for i in (row+1)..<sumCol.count {
            sumCol[i][col] += val - matrix[row][col]
        }
        matrix[row][col] = val
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        // (row2+1,i) - (row1,i)
        for i in col1...col2 {
            sum += sumCol[row2+1][i] - sumCol[row1][i]
        }
        return sum
    }
}

/**
 * Your NumMatrix object will be instantiated and called as such:
 * let obj = NumMatrix(matrix)
 * obj.update(row, col, val)
 * let ret_2: Int = obj.sumRegion(row1, col1, row2, col2)
 */