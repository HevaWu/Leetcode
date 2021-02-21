/*
A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).

The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).

How many possible unique paths are there?

 

Example 1:


Input: m = 3, n = 7
Output: 28
Example 2:

Input: m = 3, n = 2
Output: 3
Explanation:
From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
1. Right -> Down -> Down
2. Down -> Down -> Right
3. Down -> Right -> Down
Example 3:

Input: m = 7, n = 3
Output: 28
Example 4:

Input: m = 3, n = 3
Output: 6
 

Constraints:

1 <= m, n <= 100
It's guaranteed that the answer will be less than or equal to 2 * 109.
*/



/*
Solution 2
1D dp

dp[j] += dp[j-1]

Time Complexity: O(mn)
Space Complexity: O(n)
*/
class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        if m == 1 || n == 1 { return 1 }
        
        var dp = Array(repeating: 1, count: n)
        for i in 1..<m {
            for j in 1..<n {
                dp[j] += dp[j-1]
            }
        }
        return dp[n-1]
    }
}

/*
Solution 1
2D DP

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        if m == 1 || n == 1 { return 1 }
        
        var dp = Array(repeating: Array(repeating: 0, count: n), 
                       count: m)
        dp[0][0] = 1
        for i in 0..<m {
            for j in 0..<n {
                if i > 0 { dp[i][j] += dp[i-1][j] }
                if j > 0 { dp[i][j] += dp[i][j-1] }
            }
        }
        return dp[m-1][n-1]
    }
}