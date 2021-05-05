/*
You are given an integer array cost where cost[i] is the cost of ith step on a staircase. Once you pay the cost, you can either climb one or two steps.

You can either start from the step with index 0, or the step with index 1.

Return the minimum cost to reach the top of the floor.



Example 1:

Input: cost = [10,15,20]
Output: 15
Explanation: Cheapest is: start on cost[1], pay that cost, and go to the top.
Example 2:

Input: cost = [1,100,1,1,1,100,1,1,100,1]
Output: 6
Explanation: Cheapest is: start on cost[0], and only step on 1s, skipping cost[3].


Constraints:

2 <= cost.length <= 1000
0 <= cost[i] <= 999
*/

/*
Solution 2:
optimize Solution 1 space

use 2 variable to record pre1 and pre2

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        let n = cost.count

        var pre1 = cost[0]
        var pre2 = cost[1]

        for i in 2..<n {
            let temp = min(pre1, pre2) + cost[i]
            pre1 = pre2
            pre2 = temp
        }
        return min(pre1, pre2)
    }
}

/*
Solution 1:
DP

dp[i] is final cost from 0...i
dp[i] = min(dp[i-1], dp[i-2]) + cost[i]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        let n = cost.count
        var dp = Array(repeating: 0, count: n)
        dp[0] = cost[0]
        dp[1] = cost[1]

        for i in 2..<n {
            dp[i] = min(dp[i-1], dp[i-2]) + cost[i]
        }
        return min(dp[n-1], dp[n-2])
    }
}