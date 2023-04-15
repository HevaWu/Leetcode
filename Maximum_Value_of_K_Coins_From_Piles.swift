/*
There are n piles of coins on a table. Each pile consists of a positive number of coins of assorted denominations.

In one move, you can choose any coin on top of any pile, remove it, and add it to your wallet.

Given a list piles, where piles[i] is a list of integers denoting the composition of the ith pile from top to bottom, and a positive integer k, return the maximum total value of coins you can have in your wallet if you choose exactly k coins optimally.



Example 1:


Input: piles = [[1,100,3],[7,8,9]], k = 2
Output: 101
Explanation:
The above diagram shows the different ways we can choose k coins.
The maximum total we can obtain is 101.
Example 2:

Input: piles = [[100],[100],[100],[100],[100],[100],[1,1,1,1,1,1,700]], k = 7
Output: 706
Explanation:
The maximum total can be obtained if we choose all coins from the last pile.


Constraints:

n == piles.length
1 <= n <= 1000
1 <= piles[i][j] <= 105
1 <= k <= sum(piles[i].length) <= 2000
*/

/*
Solution 1:
DP

Time Complexity: O(nk)
Space Complexity: O(nk)
*/
class Solution {
    func maxValueOfCoins(_ piles: [[Int]], _ k: Int) -> Int {
        let n = piles.count
        // dp[i][j] max value of coins for piles[i..<n] with j operations
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: k+1),
            count: n
        )
        return check(0, k, n, piles, &dp)
    }

    func check(_ i: Int, _ k: Int, _ n: Int, _ piles: [[Int]], _ dp: inout [[Int?]]) -> Int {
        guard k >= 0, i < n else { return 0 }
        if let val = dp[i][k] { return val }
        var val = check(i+1, k, n, piles, &dp)
        var cur = 0
        let size = min(piles[i].count, k)
        for j in 0..<size {
            cur += piles[i][j]
            val = max(val, cur + check(i+1, k-j-1, n, piles, &dp))
        }
        dp[i][k] = val
        return val
    }
}
