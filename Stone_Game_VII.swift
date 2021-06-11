/*
Alice and Bob take turns playing a game, with Alice starting first.

There are n stones arranged in a row. On each player's turn, they can remove either the leftmost stone or the rightmost stone from the row and receive points equal to the sum of the remaining stones' values in the row. The winner is the one with the higher score when there are no stones left to remove.

Bob found that he will always lose this game (poor Bob, he always loses), so he decided to minimize the score's difference. Alice's goal is to maximize the difference in the score.

Given an array of integers stones where stones[i] represents the value of the ith stone from the left, return the difference in Alice and Bob's score if they both play optimally.



Example 1:

Input: stones = [5,3,1,4,2]
Output: 6
Explanation:
- Alice removes 2 and gets 5 + 3 + 1 + 4 = 13 points. Alice = 13, Bob = 0, stones = [5,3,1,4].
- Bob removes 5 and gets 3 + 1 + 4 = 8 points. Alice = 13, Bob = 8, stones = [3,1,4].
- Alice removes 3 and gets 1 + 4 = 5 points. Alice = 18, Bob = 8, stones = [1,4].
- Bob removes 1 and gets 4 points. Alice = 18, Bob = 12, stones = [4].
- Alice removes 4 and gets 0 points. Alice = 18, Bob = 12, stones = [].
The score difference is 18 - 12 = 6.
Example 2:

Input: stones = [7,90,5,1,100,10,10,2]
Output: 122


Constraints:

n == stones.length
2 <= n <= 1000
1 <= stones[i] <= 1000
*/

/*
Solution 2:
bottom up

- sum[i], sum of 0..<i
- dp[i][j], max score of [i...j]
    dp[i][j] = max (
        sum[j+1] - sum[i+1] - dp[i+1][j], // pick ith element, sum[j+1]-sum[i+1], sum of [(i+1)...j]
        sum[j] -sum[i] - dp[i][j-1] // pick jth element, sum[j] - sum[i], sum of [i...(j-1)]
    )

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func stoneGameVII(_ stones: [Int]) -> Int {
        let n = stones.count

        // dp[i][j] max score difference between 0...j
        var dp: [[Int]] = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        // sum[i], sum of 0..<i
        var sum = Array(repeating: 0, count: n+1)
        for i in 1...n {
            sum[i] = stones[i-1] + sum[i-1]
        }

        for i in stride(from: n-2, through: 0, by: -1) {
            guard i+1 < n else { continue }
            for j in (i+1)..<n {
                dp[i][j] = max(
                    sum[j+1] - sum[i+1] - dp[i+1][j],
                    sum[j] - sum[i] - dp[i][j-1]
                )
            }
        }

        return dp[0][n-1]
    }
}

/*
Solution 1:
DP

try from 2 side, pick maximum difference between 2 choice

- Alice is starting first, and her goal is to maximize the difference, so we always take the maximum between the two options. If Bob was starting first, we would take the minimum between the two options.
- We don't need to keep track of turns because, at the time of Alice, we are maximizing aliceCurrentPick - (bobNextPick onwards), which will inherently minimize bobNextPick. At Bob's turn in recursion, we are again taking maximum of two options, because that will be negated on a layer above, hence playing the optimal move to reduce the difference.

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func stoneGameVII(_ stones: [Int]) -> Int {
        let sum = stones.reduce(into: 0) { res, next in
            res += next
        }

        let n = stones.count
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: n),
            count: n
        )

        return check(0, n-1, stones, sum, &dp)
    }

    func check(_ i: Int, _ j: Int, _ stones: [Int], _ sum: Int, _ dp: inout [[Int?]]) -> Int {
        if i == j { return 0 }
        if let val = dp[i][j] { return val }
        let val = max(
            sum - stones[i] - check(i+1, j, stones, sum-stones[i], &dp),
            sum - stones[j] - check(i, j-1, stones, sum-stones[j], &dp)
        )
        dp[i][j] = val
        return val
    }
}