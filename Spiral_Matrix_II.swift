/*
Given a positive integer n, generate an n x n matrix filled with elements from 1 to n2 in spiral order.



Example 1:


Input: n = 3
Output: [[1,2,3],[8,9,4],[7,6,5]]
Example 2:

Input: n = 1
Output: [[1]]


Constraints:

1 <= n <= 20
*/

/*
Solution 1:
build matrix element one by one
use dir to help define the direction of each element
0 right, 1 down, 2 left, 3 up

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func generateMatrix(_ n: Int) -> [[Int]] {
        var matrix = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        // 0 right, 1 down, 2 left, 3 up
        var dir = 0
        var i = 0
        var j = 0
        for val in 1...(n*n) {
            matrix[i][j] = val
            if dir == 0 {
                if j+1 == n || matrix[i][j+1] != 0 {
                    // next should go down
                    dir = 1
                    i += 1
                } else {
                    // next still go right
                    j += 1
                }
            } else if dir == 1 {
                if i+1 == n || matrix[i+1][j] != 0 {
                    // next go left
                    dir = 2
                    j -= 1
                } else {
                    // go down
                    i += 1
                }
            } else if dir == 2 {
                if j-1 < 0 || matrix[i][j-1] != 0 {
                    // next go up
                    dir = 3
                    i -= 1
                } else {
                    // go left
                    j -= 1
                }
            } else if dir == 3 {
                if i-1 < 0 || matrix[i-1][j] != 0 {
                    // next go right
                    dir = 0
                    j += 1
                } else {
                    // go up
                    i -= 1
                }
            }
        }

        return matrix
    }
}