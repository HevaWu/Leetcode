/*
Given an m x n matrix, return all elements of the matrix in spiral order.

 

Example 1:


Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,3,6,9,8,7,4,5]
Example 2:


Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
Output: [1,2,3,4,8,12,11,10,9,5,6,7]
 

Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 10
-100 <= matrix[i][j] <= 100

Hint 1
Well for some problems, the best way really is to come up with some algorithms for simulation. Basically, you need to simulate what the problem asks us to do.

Hint 2
We go boundary by boundary and move inwards. That is the essential operation. First row, last column, last row, first column and then we move inwards by 1 and then repeat. That's all, that is all the simulation that we need.

Hint 3
Think about when you want to switch the progress on one of the indexes. If you progress on
i
out of
[i, j]
, you'd be shifting in the same column. Similarly, by changing values for
j
, you'd be shifting in the same row. Also, keep track of the end of a boundary so that you can move inwards and then keep repeating. It's always best to run the simulation on edge cases like a single column or a single row to see if anything breaks or not.
*/

/*
Solution 1
check layer by layer

1. [r1, c1] ... [r1, c2]
2. [r1+1, c2] ... [r2, c2]
3. [r2, c2-1] ... [r2, c1]
4. [r2-1, c1] ... [r1+1, c1]

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return [] }
        let m = matrix.count
        let n = matrix[0].count
        
        var r1 = 0
        var r2 = m-1
        var c1 = 0
        var c2 = n-1
        
        var res = [Int]()
        while r1 <= r2, c1 <= c2 {
            res.append(contentsOf: Array(matrix[r1][c1...c2]))
            
            if r1 < r2 {
                for r in (r1+1)...r2 {
                    res.append(matrix[r][c2])
                }
            } 
            
            if r1 < r2, c1 < c2 {
                for c in stride(from: c2-1, through: c1, by: -1) {
                    res.append(matrix[r2][c])
                }

                for r in stride(from: r2-1, to: r1, by: -1) {
                    res.append(matrix[r][c1])
                }
            }
            
            r1 += 1
            r2 -= 1
            c1 += 1
            c2 -= 1
        }
        
        return res
    }
}