/*
A matrix diagonal is a diagonal line of cells starting from some cell in either the topmost row or leftmost column and going in the bottom-right direction until reaching the matrix's end. For example, the matrix diagonal starting from mat[2][0], where mat is a 6 x 3 matrix, includes cells mat[2][0], mat[3][1], and mat[4][2].

Given an m x n matrix mat of integers, sort each matrix diagonal in ascending order and return the resulting matrix.

 

Example 1:


Input: mat = [[3,3,1,1],[2,2,1,2],[1,1,1,2]]
Output: [[1,1,1,1],[1,2,2,2],[1,2,3,3]]
 

Constraints:

m == mat.length
n == mat[i].length
1 <= m, n <= 100
1 <= mat[i][j] <= 100

Hint 1: 
Use a data structure to store all values of each diagonal.

Hint 2:
How to index the data structure with the id of the diagonal?

Hint 3:
All cells in the same diagonal (i,j) have the same difference so we can get the diagonal of a cell using the difference i-j.
*/

/*
Solution 1:
- use cache[n+m][...] to store data in diagonal
  - cache[m+j-i].append(mat[i][j])
- sort cache[k] and update result
  - if k <= m, res[m-k+i][i] = temp[i]   
  - else res[i][k-m+i] = temp[i]

Time Complexity: O(mn + k(log m + m))
Space Complexity: O(mn)
*/
class Solution {
    func diagonalSort(_ mat: [[Int]]) -> [[Int]] {
        let m = mat.count
        let n = mat[0].count
        
        var cache = Array(repeating: [Int](), count: n+m)
        for i in 0..<m {
            for j in 0..<n {
                cache[m+j-i].append(mat[i][j])
            }
        }
        
        var res = Array(repeating: Array(repeating: 0, count: n), 
                        count: m)
        for k in 1..<(n+m) {
            let temp = cache[k].sorted()
            for i in 0..<temp.count {
                if k <= m {
                    res[m-k+i][i] = temp[i]   
                } else {
                    res[i][k-m+i] = temp[i]
                }
            }
        }
        return res
    }
}