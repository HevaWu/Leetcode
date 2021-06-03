/*
You have a pointer at index 0 in an array of size arrLen. At each step, you can move 1 position to the left, 1 position to the right in the array, or stay in the same place (The pointer should not be placed outside the array at any time).

Given two integers steps and arrLen, return the number of ways such that your pointer still at index 0 after exactly steps steps. Since the answer may be too large, return it modulo 109 + 7.



Example 1:

Input: steps = 3, arrLen = 2
Output: 4
Explanation: There are 4 differents ways to stay at index 0 after 3 steps.
Right, Left, Stay
Stay, Right, Left
Right, Stay, Left
Stay, Stay, Stay
Example 2:

Input: steps = 2, arrLen = 4
Output: 2
Explanation: There are 2 differents ways to stay at index 0 after 2 steps
Right, Left
Stay, Stay
Example 3:

Input: steps = 4, arrLen = 2
Output: 8


Constraints:

1 <= steps <= 500
1 <= arrLen <= 106
*/

/*
Solution 1:
DP

temp[i] = dp[i] + dp[i-1] + dp[i+1]

Time Complexity: O(steps^2)
Space Complexity: O(arrLen)
*/
cclass Solution {
    func numWays(_ steps: Int, _ arrLen: Int) -> Int {
        let mod = Int(1e9 + 7)

        // dp[i], after steps, ways to stay at ith position

        // count is min(arrLen, steps+1)+1
        var dp = Array(repeating: 0, count: min(arrLen, steps+1)+1)
        dp[0] = 1

        for s in 1...steps {
            var temp = dp
            // The key observation is that we can prune all the positions where i>steps as we can never reach 0 in that case.
            for i in 0..<min(steps+1, arrLen) {
                temp[i] = (dp[i] + (i > 0 ? dp[i-1] : 0) + (i+1 < arrLen ? dp[i+1] : 0)) % mod
            }
            dp = temp
        }

        return dp[0] % mod
    }
}