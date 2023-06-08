/*
Given a m x n matrix grid which is sorted in non-increasing order both row-wise and column-wise, return the number of negative numbers in grid.



Example 1:

Input: grid = [[4,3,2,-1],[3,2,1,-1],[1,1,-1,-2],[-1,-1,-2,-3]]
Output: 8
Explanation: There are 8 negatives number in the matrix.
Example 2:

Input: grid = [[3,2],[1,0]]
Output: 0


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 100
-100 <= grid[i][j] <= 100


Follow up: Could you find an O(n + m) solution?
*/

/*
Solution 2:
from left bottom to count the elements

Time Complexity: O(m + n)
Space Complexity: O(1)
*/
class Solution {
    func countNegatives(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        var num = 0
        var r = m-1
        var c = 0
        while r >= 0, c < n {
            if grid[r][c] < 0 {
                num += n-c
                r -= 1
            } else {
                c += 1
            }
        }
        return num
    }
}

/*
Solution 1:
binary search each row to get the negative elements number

Time Complexity: O(m*logn)
Space Complexity: O(1)
*/
class Solution {
    func countNegatives(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        if grid[0][0] < 0 {
            return m * n
        }
        var c = n
        var num = 0
        for i in 0..<m {
            let index = getIndex(i, c, n, grid)
            c = index
            num += (n-index)
        }
        return num
    }

    // in grid[i], return smallest index between[0..<c], that grid[i][index] < 0
    func getIndex(_ i: Int, _ c: Int, _ n: Int, _ grid: [[Int]]) -> Int {
        if c == 0 || grid[i][c-1] >= 0 { return c }
        var l = 0
        var r = c-1
        while l < r {
            let mid = l + (r-l)/2
            if grid[i][mid] >= 0 {
                l = mid + 1
            } else {
                r = mid
            }
        }
        return grid[i][l] >= 0 ? l+1 : l
    }
}
