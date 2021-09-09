/*
You are given an integer n. You have an n x n binary grid grid with all values initially 1's except for some indices given in the array mines. The ith element of the array mines is defined as mines[i] = [xi, yi] where grid[xi][yi] == 0.

Return the order of the largest axis-aligned plus sign of 1's contained in grid. If there is none, return 0.

An axis-aligned plus sign of 1's of order k has some center grid[r][c] == 1 along with four arms of length k - 1 going up, down, left, and right, and made of 1's. Note that there could be 0's or 1's beyond the arms of the plus sign, only the relevant area of the plus sign is checked for 1's.



Example 1:


Input: n = 5, mines = [[4,2]]
Output: 2
Explanation: In the above grid, the largest plus sign can only be of order 2. One of them is shown.
Example 2:


Input: n = 1, mines = [[0,0]]
Output: 0
Explanation: There is no plus sign, so return 0.


Constraints:

1 <= n <= 500
1 <= mines.length <= 5000
0 <= xi, yi < n
All the pairs (xi, yi) are unique.
*/

/*
Solution 1:
build left, right, up, down
left[i][j] is number of 1s in the left of i,j
...

then plus = max(plus, min(left,right, up, down))

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func orderOfLargestPlusSign(_ n: Int, _ mines: [[Int]]) -> Int {
        var grid = Array(
            repeating: Array(repeating: 1, count: n),
            count: n
        )

        for m in mines {
            grid[m[0]][m[1]] = 0
        }

        // left[i][j] means number of 1s in the left of i,j
        var left = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        // up[i][j] means number of 1s in the up of i,j
        var up = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in 0..<n {
            for j in 0..<n {
                if i > 0, grid[i-1][j] == 1 {
                    up[i][j] = up[i-1][j] + 1
                } else {
                    up[i][j] = 0
                }

                if j > 0, grid[i][j-1] == 1 {
                    left[i][j] = left[i][j-1] + 1
                } else {
                    left[i][j] = 0
                }
            }
        }

        // right[i][j] means number of 1s in the right of i,j
        var right = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        // down[i][j] means number of 1s in the down of i,j
        var down = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in stride(from: n-1, through: 0, by: -1) {
            for j in stride(from: n-1, through: 0, by: -1) {
                if i+1 < n, grid[i+1][j] == 1 {
                    down[i][j] = down[i+1][j] + 1
                } else {
                    down[i][j] = 0
                }

                if j+1 < n, grid[i][j+1] == 1 {
                    right[i][j] = right[i][j+1] + 1
                } else {
                    right[i][j] = 0
                }
            }
        }
        // print(left, right, up, down)

        var plus = 0
        for i in 0..<n {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    plus = max(
                        plus,
                        min(
                            min(left[i][j], right[i][j]),
                            min(up[i][j], down[i][j])
                        ) + 1
                    )
                }
            }
        }
        return plus
    }
}