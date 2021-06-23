/*
We stack glasses in a pyramid, where the first row has 1 glass, the second row has 2 glasses, and so on until the 100th row.  Each glass holds one cup of champagne.

Then, some champagne is poured into the first glass at the top.  When the topmost glass is full, any excess liquid poured will fall equally to the glass immediately to the left and right of it.  When those glasses become full, any excess champagne will fall equally to the left and right of those glasses, and so on.  (A glass at the bottom row has its excess champagne fall on the floor.)

For example, after one cup of champagne is poured, the top most glass is full.  After two cups of champagne are poured, the two glasses on the second row are half full.  After three cups of champagne are poured, those two cups become full - there are 3 full glasses total now.  After four cups of champagne are poured, the third row has the middle glass half full, and the two outside glasses are a quarter full, as pictured below.



Now after pouring some non-negative integer cups of champagne, return how full the jth glass in the ith row is (both i and j are 0-indexed.)



Example 1:

Input: poured = 1, query_row = 1, query_glass = 1
Output: 0.00000
Explanation: We poured 1 cup of champange to the top glass of the tower (which is indexed as (0, 0)). There will be no excess liquid so all the glasses under the top glass will remain empty.
Example 2:

Input: poured = 2, query_row = 1, query_glass = 1
Output: 0.50000
Explanation: We poured 2 cups of champange to the top glass of the tower (which is indexed as (0, 0)). There is one cup of excess liquid. The glass indexed as (1, 0) and the glass indexed as (1, 1) will share the excess liquid equally, and each will get half cup of champange.
Example 3:

Input: poured = 100000009, query_row = 33, query_glass = 17
Output: 1.00000


Constraints:

0 <= poured <= 109
0 <= query_glass <= query_row < 100
*/

/*
Solution 1:
track how many remains at current i,j glasses

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func champagneTower(_ poured: Int, _ query_row: Int, _ query_glass: Int) -> Double {
        var tower: [[Double]] = Array(
            repeating: Array(repeating: Double(0), count: query_row+1),
            count: query_row+1
        )
        tower[0][0] = Double(poured)

        for i in 0..<query_row {
            for j in 0...i {
                let left = (tower[i][j] - 1.0) / 2.0
                if left > 0 {
                    tower[i+1][j] += left
                    tower[i+1][j+1] += left
                }
            }
        }

        // max is 1
        return min(1, tower[query_row][query_glass])
    }
}

/*
Solution 1:
TLE

DFS calculate all rows until query_row
*/
class Solution {
    func champagneTower(_ poured: Int, _ query_row: Int, _ query_glass: Int) -> Double {
        var tower: [[Double]] = Array(
            repeating: Array(repeating: Double(0), count: query_row+1),
            count: query_row+1
        )

        check(0, 0, query_row+1, Double(poured), &tower)
        return tower[query_row][query_glass]
    }

    func check(_ i: Int, _ j: Int,
               _ n: Int,
               _ poured: Double, _ tower: inout [[Double]]) {
        guard i < n else { return }
        let remain_space = Double(1) - tower[i][j]
        if poured <= remain_space {
            tower[i][j] += poured
            return
        } else {
            tower[i][j] += remain_space
            check(i+1, j, n, (poured-remain_space)/2, &tower)
            check(i+1, j+1, n, (poured-remain_space)/2, &tower)
        }
    }
}