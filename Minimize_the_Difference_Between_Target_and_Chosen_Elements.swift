/*
You are given an m x n integer matrix mat and an integer target.

Choose one integer from each row in the matrix such that the absolute difference between target and the sum of the chosen elements is minimized.

Return the minimum absolute difference.

The absolute difference between two numbers a and b is the absolute value of a - b.



Example 1:


Input: mat = [[1,2,3],[4,5,6],[7,8,9]], target = 13
Output: 0
Explanation: One possible choice is to:
- Choose 1 from the first row.
- Choose 5 from the second row.
- Choose 7 from the third row.
The sum of the chosen elements is 13, which equals the target, so the absolute difference is 0.
Example 2:


Input: mat = [[1],[2],[3]], target = 100
Output: 94
Explanation: The best possible choice is to:
- Choose 1 from the first row.
- Choose 2 from the second row.
- Choose 3 from the third row.
The sum of the chosen elements is 6, and the absolute difference is 94.
Example 3:


Input: mat = [[1,2,9,8,7]], target = 6
Output: 1
Explanation: The best choice is to choose 7 from the first row.
The absolute difference is 1.


Constraints:

m == mat.length
n == mat[i].length
1 <= m, n <= 70
1 <= mat[i][j] <= 70
1 <= target <= 800

*/

/*
Solution 2:
backTrack
memorizing

sort each row first,
later, once we find val == 0, break, this will help shorten the time consisting
*/
class Solution {
    func minimizeTheDifference(_ mat: [[Int]], _ target: Int) -> Int {
        let m = mat.count
        let n = mat[0].count

        var mat = mat.map {
            $0.sorted()
        }

        // cache[i][target] is minimize difference for picking from [i..<m] row with remain target is target
        var cache = Array(
            repeating: [Int: Int](),
            count: m
        )

        return check(0, m, n, target, mat, &cache)
    }

    func check(_ row: Int, _ m: Int, _ n: Int,
               _ target: Int, _ mat: [[Int]], _ cache: inout [[Int: Int]]) -> Int {
        if row == m {
            return abs(target)
        }

        if let val = cache[row][target] { return val }

        var val = Int.max
        if target <= 0 {
            // already <= 0, remaininig row, only pick 0th element would be enough
            var t = target
            for i in row..<m {
                t -= mat[i][0]
            }
            val = abs(t)
        } else {
            for j in 0..<n {
                val = min(val, check(row+1, m, n, target-mat[row][j], mat, &cache))
                if val == 0 {
                    break
                }
            }
        }

        cache[row][target] = val
        return val
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func minimizeTheDifference(_ mat: [[Int]], _ target: Int) -> Int {
        let m = mat.count
        let n = mat[0].count

        // cache[i][target] is minimize difference for picking from [i..<m] row with remain target is target
        var cache = Array(
            repeating: [Int: Int](),
            count: m
        )

        return check(0, m, n, target, mat, &cache)
    }

    func check(_ row: Int, _ m: Int, _ n: Int,
               _ target: Int, _ mat: [[Int]], _ cache: inout [[Int: Int]]) -> Int {
        if row == m {
            return abs(target)
        }

        if let val = cache[row][target] { return val }

        var val = Int.max

        for j in 0..<n {
            val = min(val, check(row+1, m, n, target-mat[row][j], mat, &cache))
        }

        cache[row][target] = val
        return val
    }
}