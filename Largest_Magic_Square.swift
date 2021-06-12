/*
A k x k magic square is a k x k grid filled with integers such that every row sum, every column sum, and both diagonal sums are all equal. The integers in the magic square do not have to be distinct. Every 1 x 1 grid is trivially a magic square.

Given an m x n integer grid, return the size (i.e., the side length k) of the largest magic square that can be found within this grid.



Example 1:


Input: grid = [[7,1,4,5,6],[2,5,1,6,4],[1,5,4,3,2],[1,2,7,3,4]]
Output: 3
Explanation: The largest magic square has a size of 3.
Every row sum, column sum, and diagonal sum of this magic square is equal to 12.
- Row sums: 5+1+6 = 5+4+3 = 2+7+3 = 12
- Column sums: 5+5+2 = 1+4+7 = 6+3+3 = 12
- Diagonal sums: 5+4+3 = 6+4+2 = 12
Example 2:


Input: grid = [[5,1,3,1],[9,3,3,1],[1,3,3,8]]
Output: 2


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 50
1 <= grid[i][j] <= 106
*/

/*
Solution 1:
make
- g_r: row sum of grid
- g_c: col sum of grid
- g_d: diagonal sum of grid
- g_d1: anti-diagonal sum of grid

in later, check possible len

Time Complexity: O(mn + len*m*n*len)
Space Complexity: O(mn)
*/
class Solution {
    func largestMagicSquare(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        if m == 1 || n == 1 { return 1 }

        var g_r = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )
        var g_c = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )
        var g_d = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )
        var g_d1 = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )

        for i in 0..<m {
            for j in 0..<n {
                g_r[i][j] = grid[i][j] + (i > 0 ? g_r[i-1][j] : 0)
                g_c[i][j] = grid[i][j] + (j > 0 ? g_c[i][j-1] : 0)
                g_d[i][j] = grid[i][j] + (i > 0 && j > 0 ? g_d[i-1][j-1] : 0)
            }

            for j in stride(from: n-1, through: 0, by: -1) {
                g_d1[i][j] = grid[i][j] + (i > 0 && j+1 < n ? g_d1[i-1][j+1] : 0)
            }
        }

        // print(g_r)
        // print(g_c)
        // print(g_d)
        // print(g_d1)
        for len in stride(from: min(m, n), through: 2, by: -1) {
            // square, [i,j] [i+len-1, j], [i, j+len-1], [i+len-1, j+len-1]
            // print("len", len)
            for i in 0...max(0, m-len) {
                for j in 0...max(0, n-len) {
                    // NOTE: be carefule at +1, -1

                    var cur: Int? = nil
                    for k in 0..<len {
                        if cur == nil {
                            cur = g_r[i+len-1][j+k] - (i > 0 ? g_r[i-1][j+k] : 0)
                        } else {
                            if cur != g_r[i+len-1][j+k] - (i > 0 ? g_r[i-1][j+k] : 0)
                            || cur != g_c[i+k][j+len-1] - (j > 0 ? g_c[i+k][j-1] : 0) {
                                cur = -1
                                break
                            }
                        }
                    }
                    // print(i, j, cur)

                    if cur != g_d[i+len-1][j+len-1] - (i > 0 && j > 0 ? g_d[i-1][j-1] : 0)
                    || cur != g_d1[i+len-1][j] - (i > 0 && j+len < n ? g_d1[i-1][j+len] : 0) {
                        cur = -1
                    }

                    if cur != -1 {
                        return len
                    }
                }
            }
        }
        return 1
    }
}