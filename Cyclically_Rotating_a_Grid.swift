/*
You are given an m x n integer matrix grid​​​, where m and n are both even integers, and an integer k.

The matrix is composed of several layers, which is shown in the below image, where each color is its own layer:



A cyclic rotation of the matrix is done by cyclically rotating each layer in the matrix. To cyclically rotate a layer once, each element in the layer will take the place of the adjacent element in the counter-clockwise direction. An example rotation is shown below:


Return the matrix after applying k cyclic rotations to it.



Example 1:


Input: grid = [[40,10],[30,20]], k = 1
Output: [[10,20],[40,30]]
Explanation: The figures above represent the grid at every state.
Example 2:


Input: grid = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]], k = 2
Output: [[3,4,8,12],[2,11,10,16],[1,7,6,15],[5,9,13,14]]
Explanation: The figures above represent the grid at every state.


Constraints:

m == grid.length
n == grid[i].length
2 <= m, n <= 50
Both m and n are even integers.
1 <= grid[i][j] <= 5000
1 <= k <= 109
*/

/*
Solution 1:
use extra array for record each layer object

Time Complexity: O(mn)
Space Complexity: O(m+n)
*/
class Solution {
    func rotateGrid(_ grid: [[Int]], _ k: Int) -> [[Int]] {
        let m = grid.count
        let n = grid[0].count

        // both m,n are even
        let layer = min(m/2, n/2)
        var res = grid
        for t in 0..<layer {
            var arr = [Int]()
            // top row
            for j in t..<n-t-1 {
                arr.append(grid[t][j])
            }

            // right col
            for i in t..<m-t-1 {
                arr.append(grid[i][n-t-1])
            }

            // bottom row
            for j in stride(from: n-t-1, through: t+1, by: -1) {
                arr.append(grid[m-t-1][j])
            }

            // left col
            for i in stride(from: m-t-1, through: t+1, by: -1) {
                arr.append(grid[i][t])
            }

            // rotate arr
            let rotate = k % arr.count
            arr.append(contentsOf: arr[0..<rotate])

            update(&res, t, m, n, rotate, arr)
        }
        return res
    }

    func update(_ res: inout [[Int]], _ t: Int, _ m: Int, _ n: Int,
                _ index: Int, _ arr: [Int]) {
        var index = index

        // top row
        for j in t..<n-t-1 {
            res[t][j] = arr[index]
            index += 1
        }

        // right col
        for i in t..<m-t-1 {
            res[i][n-t-1] = arr[index]
            index += 1
        }

        // bottom row
        for j in stride(from: n-t-1, through: t+1, by: -1) {
            res[m-t-1][j] = arr[index]
            index += 1
        }

        // left col
        for i in stride(from: m-t-1, through: t+1, by: -1) {
            res[i][t] = arr[index]
            index += 1
        }

    }
}