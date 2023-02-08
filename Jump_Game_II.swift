/*
Given an array of non-negative integers nums, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Your goal is to reach the last index in the minimum number of jumps.

You can assume that you can always reach the last index.



Example 1:

Input: nums = [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
Example 2:

Input: nums = [2,3,0,1,4]
Output: 2


Constraints:

1 <= nums.length <= 1000
0 <= nums[i] <= 105
*/

/*
Solution 2:
greedy

memo farthest point we can jump
use curJump to help checking if we can increase jumps

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func jump(_ nums: [Int]) -> Int {
        let n = nums.count

        var jumps = 0
        var farthest = 0
        var curJump = 0

        // NOTE: n-1 here to not count n-1 jump into final
        for i in 0..<n-1 {
            farthest = max(farthest, i+nums[i])
            if curJump == i {
                jumps += 1
                curJump = farthest
            }
        }

        return jumps
    }
}

/*
Solution 1:
DP

dp[i] means min jumps can reach i position
iterate nums[i], check if we can reduce jumps in (i+1...i+nums[i])

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func jump(_ nums: [Int]) -> Int {
        let n = nums.count

        // dp[i] min jumps to nums[i]
        var dp = Array(repeating: Int.max, count: n)
        dp[0] = 0

        for i in 0..<n-1 {
            if nums[i] > 0 {
                for j in i+1...min(i+nums[i], n-1) {
                    dp[j] = min(dp[j], dp[i] + 1)
                }
            }
        }
        return dp[n-1]
    }
}
