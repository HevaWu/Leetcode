/*
You are given two integers m and n. Consider an m x n grid where each cell is initially white. You can paint each cell red, green, or blue. All cells must be painted.

Return the number of ways to color the grid with no two adjacent cells having the same color. Since the answer can be very large, return it modulo 109 + 7.



Example 1:


Input: m = 1, n = 1
Output: 3
Explanation: The three possible colorings are shown in the image above.
Example 2:


Input: m = 1, n = 2
Output: 6
Explanation: The six possible colorings are shown in the image above.
Example 3:

Input: m = 5, n = 5
Output: 580986


Constraints:

1 <= m <= 5
1 <= n <= 1000
*/

/*
Solution 1:
m is in 1...5
similar as 1411 questions

1, First we rotate the grid 90 degree clockwise, now it became the harder version of 1411, that is N X M Grid (M is in the range [1-5])
2. we use a 3-based number to represent the state of one row. For example, 210 = 2 * 3^2 + 1 * 3^1 + 0 * 3^0. Let’s assume 0- red, 1-blue, 2-green.
3, selfOK() is used to check whether one row is valid or not
4. crossOK() is used to check the adjacent two rows.

Time Complexity: O(n * 3^m * 3^m)
Space Complexity: O(n * 3^m)
*/
class Solution {
    var m: Int = 0
    func colorTheGrid(_ m: Int, _ n: Int) -> Int {
        self.m = m

        let mod = Int(1e9 + 7)
        var x = Int(pow(Double(3), Double(m)))
        var dp = Array(
            repeating: Array(repeating: 0, count: x),
            count: n
        )

        // f[i] means ith row is valid row
        var f = Array(repeating: false, count: x)

        // A[i][j] means if ith row, jth row, col in ith,jth is valid
        var A = Array(
            repeating: Array(repeating: false, count: x),
            count: x
        )

        for i in 0..<x {
            if validRow(i) {
                f[i] = true
                dp[0][i] = 1
            }
        }

        for i in 0..<x {
            for j in 0..<x {
                if f[i], f[j], validCol(i, j) {
                    A[i][j] = true
                }
            }
        }

        for i in 1..<n {
            for p in 0..<x {
                if !f[p] { continue }
                for q in 0..<x {
                    if !f[q] { continue }
                    if A[p][q] {
                        dp[i][p] = (dp[i][p] + dp[i-1][q]) % mod
                    }
                }
            }
        }

        var count = 0
        for p in 0..<x {
            count = (count + dp[n-1][p]) % mod
        }
        return count
    }

    func validRow(_ p: Int) -> Bool {
        var A = Array(repeating: 0, count: m)
        var p = p

        var i = 0
        while p > 0 {
            A[i] = p%3
            p /= 3
            i += 1
        }

        for i in 0..<(m-1) {
            if A[i] == A[i+1] {
                return false
            }
        }
        return true
    }

    func validCol(_ p: Int, _ q: Int) -> Bool {
        var A = Array(repeating: 0, count: m)
        var B = Array(repeating: 0, count: m)

        var p = p
        var q = q

        var i = 0
        while p > 0 {
            A[i] = p % 3
            p /= 3
            i += 1
        }

        i = 0
        while q > 0 {
            B[i] = q % 3
            q /= 3
            i += 1
        }

        for i in 0..<m {
            if A[i] == B[i] {
                return false
            }
        }
        return true
    }
}