// Given a m x n binary matrix mat. In one step, you can choose one cell and flip it and all the four neighbours of it if they exist (Flip is changing 1 to 0 and 0 to 1). A pair of cells are called neighboors if they share one edge.

// Return the minimum number of steps required to convert mat to a zero matrix or -1 if you cannot.

// Binary matrix is a matrix with all cells equal to 0 or 1 only.

// Zero matrix is a matrix with all cells equal to 0.

 

// Example 1:


// Input: mat = [[0,0],[0,1]]
// Output: 3
// Explanation: One possible solution is to flip (1, 0) then (0, 1) and finally (1, 1) as shown.
// Example 2:

// Input: mat = [[0]]
// Output: 0
// Explanation: Given matrix is a zero matrix. We don't need to change it.
// Example 3:

// Input: mat = [[1,1,1],[1,0,1],[0,0,0]]
// Output: 6
// Example 4:

// Input: mat = [[1,0,0],[1,0,0]]
// Output: -1
// Explanation: Given matrix can't be a zero matrix
 

// Constraints:

// m == mat.length
// n == mat[0].length
// 1 <= m <= 3
// 1 <= n <= 3
// mat[i][j] is 0 or 1.

// Solution 1: BFS / DFS
// Since m < 3, n < 3 are given as constraints, there are at most 9 cells and an int has enough bits to store their values;
// Map the m * n cells of the initial state of the matrix to the 0 ~ m * n - 1th bits of an int: start;
// For each one of the m * n bits, flip it and its neighbors, then BFS to check if 0, corresponding to an all 0s matrix, is among the resulting states; if yes, return the minimum steps needed;
// Use a Set to avoid duplicates;
// If after the traversal of all states without finding 0, return -1.
// 
// Q: Could you please further explain about the logic of transferring the matrix to int?
// sum(cell << (i * n + j) for i, row in enumerate(mat) for j, cell in enumerate(row))
// I wonder how it works and why it works.
// A: 
// For Input: mat = [[0,0],[0,1]], map it to 0b1000, that is, mapping mat[i][j] to the (i * n + j)th bit of an int. specifically,
// mat[0][0] = 0, corresponds to 0th bit, which is 0;
// mat[0][1] = 0, corresponds to 1st bit, which is 0;
// mat[1][0] = 0, corresponds to 2nd bit, which is 0;
// mat[1][1] = 1, corresponds to 3rd bit, which is 1;
// After mapping, any operations on the binary cells of the mat are equals to the operations on the corresponding bits of the mapped int. That's why it works.
// 
// Q: Why do you use "|" to initialize the matrix and use "^" to calculate the next?
// A:
// When using 0 |= b, where b = 0 or 1, the result is b; you can change it to
// start  += mat[i][j] << (i * n + j); 
// Use next ^ 1 << k (where k = i * n + j) to flip kth bit of next, which is equal to flipping the corresponding cell (i, j) in the matrix.
// 
// Time complexity: O(2^(m*n))
// Space complexity: O(2^(m*n))
class Solution {
    func minFlips(_ mat: [[Int]]) -> Int {
        let dir = [0, 0, 1, 0, -1, 0]
        let n = mat.count
        let m = mat[0].count
        
        var val = 0
        for i in 0..<n {
            for j in 0..<m {
                // convert matrix to Int
                val |= (mat[i][j] << (i*m + j))
            }
        }
        
        var queue = [val]
        var visited = Set([val])
        
        var step = 0
        while !queue.isEmpty {
            for index in 0..<queue.count {
                let cur = queue.removeLast()

                if cur == 0 {
                    return step
                }

                // check all m*n bits
                for i in 0..<n {
                    for j in 0..<m {
                        var temp = cur
                        // flip cells & its neighbors
                        for k in 0..<dir.count-1 {
                            let row = i + dir[k]
                            let col = j + dir[k+1]
                            if row >= 0, row < n, col >= 0, col < m {
                                temp ^= (1 << (row*m + col))
                            }   
                        }
                        if visited.insert(temp).0 {
                            queue.insert(temp, at: 0)
                        }
                    }
                }
            }
            step += 1
        }
        return -1
    }
}