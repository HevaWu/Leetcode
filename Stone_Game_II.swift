/*
Alice and Bob continue their games with piles of stones.  There are a number of piles arranged in a row, and each pile has a positive integer number of stones piles[i].  The objective of the game is to end with the most stones.

Alice and Bob take turns, with Alice starting first.  Initially, M = 1.

On each player's turn, that player can take all the stones in the first X remaining piles, where 1 <= X <= 2M.  Then, we set M = max(M, X).

The game continues until all the stones have been taken.

Assuming Alice and Bob play optimally, return the maximum number of stones Alice can get.



Example 1:

Input: piles = [2,7,9,4,4]
Output: 10
Explanation:  If Alice takes one pile at the beginning, Bob takes two piles, then Alice takes 2 piles again. Alice can get 2 + 4 + 4 = 10 piles in total. If Alice takes two piles at the beginning, then Bob can take all three piles left. In this case, Alice get 2 + 7 = 9 piles in total. So we return 10 since it's larger.
Example 2:

Input: piles = [1,2,3,4,5,100]
Output: 104


Constraints:

1 <= piles.length <= 100
1 <= piles[i] <= 104

*/

/*
Solution 1:
memorize backtracking DP + DFS

preSum[i] is prefix sum of piles [i...]
dfs, get optimal can pick stones for start from i position, with given m

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func stoneGameII(_ piles: [Int]) -> Int {
        let n = piles.count

        // preSum[i] is prefix sum of piles [i...]
        var preSum = Array(repeating: 0, count: n)
        preSum[n-1] = piles[n-1]
        for i in stride(from: n-2, through: 0, by: -1) {
            preSum[i] = preSum[i+1] + piles[i]
        }

        var cache = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )
        return dfs(preSum, 0, 1, n, &cache)
    }

    func dfs(_ preSum: [Int],
             _ index: Int, _ m: Int, _ n: Int,
             _ cache: inout [[Int]]) -> Int {
        if index + 2*m >= n {
            // can pick all remain stones
            return preSum[index]
        }

        if cache[index][m] > 0 { return cache[index][m] }
        var val = 0
        var take = 0
        for i in 1...2*m {
            take = preSum[index] - preSum[index + i]
            val = max(val, take + preSum[index + i] - dfs(preSum, index + i, max(i, m), n, &cache))
        }

        cache[index][m] = val
        return val
    }
}