/*
Given a m * n matrix of distinct numbers, return all lucky numbers in the matrix in any order.

A lucky number is an element of the matrix such that it is the minimum element in its row and maximum in its column.



Example 1:

Input: matrix = [[3,7,8],[9,11,13],[15,16,17]]
Output: [15]
Explanation: 15 is the only lucky number since it is the minimum in its row and the maximum in its column
Example 2:

Input: matrix = [[1,10,4,2],[9,3,8,7],[15,16,17,12]]
Output: [12]
Explanation: 12 is the only lucky number since it is the minimum in its row and the maximum in its column.
Example 3:

Input: matrix = [[7,8],[1,2]]
Output: [7]


Constraints:

m == mat.length
n == mat[i].length
1 <= n, m <= 50
1 <= matrix[i][j] <= 10^5.
All elements in the matrix are distinct.

*/

/*
Solution 1:
minRow
maxCol

go through matrix 2 times,
1. build minRow, maxCol
2. check if this element is lucky number or not

Time Complexity: O(mn)
Space Complexity: O(m+n)
*/
class Solution {
    func luckyNumbers (_ matrix: [[Int]]) -> [Int] {
        let m = matrix.count
        let n = matrix[0].count

        var minRow = Array(repeating: 100_001, count: m)
        var maxCol = Array(repeating: 0, count: n)

        for i in 0..<m {
            for j in 0..<n {
                minRow[i] = min(minRow[i], matrix[i][j])
                maxCol[j] = max(maxCol[j], matrix[i][j])
            }
        }

        var lucky = [Int]()
        for i in 0..<m {
            for j in 0..<n {
                if minRow[i] == maxCol[j],
                matrix[i][j] == minRow[i] {
                    lucky.append(minRow[i])
                }
            }
        }

        return lucky
    }
}