/*
You are given two arrays rowSum and colSum of non-negative integers where rowSum[i] is the sum of the elements in the ith row and colSum[j] is the sum of the elements of the jth column of a 2D matrix. In other words, you do not know the elements of the matrix, but you do know the sums of each row and column.

Find any matrix of non-negative integers of size rowSum.length x colSum.length that satisfies the rowSum and colSum requirements.

Return a 2D array representing any matrix that fulfills the requirements. It's guaranteed that at least one matrix that fulfills the requirements exists.



Example 1:

Input: rowSum = [3,8], colSum = [4,7]
Output: [[3,0],
         [1,7]]
Explanation:
0th row: 3 + 0 = 3 == rowSum[0]
1st row: 1 + 7 = 8 == rowSum[1]
0th column: 3 + 1 = 4 == colSum[0]
1st column: 0 + 7 = 7 == colSum[1]
The row and column sums match, and all matrix elements are non-negative.
Another possible matrix is: [[1,2],
                             [3,5]]
Example 2:

Input: rowSum = [5,7,10], colSum = [8,6,8]
Output: [[0,5,0],
         [6,1,0],
         [2,0,8]]
Example 3:

Input: rowSum = [14,9], colSum = [6,9,8]
Output: [[0,9,5],
         [6,0,3]]
Example 4:

Input: rowSum = [1,0], colSum = [1]
Output: [[1],
         [0]]
Example 5:

Input: rowSum = [0], colSum = [0]
Output: [[0]]


Constraints:

1 <= rowSum.length, colSum.length <= 500
0 <= rowSum[i], colSum[i] <= 108
sum(rows) == sum(columns)

*/

/*
Solution 1:

Find the smallest rowSum or colSum, and let it be x. Place that number in the grid, and subtract x from rowSum and colSum. Continue until all the sums are satisfied.

- find minimum rowSum row, and colSum col
- update min_row, min_col element as min(rowSum[row], colSum[col])
- subtract min val from rowSum and colSum, if one rowSum is == 0, update remaining element of this row as 0(do same for col)
- checking if there is any remaining row/col, if no, all elements are updated

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func restoreMatrix(_ rowSum: [Int], _ colSum: [Int]) -> [[Int]] {
        let m = rowSum.count
        let n = colSum.count

        // generate m*n matrix
        var res = Array(
            repeating: Array(repeating: 0, count: n),
            count: m
        )

        var remain_r = Set(0..<m)
        var remain_c = Set(0..<n)

        var matrix = Array(
            repeating: Array(repeating: -1, count: n),
            count: m
        )
        var rowSum = rowSum
        var colSum = colSum

        while !remain_r.isEmpty, !remain_c.isEmpty {
            // find minimum r sum and col sum
            let (r, c) = find(remain_r, remain_c, rowSum, colSum)
            // print(r, c)

            let val = min(rowSum[r], colSum[c])
            matrix[r][c] = val
            rowSum[r] -= val
            colSum[c] -= val

            if rowSum[r] == 0 {
                remain_r.remove(r)
                // update all remaining r row elements
                for j in 0..<n {
                    if matrix[r][j] == -1 {
                        matrix[r][j] = 0
                    }
                }
            }
            if colSum[c] == 0 {
                remain_c.remove(c)
                // update all remaining c col elements
                for i in 0..<m {
                    if matrix[i][c] == -1 {
                        matrix[i][c] = 0
                    }
                }
            }
        }

        return matrix
    }

    func find(_ remain_r: Set<Int>, _ remain_c: Set<Int>,
              _ rowSum: [Int], _ colSum: [Int]) -> (r: Int, c: Int) {
        var r = -1
        var c = -1
        for i in remain_r {
            if r == -1 || rowSum[i] < rowSum[r] {
                r = i
            }
        }

        for i in remain_c {
            if c == -1 || colSum[i] < colSum[c] {
                c = i
            }
        }
        return (r, c)
    }
}