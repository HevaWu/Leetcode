/*
Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. This matrix has the following properties:

Integers in each row are sorted from left to right.
The first integer of each row is greater than the last integer of the previous row.


Example 1:


Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true
Example 2:


Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 100
-104 <= matrix[i][j], target <= 104
*/

/*
Solution 1:
time log(m)*log(n)
1. binary search each row, find the row this element should be in
	which means matrix[mid][0] <= target <= matrix[mid][n-1] (matrix[].length = n)
2. binary search current row, find if this element is exist in this row
*/
class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        let n = matrix[0].count

        var low = 0
        var high = m-1
        while low <= high {
            let mid = low + (high - low) / 2
            if matrix[mid][0] > target {
                high = mid-1
            } else {
                // matrix[mid][0] <= target
                if matrix[mid][n-1] < target {
                    low = mid+1
                } else {
                    // check if target is in this row or not
                    var low1 = 0
                    var high1 = n-1
                    while low1 <= high1 {
                        let mid1 = low1 + (high1 - low1) / 2
                        if matrix[mid][mid1] == target {
                            return true
                        } else {
                            if matrix[mid][mid1] < target {
                                low1 = mid1 + 1
                            } else {
                                high1 = mid1 - 1
                            }
                        }
                    }

                    return false
                }
            }
        }
        return false
    }
}