/*
Given a square matrix mat, return the sum of the matrix diagonals.

Only include the sum of all the elements on the primary diagonal and all the elements on the secondary diagonal that are not part of the primary diagonal.



Example 1:


Input: mat = [[1,2,3],
              [4,5,6],
              [7,8,9]]
Output: 25
Explanation: Diagonals sum: 1 + 5 + 9 + 3 + 7 = 25
Notice that element mat[1][1] = 5 is counted only once.
Example 2:

Input: mat = [[1,1,1,1],
              [1,1,1,1],
              [1,1,1,1],
              [1,1,1,1]]
Output: 8
Example 3:

Input: mat = [[5]]
Output: 5


Constraints:

n == mat.length == mat[i].length
1 <= n <= 100
1 <= mat[i][j] <= 100
*/

/*
Solution 1:
primary diagonal is from
[0,0] to [n-1, n-1]
secondary diagonal is from
[0, n-1] to [n-1, 0]

use x0, y1 to indicate primary diagonal and secondary diagonal

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func diagonalSum(_ mat: [[Int]]) -> Int {
        let n = mat.count
        var x0 = 0
        var y1 = n-1
        var val = 0
        while x0 < n {
            val += mat[x0][x0]
            val += mat[x0][y1]
            x0 += 1
            y1 -= 1
        }
        if n % 2 == 1 {
            let index = n / 2
            val -= mat[index][index]
        }

        return val
    }
}
