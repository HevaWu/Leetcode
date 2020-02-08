// You are given an n x n 2D matrix representing an image.
// Rotate the image by 90 degrees (clockwise).

// Note:

// You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

// Example 1:

// Given input matrix = 
// [
//   [1,2,3],
//   [4,5,6],
//   [7,8,9]
// ],

// rotate the input matrix in-place such that it becomes:
// [
//   [7,4,1],
//   [8,5,2],
//   [9,6,3]
// ]
// Example 2:

// Given input matrix =
// [
//   [ 5, 1, 9,11],
//   [ 2, 4, 8,10],
//   [13, 3, 6, 7],
//   [15,14,12,16]
// ], 

// rotate the input matrix in-place such that it becomes:
// [
//   [15,13, 2, 5],
//   [14, 3, 4, 1],
//   [12, 6, 8, 9],
//   [16, 7,10,11]
// ]

// Solution 1: Transpose and Reverse
// 1. transpose 对称调换, extrange [i][j] to [j][i]
// 2. reverse each row
//
// Time complexity: O(n^2)
// Space complexity: O(1)
class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        guard !matrix.isEmpty else { return }
        
        let n = matrix.count
        for i in 0..<n {
            for j in i..<n {
                var temp = matrix[i][j]
                matrix[i][j] = matrix[j][i]
                matrix[j][i] = temp
            }
        }
        
        // reverse in each row
        for i in 0..<n {
            matrix[i].reverse()
        }
    }
}

// Solution 2: Rotate 4 rectangle
// Now the solution is quite straightforward - one could move across the elements in the first rectangle and rotate them using a temp list of 4 elements.
// for [[1,2,3],[4,5,6],[7,8,9]]
// the one we need to process is [1,4]
// for 1, temp = [1,3,9,7], rotate it
// for 4, temp = [2,6,8,4], rotate it
//
// Time complexity : O(n^2) is a complexity given by two inserted loops.
// Space complexity : O(1) since we do a rotation in place and allocate only the list of 4 elements as a temporary helper.
class Solution {
    func rotate(_ matrix: inout [[Int]]) {
        guard !matrix.isEmpty else { return }
        
        let n = matrix.count
        for i in 0..<n/2 {
            for j in 0..<(n/2 + n%2) {
                // rotate 4 rectangle
                let temp = matrix[i][j]
                matrix[i][j] = matrix[n-j-1][i]
                matrix[n-j-1][i] = matrix[n-i-1][n-j-1]
                matrix[n-i-1][n-j-1] = matrix[j][n-i-1]
                matrix[j][n-i-1] = temp
            }
        }
    }
}