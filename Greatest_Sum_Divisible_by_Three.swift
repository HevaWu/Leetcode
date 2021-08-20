/*
Given an array nums of integers, we need to find the maximum possible sum of elements of the array such that it is divisible by three.



Example 1:

Input: nums = [3,6,5,1,8]
Output: 18
Explanation: Pick numbers 3, 6, 1 and 8 their sum is 18 (maximum sum divisible by 3).
Example 2:

Input: nums = [4]
Output: 0
Explanation: Since 4 is not divisible by 3, do not pick any number.
Example 3:

Input: nums = [1,2,3,4,4]
Output: 12
Explanation: Pick numbers 1, 3, 4 and 4 their sum is 12 (maximum sum divisible by 3).


Constraints:

1 <= nums.length <= 4 * 10^4
1 <= nums[i] <= 10^4

*/

/*
Solution 1:
1D DP

dp[0] max sum divisible by 3
dp[1] max sum divisible by 3 and remain 1
dp[2] max sum divisible by 3 and remain 2

Time Complexity: O(n*3)
Space Complexity: O(1)
*/
class Solution {
    func maxSumDivThree(_ nums: [Int]) -> Int {
        let n = nums.count

        // dp[i][0] --> maximum sum of nums[0..<i] divisible by 3
        // dp[i][1] --> maximum sum of nums[0..<i] divisible by 3 and remain 1
        // dp[i][2] --> maximum sum of nums[0..<i] divisible by 3 and remain 2
        var dp = Array(repeating: 0, count: 3)

        for i in 0..<n {
            var temp = dp
            for j in 0..<3 {
                let sum = dp[j] + nums[i]
                let remain = sum % 3
                temp[remain] = max(temp[remain], max(dp[remain], sum))
            }
            dp = temp
        }

        // print(dp)
        return dp[0]
    }
}