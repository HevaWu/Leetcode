/*
Alex and Lee play a game with piles of stones.  There are an even number of piles arranged in a row, and each pile has a positive integer number of stones piles[i].

The objective of the game is to end with the most stones.  The total number of stones is odd, so there are no ties.

Alex and Lee take turns, with Alex starting first.  Each turn, a player takes the entire pile of stones from either the beginning or the end of the row.  This continues until there are no more piles left, at which point the person with the most stones wins.

Assuming Alex and Lee play optimally, return True if and only if Alex wins the game.



Example 1:

Input: piles = [5,3,4,5]
Output: true
Explanation:
Alex starts first, and can only take the first 5 or the last 5.
Say he takes the first 5, so that the row becomes [3, 4, 5].
If Lee takes 3, then the board is [4, 5], and Alex takes 5 to win with 10 points.
If Lee takes the last 5, then the board is [3, 4], and Alex takes 4 to win with 9 points.
This demonstrated that taking the first 5 was a winning move for Alex, so we return true.


Constraints:

2 <= piles.length <= 500
piles.length is even.
1 <= piles[i] <= 500
sum(piles) is odd.
*/

/*
Solution 3:
math

alex always wins

Alex clearly always wins the 2 pile game. With some effort, we can see that she always wins the 4 pile game.

If Alex takes the first pile initially, she can always take the third pile. If she takes the fourth pile initially, she can always take the second pile. At least one of first + third, second + fourth is larger, so she can always win.

We can extend this idea to N piles. Say the first, third, fifth, seventh, etc. piles are white, and the second, fourth, sixth, eighth, etc. piles are black. Alex can always take either all white piles or all black piles, and one of the colors must have a sum number of stones larger than the other color.

Hence, Alex always wins the game.

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func stoneGame(_ piles: [Int]) -> Bool {
        return true
    }
}

/*
Solution 2:

DP

When the piles remaining are piles[i], piles[i+1], ..., piles[j], the player who's turn it is has at most 2 moves.

The person who's turn it is can be found by comparing j-i to N modulo 2.

If the player is Alex, then she either takes piles[i] or piles[j], increasing her score by that amount. Afterwards, the total score is either piles[i] + dp(i+1, j), or piles[j] + dp(i, j-1); and we want the maximum possible score.

If the player is Lee, then he either takes piles[i] or piles[j], decreasing Alex's score by that amount. Afterwards, the total score is either -piles[i] + dp(i+1, j), or -piles[j] + dp(i, j-1); and we want the minimum possible score.

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func stoneGame(_ piles: [Int]) -> Bool {
        let n = piles.count

        // dp[i+1][j+1] piles[i...j]
        var dp = Array(
            repeating: Array(repeating: 0, count: n+2),
            count: n+2
        )
        for len in 1...n {
            for j in (len-1)..<n {
                let i = j-len+1
                let isAlex = (i+j+n) % 2
                if isAlex == 1 {
                    dp[i+1][j+1] = max(
                        piles[i] + dp[i+2][j+1],
                        piles[j] + dp[i+1][j]
                    )
                } else {
                    dp[i+1][j+1] = min(
                        -piles[i] + dp[i+2][j+1],
                        -piles[j] + dp[i+1][j]
                    )
                }
            }
        }
        return dp[1][n] > 0
    }
}

/*
Solution 1:
backtracking with memorization

Alex try to increase the stone value
Lee try to minimize the stone value

for take optimal, all person try to get maximum stones

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func stoneGame(_ piles: [Int]) -> Bool {
        let n = piles.count

        // cache[i][j] max number of stones this person can take during i...j
        cache = Array(
            repeating: Array(repeating: nil, count: n),
            count: n
        )
        return check(0, n-1, 0, piles) > 0
    }

    var cache = [[Int?]]()
    func check(_ l: Int, _ r: Int,
               _ cur: Int, _ piles: [Int]) -> Int {
        if l == r {
            return piles[l] - cur
        }

        if let val = cache[l][r] { return val }
        let val = max(
            check(l+1, r, piles[l]-cur, piles),
            check(l, r-1, piles[r]-cur, piles)
        )
        cache[l][r] = val
        return val

    }
}