/*
You are given an m x n integer matrix grid​​​.

A rhombus sum is the sum of the elements that form the border of a regular rhombus shape in grid​​​. The rhombus must have the shape of a square rotated 45 degrees with each of the corners centered in a grid cell. Below is an image of four valid rhombus shapes with the corresponding colored cells that should be included in each rhombus sum:


Note that the rhombus can have an area of 0, which is depicted by the purple rhombus in the bottom right corner.

Return the biggest three distinct rhombus sums in the grid in descending order. If there are less than three distinct values, return all of them.



Example 1:


Input: grid = [[3,4,5,1,3],[3,3,4,2,3],[20,30,200,40,10],[1,5,5,4,1],[4,3,2,2,5]]
Output: [228,216,211]
Explanation: The rhombus shapes for the three biggest distinct rhombus sums are depicted above.
- Blue: 20 + 3 + 200 + 5 = 228
- Red: 200 + 2 + 10 + 4 = 216
- Green: 5 + 200 + 4 + 2 = 211
Example 2:


Input: grid = [[1,2,3],[4,5,6],[7,8,9]]
Output: [20,9,8]
Explanation: The rhombus shapes for the three biggest distinct rhombus sums are depicted above.
- Blue: 4 + 2 + 6 + 8 = 20
- Red: 9 (area 0 rhombus in the bottom right corner)
- Green: 8 (area 0 rhombus in the bottom middle)
Example 3:

Input: grid = [[7,7,7]]
Output: [7]
Explanation: All three possible rhombus sums are the same, so return [7].


Constraints:

m == grid.length
n == grid[i].length
1 <= m, n <= 100
1 <= grid[i][j] <= 105
*/

/*
Solution 1:
brute force

check possible rhombus for all i,j
use set to make sure only pick top 3 sum

Time Complexity: O(mn*k*k)
*/
class Solution {
    func getBiggestThree(_ grid: [[Int]]) -> [Int] {
        let m = grid.count
        let n = grid[0].count

        var three = Set<Int>()

        for i in 0..<m {
            for j in 0..<n {
                var k = 0
                while i+k < m, i-k >= 0, j+2*k < n {
                    var r = i
                    var c = j
                    var r_sum = 0

                    // build rhombus ↘️↗️↖️↙️
                    repeat {
                        r_sum += grid[r][c]
                        r += 1
                        c += 1
                    } while r < i+k

                    if k > 0 {
                        repeat {
                            r_sum += grid[r][c]
                            r -= 1
                            c += 1
                        } while c < j+2*k

                        repeat {
                            r_sum += grid[r][c]
                            r -= 1
                            c -= 1
                        } while r > i-k

                        repeat {
                            r_sum += grid[r][c]
                            r += 1
                            c -= 1
                        } while r < i
                    }

                    three.insert(r_sum)
                    if three.count > 3 {
                        three.remove(three.min()!)
                    }

                    k += 1
                }
            }
        }

        return Array(three).sorted(by: >)
    }
}