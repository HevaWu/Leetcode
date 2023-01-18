/*
Given a circular integer array nums of length n, return the maximum possible sum of a non-empty subarray of nums.

A circular array means the end of the array connects to the beginning of the array. Formally, the next element of nums[i] is nums[(i + 1) % n] and the previous element of nums[i] is nums[(i - 1 + n) % n].

A subarray may only include each element of the fixed buffer nums at most once. Formally, for a subarray nums[i], nums[i + 1], ..., nums[j], there does not exist i <= k1, k2 <= j with k1 % n == k2 % n.



Example 1:

Input: nums = [1,-2,3,-2]
Output: 3
Explanation: Subarray [3] has maximum sum 3.
Example 2:

Input: nums = [5,-3,5]
Output: 10
Explanation: Subarray [5,5] has maximum sum 5 + 5 = 10.
Example 3:

Input: nums = [-3,-2,-3]
Output: -2
Explanation: Subarray [-2] has maximum sum -2.


Constraints:

n == nums.length
1 <= n <= 3 * 104
-3 * 104 <= nums[i] <= 3 * 104
*/

/*
Solution 2:
Namely, rightMax[i] is the largest suffix sum of nums that comes at or after i.

With rightMax, we can then calculate the special sum by looking at all prefixes. We can easily accumulate the prefix while iterating over the input, and at each index i, we can check rightMax[i + 1] to find the maximum suffix that won't overlap with the current prefix.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maxSubarraySumCircular(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return nums[0] }
        var rightMax = Array(repeating: 0, count: n)
        rightMax[n-1] = nums[n-1]
        var cur = nums[n-1]
        for i in stride(from: n-2, through: 0, by: -1) {
            cur += nums[i]
            rightMax[i] = max(rightMax[i+1], cur)
        }

        var maxSum = nums[0]
        var specialSum = nums[0]
        cur = 0
        var curMax = 0
        for i in 0..<n {
            curMax = max(curMax, 0) + nums[i]
            maxSum = max(maxSum, curMax)
            cur += nums[i]
            if i+1 < n {
                specialSum = max(specialSum, cur + rightMax[i+1])
            }
        }
        return max(maxSum, specialSum)
    }
}

/*
Solution 1:
TLE

sum and total to help count all possible
i,j
then find maxSum

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func maxSubarraySumCircular(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return nums[0] }
        var total = 0
        // sum[i] is sum of [0...i]
        var sum = Array(repeating: 0, count: n)
        for i in 0..<n {
            total += nums[i]
            sum[i] = nums[i] + (i-1 >= 0 ? sum[i-1] : 0)
        }

        var maxSum = nums[0]
        for i in 0..<n {
            var val = nums[i]
            if i+1 < n {
                for j in (i+1)..<n {
                    val = max(val, max(
                        sum[j] - (i-1 >= 0 ? sum[i-1] : 0),
                        sum[i] + total - (j-1 >= 0 ? sum[j-1] : 0)
                    ))
                }
            }
            maxSum = max(maxSum, val)
        }
        return maxSum
    }
}
