/*
Given an n x n array of integers matrix, return the minimum sum of any falling path through matrix.

A falling path starts at any element in the first row and chooses the element in the next row that is either directly below or diagonally left/right. Specifically, the next element from position (row, col) will be (row + 1, col - 1), (row + 1, col), or (row + 1, col + 1).



Example 1:


Input: matrix = [[2,1,3],[6,5,4],[7,8,9]]
Output: 13
Explanation: There are two falling paths with a minimum sum as shown.
Example 2:


Input: matrix = [[-19,57],[-40,-5]]
Output: -59
Explanation: The falling path with a minimum sum is shown.


Constraints:

n == matrix.length == matrix[i].length
1 <= n <= 100
-100 <= matrix[i][j] <= 100
*/

/*
Solution 1:
DP
check each row one by one
for each row checking , row[j] means current minimum falling path

Time Complexity: O(mn)
Space Complexity: O(n)
*/
class Solution {
    func minFallingPathSum(_ matrix: [[Int]]) -> Int {
        let m = matrix.count
        let n = matrix[0].count

        var line = matrix[0]

        if m > 1 {
            for i in 1..<m {
                var temp = line
                for j in 0..<n {
                    line[j] = matrix[i][j] + min(
                        j-1 >= 0 ? temp[j-1] : Int.max,
                        min(
                            temp[j],
                            j+1 < n ? temp[j+1] : Int.max
                        )
                    )
                }
            }
        }

        var smallest = line[0]
        for j in 0..<n {
            smallest = min(smallest, line[j])
        }
        return smallest
    }
}
