/*
A 3 x 3 magic square is a 3 x 3 grid filled with distinct numbers from 1 to 9 such that each row, column, and both diagonals all have the same sum.

Given a row x col grid of integers, how many 3 x 3 "magic square" subgrids are there?  (Each subgrid is contiguous).



Example 1:


Input: grid = [[4,3,8,4],[9,5,1,9],[2,7,6,2]]
Output: 1
Explanation:
The following subgrid is a 3 x 3 magic square:

while this one is not:

In total, there is only one magic square inside the given grid.
Example 2:

Input: grid = [[8]]
Output: 0
Example 3:

Input: grid = [[4,4],[3,3]]
Output: 0
Example 4:

Input: grid = [[4,7,8],[9,5,1],[2,3,6]]
Output: 0


Constraints:

row == grid.length
col == grid[i].length
1 <= row, col <= 10
0 <= grid[i][j] <= 15
*/

/*
Solution 1:

Here I just want share two observatons with this 1-9 condition:

Assume a magic square:
a1,a2,a3
a4,a5,a6
a7,a8,a9

a2 + a5 + a8 = 15
a4 + a5 + a6 = 15
a1 + a5 + a9 = 15
a3 + a5 + a7 = 15

Accumulate all, then we have:
sum(ai) + 3 * a5 = 60
3 * a5 = 15
a5 = 5

The center of magic square must be 5.

Another observation for other 8 numbers:
The even must be in the corner, and the odd must be on the edge.
And it must be in a order like "43816729" （clockwise or anticlockwise)

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func numMagicSquaresInside(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        guard m > 2, n > 2 else { return 0 }

        var count = 0
        for i in 0..<(m-2) {
            for j in 0..<(n-2) {
                // center must be 5
                guard grid[i+1][j+1] == 5 else { continue }

                // i,j to i+2,j+2
                if isMagic(i, j, grid) {
                    count += 1
                }
            }
        }
        return count
    }

    func isMagic(_ i: Int, _ j: Int,
                 _ grid: [[Int]]) -> Bool {
        var arr = Array(repeating: 0, count: 10)

        // clockwise start from i,j
        var str = String()
        str.append(String(grid[i][j]))
        str.append(String(grid[i][j+1]))
        str.append(String(grid[i][j+2]))
        str.append(String(grid[i+1][j+2]))
        str.append(String(grid[i+2][j+2]))
        str.append(String(grid[i+2][j+1]))
        str.append(String(grid[i+2][j]))
        str.append(String(grid[i+1][j]))

        return grid[i][j] % 2 == 0 && (
            "4381672943816729".contains(str) || "9276183492761834".contains(str)
        )
    }
}