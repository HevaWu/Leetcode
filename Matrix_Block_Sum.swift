/*
Given a m * n matrix mat and an integer K, return a matrix answer where each answer[i][j] is the sum of all elements mat[r][c] for i - K <= r <= i + K, j - K <= c <= j + K, and (r, c) is a valid position in the matrix.
 

Example 1:

Input: mat = [[1,2,3],[4,5,6],[7,8,9]], K = 1
Output: [[12,21,16],[27,45,33],[24,39,28]]
Example 2:

Input: mat = [[1,2,3],[4,5,6],[7,8,9]], K = 2
Output: [[45,45,45],[45,45,45],[45,45,45]]
 

Constraints:

m == mat.length
n == mat[i].length
1 <= m, n, K <= 100
1 <= mat[i][j] <= 100
*/

/*
Solution 1:
build sum then calculate ans

- sum[i][j] = mat[i-1][j-1] + sum[i][j-1] + sum[i-1][j] - sum[i-1][j-1]
- ans[i][j] = sum[i+k+1][j+k+1] - sum[i-k][j+k+1] - sum[i+k+1][j-k] + sum[i-k][j-k]

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func matrixBlockSum(_ mat: [[Int]], _ K: Int) -> [[Int]] {
        let m = mat.count
        let n = mat[0].count
        
        var sum = Array(repeating: Array(repeating: 0, count: n+1),
                        count: m+1)
        
        for i in 1...m {
            for j in 1...n {
                sum[i][j] = mat[i-1][j-1] 
                + sum[max(i-1, 0)][j]
                + sum[i][max(j-1, 0)]
                - sum[max(i-1, 0)][max(j-1, 0)]
            }
        }

        if K >= m-1, K >= n-1 {
            return Array(repeating: Array(repeating: sum[m][n], count: n), 
                         count: m)
        }
        
        var ans = Array(repeating: Array(repeating: 0, count: n),
                        count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                ans[i][j] = sum[min(i+K+1, m)][min(j+K+1, n)]
                - sum[max(i-K, 0)][min(j+K+1, n)]
                - sum[min(i+K+1, m)][max(j-K, 0)]
                + sum[max(i-K, 0)][max(j-K, 0)]
            }
        }
                
        return ans
    }
}