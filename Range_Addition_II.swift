/*
You are given an m x n matrix M initialized with all 0's and an array of operations ops, where ops[i] = [ai, bi] means M[x][y] should be incremented by one for all 0 <= x < ai and 0 <= y < bi.

Count and return the number of maximum integers in the matrix after performing all the operations.



Example 1:


Input: m = 3, n = 3, ops = [[2,2],[3,3]]
Output: 4
Explanation: The maximum integer in M is 2, and there are four of it in M. So return 4.
Example 2:

Input: m = 3, n = 3, ops = [[2,2],[3,3],[3,3],[3,3],[2,2],[3,3],[3,3],[3,3],[2,2],[3,3],[3,3],[3,3]]
Output: 4
Example 3:

Input: m = 3, n = 3, ops = []
Output: 9


Constraints:

1 <= m, n <= 4 * 104
1 <= ops.length <= 104
ops[i].length == 2
1 <= ai <= m
1 <= bi <= n
*/

/*
Solution 2:
optimize Solution 1

we know only pick the minimum x and minimum y would be enough

Time Complexity: O(size)
Space Complexity: O(size)
*/
class Solution {
    func maxCount(_ m: Int, _ n: Int, _ ops: [[Int]]) -> Int {
        let size = ops.count
        if size == 0 { return m * n }

        var x = ops[0][0]
        var y = ops[0][1]
        for i in 0..<size {
            x = min(x, ops[i][0])
            y = min(y, ops[i][1])
        }

        return x * y
    }
}

/*
Solution 1:
sort ops and check y part iteratively

because each increment is from 0<=x<ai, 0<=y<bi
if we sort ops by ai, for later added operations, current ai row will always been covered to increase,
only difference to control the max number of rectangle is the y size
for y part, when we iterate the ops, we always pick the smallest y, which will be the result most been covered rectangle x,y

Time Complexity: O(size * log(size))
- size = ops.count
Space Complexity: O(size)
*/
class Solution {
    func maxCount(_ m: Int, _ n: Int, _ ops: [[Int]]) -> Int {
        let size = ops.count
        if size == 0 { return m * n }
        if size == 1 { return ops[0][0] * ops[0][1] }

        var ops = ops.sorted(by: { first, second -> Bool in
            return first[0] < second[0]
        })

        var x = ops[0][0]
        var y = ops[0][1]

        for i in 1..<size {
            y = min(y, ops[i][1])
        }
        return x * y
    }
}