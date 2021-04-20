/*
Given an array of distinct integers nums and a target integer target, return the number of possible combinations that add up to target.

The answer is guaranteed to fit in a 32-bit integer.



Example 1:

Input: nums = [1,2,3], target = 4
Output: 7
Explanation:
The possible combination ways are:
(1, 1, 1, 1)
(1, 1, 2)
(1, 2, 1)
(1, 3)
(2, 1, 1)
(2, 2)
(3, 1)
Note that different sequences are counted as different combinations.
Example 2:

Input: nums = [9], target = 3
Output: 0


Constraints:

1 <= nums.length <= 200
1 <= nums[i] <= 1000
All the elements of nums are unique.
1 <= target <= 1000


Follow up: What if negative numbers are allowed in the given array? How does it change the problem? What limitation we need to add to the question to allow negative numbers?
*/

/*
Solution 3:
use dp to help cache pre-checked target result

Time Complexity: O(target * n)
Space Complexity: O(target)
*/
class Solution3 {
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        let int32max = Int(Int32.max)

        var dp = Array(repeating: 0, count: target+1)
        dp[0] = 1
        for i in 1..<dp.count {
            for j in 0..<nums.count {
                if i - nums[j] >= 0 {
                    // % int32max for make sure result fit in a 32-bit integer
                    dp[i] = (dp[i] + dp[i-nums[j]]) % int32max
                }
            }
        }
        return dp[target]
    }
}

/*
Solution 2:
recursive

Time Limit Exceeded
*/
class Solution2 {
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        if target == 0 { return 1 }
        var res = 0
        for i in nums {
            if target - i >= 0 {
                res += combinationSum4(nums, target - i)
            }
        }
        return res
    }
}

/*
Solution 1:
BackTrack

Time Limit Exceeded
*/
class Solution1 {
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        if n == 1, nums[0] != target { return 0 }
        var res = 0
        backTrack(nums, n, target, &res)
        return res
    }

    func backTrack(_ nums: [Int], _ n: Int, _ target: Int,
                   _ res: inout Int) {
        if target == 0 {
            res += 1
            return
        }
        for i in 0..<n {
            let temp = target - nums[i]
            if temp >= 0 {
                backTrack(nums, n, temp, &res)
            }
        }
    }
}
