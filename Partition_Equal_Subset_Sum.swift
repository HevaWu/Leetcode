/*
Given a non-empty array nums containing only positive integers, find if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

 

Example 1:

Input: nums = [1,5,11,5]
Output: true
Explanation: The array can be partitioned as [1, 5, 5] and [11].
Example 2:

Input: nums = [1,2,3,5]
Output: false
Explanation: The array cannot be partitioned into equal sum subsets.
 

Constraints:

1 <= nums.length <= 200
1 <= nums[i] <= 100
*/

/*
Solution 4:
optimize solution 2 by using 1 row DP

Time Complexity: O(n * (sum/2))
Space Complexity: O(sum/2)
*/
class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        var sum = nums.reduce(into: 0) { res, next in
            res += next
        }
        
        if sum%2 != 0 { return false }
        
        sum /= 2

        var dp = Array(repeating: false, count: sum+1)
        dp[0] = true
        
        for i in 1...n {
            for j in stride(from: sum, through: 0, by: -1) {
                if j - nums[i-1] >= 0 {
                    dp[j] = dp[j] || dp[j-nums[i-1]]
                }
            }
        }
        
        return dp[sum]
    }
}

/*
Solution 3:
optimize solution 2

Time Complexity: O(n * (sum/2))
Space Complexity: O(2 * (sum/2))
*/
class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        var sum = nums.reduce(into: 0) { res, next in
            res += next
        }
        
        if sum%2 != 0 { return false }
        
        sum /= 2
        
        var prev = Array(repeating: false, count: sum+1)
        var cur = Array(repeating: false, count: sum+1)
        
        prev[0] = true
        
        for i in 1...n {
            for j in 0...sum {
                if j - nums[i-1] >= 0 {
                    cur[j] = (prev[j] || prev[j-nums[i-1]])
                } else {
                    cur[j] = prev[j]
                }
            }
            // update prev
            prev = cur
        }
        
        return cur[sum]
    }
}

/*
Solution 2:
DP

find if we can get some elements whose sum is sum/2

Time Complexity: O(n*(sum/2))
Space Complexity: O(n*(sum/2))
*/
class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        var sum = nums.reduce(into: 0) { res, next in
            res += next
        }
        
        if sum%2 != 0 { return false }
        
        sum /= 2
        
        // dp[i][j]
        // if sum j can be gotten from first i elements
        var dp = Array(repeating: Array(repeating: false, count: sum+1),
                       count: n+1)
        dp[0][0] = true
        
        for i in 1...n {
            dp[i][0] = true
        }
        
        for i in 1...n {
            for j in 1...sum {
                dp[i][j] = dp[i-1][j]
                if j >= nums[i-1] {
                    dp[i][j] = (dp[i][j] || dp[i-1][j-nums[i-1]])
                }
            }
        }
        
        return dp[n][sum]
    }
}

/*
Solution 1:
backTrack

Time Limit exceeded

for each number, we can select pick it or not

Time Complexity: O(2^n)
Space Complexity: O(1)
*/
class Solution {
    func canPartition(_ nums: [Int]) -> Bool {
        let n = nums.count
        var sum = nums.reduce(into: 0) { res, next in
            res += next
        }
        
        if sum%2 != 0 { return false }
        
        sum /= 2
        
        var nums = nums.sorted()
        
        func backTrack(_ target: Int, _ index: Int) -> Bool {
            if index >= n || target < nums[index] { return false }
            if nums[index] == target { return true }
            return backTrack(target, index+1) || backTrack(target-nums[index], index+1)
        }
        
        return backTrack(sum, 0)
    }
}