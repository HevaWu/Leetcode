/*
You are currently designing a dynamic array. You are given a 0-indexed integer array nums, where nums[i] is the number of elements that will be in the array at time i. In addition, you are given an integer k, the maximum number of times you can resize the array (to any size).

The size of the array at time t, sizet, must be at least nums[t] because there needs to be enough space in the array to hold all the elements. The space wasted at time t is defined as sizet - nums[t], and the total space wasted is the sum of the space wasted across every time t where 0 <= t < nums.length.

Return the minimum total space wasted if you can resize the array at most k times.

Note: The array can have any size at the start and does not count towards the number of resizing operations.



Example 1:

Input: nums = [10,20], k = 0
Output: 10
Explanation: size = [20,20].
We can set the initial size to be 20.
The total wasted space is (20 - 10) + (20 - 20) = 10.
Example 2:

Input: nums = [10,20,30], k = 1
Output: 10
Explanation: size = [20,20,30].
We can set the initial size to be 20 and resize to 30 at time 2.
The total wasted space is (20 - 10) + (20 - 20) + (30 - 30) = 10.
Example 3:

Input: nums = [10,20,15,30,20], k = 2
Output: 15
Explanation: size = [10,20,20,30,30].
We can set the initial size to 10, resize to 20 at time 1, and resize to 30 at time 3.
The total wasted space is (10 - 10) + (20 - 20) + (20 - 15) + (30 - 30) + (30 - 20) = 15.


Constraints:

1 <= nums.length <= 200
1 <= nums[i] <= 106
0 <= k <= nums.length - 1
*/

/*
Solution 2:
DP Bottom up
iterative

Time Complexity: O(nnk)
Space Complexity: O(nk)
*/
class Solution {
    func minSpaceWastedKResizing(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count

        // dp[i][k] will be min waste space for
        // 0..<i element with max k resize operations
        var dp = Array(
            repeating: Array(repeating: 0, count: k+1),
            count: n
        )

        var total = 0
        var maxEle = 0
        for i in stride(from: n-1, through: 0, by: -1) {
            maxEle = max(maxEle, nums[i])
            total += nums[i]
            // dp[i][0] means no resize, pick maxEle for remaining
            dp[i][0] = maxEle * (n-i) - total
        }

        if k == 0 { return dp[0][0] }

        for k1 in 1...k {
            for i in stride(from: n-1, through: 0, by: -1) {
                dp[i][k1] = dp[i][k1-1]
                maxEle = 0
                total = 0
                if i+1 < n {
                    for j in (i+1)..<n {
                        maxEle = max(maxEle, nums[j-1])
                        total += nums[j-1]
                        dp[i][k1] = min(
                            dp[i][k1],
                            dp[j][k1-1] + maxEle * (j-i) - total
                        )
                    }
                }
            }
        }
        return dp[0][k]
    }
}

/*
Solution 1:
DP
top down
recursively check possible case

dp[0][k] will be min waste space for 0..<n elements with max k resize operations

dp[i][k] = min(
    dp[i][k],
    min value for j in i..<n, dp[j][k-1] + ( waste space between i to j)
)

waste space between i to j is:
(maxEle between i...j) * (j-i+1) - sum of nums[i...j]

Time Complexity: O(n*n*k)
Space Complexity: O(nk)
*/
class Solution {
    func minSpaceWastedKResizing(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count

        // dp[0][k] means the min waste space
        // with 0..<n numbers and k max resize operations
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: k+1),
            count: n
        )
        return check(0, k, n, &dp, nums)
    }

    let maxValue = Int(1e6 * 200)
    // return min space when
    // resize index..<n element at most k times
    func check(_ index: Int, _ k: Int, _ n: Int,
               _ dp: inout [[Int?]], _ nums: [Int]) -> Int {
        if index == n { return 0 }
        if k == -1 { return maxValue }
        if let val = dp[index][k] {
            return val
        }

        var val = maxValue
        var maxNum = nums[index]
        var total = 0
        for i in index..<n {
            maxNum = max(maxNum, nums[i])
            total += nums[i]

            // resize to maxNum
            let waste = maxNum*(i-index+1) - total
            val = min(val, waste + check(i+1, k-1, n, &dp, nums))
        }
        dp[index][k] = val
        return val
    }
}