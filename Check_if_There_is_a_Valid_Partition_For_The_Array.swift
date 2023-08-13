/*
You are given a 0-indexed integer array nums. You have to partition the array into one or more contiguous subarrays.

We call a partition of the array valid if each of the obtained subarrays satisfies one of the following conditions:

The subarray consists of exactly 2 equal elements. For example, the subarray [2,2] is good.
The subarray consists of exactly 3 equal elements. For example, the subarray [4,4,4] is good.
The subarray consists of exactly 3 consecutive increasing elements, that is, the difference between adjacent elements is 1. For example, the subarray [3,4,5] is good, but the subarray [1,3,5] is not.
Return true if the array has at least one valid partition. Otherwise, return false.



Example 1:

Input: nums = [4,4,4,5,6]
Output: true
Explanation: The array can be partitioned into the subarrays [4,4] and [4,5,6].
This partition is valid, so we return true.
Example 2:

Input: nums = [1,1,1,2]
Output: false
Explanation: There is no valid partition for this array.


Constraints:

2 <= nums.length <= 105
1 <= nums[i] <= 106
*/

/*
Solution 1:
iterate array to check contiguous valid partition
dp[i] = (dp[i-2] && val2) || (dp[i-1] && val3)
val2 is the possible partition for 2 elements nums[i],nums[i-1]
val3 is the possible partition for 3 elements nums[i],nums[i-1],nums[i-2]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func validPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        var dp = Array(repeating: false, count: n)
        if n == 1 { return false }
        // dp[i] indicate if nums[0...i] can have contiguous valid partition
        dp[1] = (nums[0] == nums[1])
        if n == 2 {
            return dp[1]
        }
        dp[2] = (nums[0] == nums[1] && nums[1] == nums[2]) || (nums[1]-nums[0]==1 && nums[2]-nums[1] == 1)
        if n == 3 {
            return dp[2]
        }

        for i in 3..<n {
            // check 2 elements subarray
            let val2 = nums[i] == nums[i-1]
            // check 3 elements subarray
            let val3 = (nums[i] == nums[i-1] && nums[i-1] == nums[i-2]) || (nums[i]-nums[i-1]==1 && nums[i-1]-nums[i-2]==1)
            dp[i] = (dp[i-2] && val2) || (dp[i-3] && val3)
        }
        // print(dp)
        return dp[n-1]
    }
}
