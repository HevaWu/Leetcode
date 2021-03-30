/*
You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.



Example 1:

Input: nums = [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
Example 2:

Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.
Example 3:

Input: nums = [0]
Output: 0


Constraints:

1 <= nums.length <= 100
0 <= nums[i] <= 1000
*/

/*
Solution 1:
DP

rob either
- 0...n-1 house
- 1...n house

downgrad problem to house robber

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func rob(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return nums[0] }

        var pre = 0
        var maxSum = 0

        // check rob from 0 to n-1
        for i in 0..<n-1 {
            let temp = pre
            pre = maxSum + nums[i]
            maxSum = max(maxSum, temp)
        }

        var finalSum = max(maxSum, pre)

        pre = 0
        maxSum = 0
        for i in 1..<n {
            let temp = pre
            pre = maxSum + nums[i]
            maxSum = max(maxSum, temp)
        }

        return max(finalSum, max(maxSum, pre))
    }
}