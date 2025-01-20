/*
You are given a 0-indexed integer array arr, and an m x n integer matrix mat. arr and mat both contain all the integers in the range [1, m * n].

Go through each index i in arr starting from index 0 and paint the cell in mat containing the integer arr[i].

Return the smallest index i at which either a row or a column will be completely painted in mat.



Example 1:

image explanation for example 1
Input: arr = [1,3,4,2], mat = [[1,4],[2,3]]
Output: 2
Explanation: The moves are shown in order, and both the first row and second column of the matrix become fully painted at arr[2].
Example 2:

image explanation for example 2
Input: arr = [2,8,7,4,1,3,5,6,9], mat = [[3,2,5],[1,4,6],[8,7,9]]
Output: 3
Explanation: The second column becomes fully painted at arr[3].


Constraints:

m == mat.length
n = mat[i].length
arr.length == m * n
1 <= m, n <= 105
1 <= m * n <= 105
1 <= arr[i], mat[r][c] <= m * n
All the integers of arr are unique.
All the integers of mat are unique.
*/

/*
Solution 1:
Since each value would be unique in arr and mat, use this unique number as the identifier would solve the problem.
First go through mat, and record each val's position
Then go through arr, for each value, find its mat position, then for each row and col, -1 for the remaining non-painted cell. If either row / col are all painted, return current index in arr

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    // record the position in mat
    struct MatPos {
        let r: Int
        let c: Int
    }
    func firstCompleteIndex(_ arr: [Int], _ mat: [[Int]]) -> Int {
        let m = mat.count
        let n = mat[0].count

        // key is the value in mat
        // value is the mat's position record
        var valToPos = [Int: MatPos]()
        for i in 0..<m {
            for j in 0..<n {
                valToPos[mat[i][j]] = MatPos(r: i, c: j)
            }
        }

        // The remaining number at each row / col
        var row = Array(repeating: n, count: m)
        var col = Array(repeating: m, count: n)

        let arrSize = arr.count
        for i in 0..<arrSize {
            guard let matPos = valToPos[arr[i]] else {
                continue
            }
            let r = matPos.r
            let c = matPos.c
            row[r] -= 1
            col[c] -= 1
            if row[r] == 0 || col[c] == 0 {
                return i
            }
        }
        return arrSize
    }
}
