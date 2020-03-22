// Given an array which consists of non-negative integers and an integer m, you can split the array into m non-empty continuous subarrays. Write an algorithm to minimize the largest sum among these m subarrays.

// Note:
// If n is the length of array, assume the following constraints are satisfied:

// 1 ≤ n ≤ 1000
// 1 ≤ m ≤ min(50, n)
// Examples:

// Input:
// nums = [7,2,5,10,8]
// m = 2

// Output:
// 18

// Explanation:
// There are four ways to split nums into two subarrays.
// The best way is to split it into [7,2,5] and [10,8],
// where the largest sum among the two subarrays is only 18.

// Solution 1: DP
// Let's define f[i][j] to be the minimum largest subarray sum for splitting nums[0..i] into j parts.
// Consider the jth subarray. We can split the array from a smaller index k to i to form it. Thus f[i][j] can be derived from max(f[k][j - 1], nums[k + 1] + ... + nums[i]). For all valid index k, f[i][j] should choose the minimum value of the above formula.
// The final answer should be f[n][m], where n is the size of the array.
// For corner situations, all the invalid f[i][j] should be assigned with INFINITY, and f[0][0] should be initialized with 0.
// 
// Time complexity : O(n^2 * m). The total number of states is O(n * m)O(n∗m). To compute each state f[i][j], we need to go through the whole array to find the optimum k. This requires another O(n)O(n) loop. So the total time complexity is O(n ^ 2 * m)
// Space complexity : O(n * m)O(n∗m). The space complexity is equivalent to the number of states, which is O(n * m)O(n∗m).
class Solution {
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        let n = nums.count
        // try to find dp[n][m]
        var dp = Array(repeating: Array(repeating: Int.max, count: m+1) , count: n+1)
        
        var sub = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            sub[i+1] = sub[i] + nums[i]
        }

        dp[0][0] = 0
        for i in 1...n {
            for j in 1...m {
                for k in 0..<i {
                    dp[i][j] = min(dp[i][j], max(dp[k][j-1], sub[i]-sub[k]))
                }
            }
        }
        return dp[n][m]
    }
}

// Solution 2: binary search & greedy
// We can use Binary search to find the value x0. Keeping a value mid = (left + right) / 2. If F(mid) is false, then we will search the range [mid + 1, right]; If F(mid) is true, then we will search [left, mid - 1].
// For a given x, we can get the answer of F(x) using a greedy approach. Using an accumulator sum to store the sum of the current processing subarray and a counter cnt to count the number of existing subarrays. We will process the elements in the array one by one. For each element num, if sum + num <= x, it means we can add num to the current subarray without exceeding the limit. Otherwise, we need to make a cut here, start a new subarray with the current element num. This leads to an increment in the number of subarrays.
// After we have finished the whole process, we need to compare the value cnt to the size limit of subarrays m. If cnt <= m, it means we can find a splitting method that ensures the maximum largest subarray sum will not exceed x. Otherwise, F(x) should be false.
// 
// Time complexity : O(n * log(sum of array))O(n∗log(sumofarray)). The binary search costs O(log(sum of array))O(log(sumofarray)), where sum of array is the sum of elements in nums. For each computation of F(x), the time complexity is O(n)O(n) since we only need to go through the whole array.
// Space complexity : O(n)O(n). Same as the Brute Force approach. We only need the space to store the array.
class Solution {
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        var left = 0
        var right = 0
        let n = nums.count
        
        for num in nums {
            right += num
            if left < num {
                left = num
            }
        }
        
        while left < right {
            var mid = (left+right)/2
            
            // check if mid return true
            var temp = 0
            var count = 1
            for i in 0..<n {
                temp += nums[i]
                if temp > mid {
                    count += 1
                    temp = nums[i]
                    
                    if count > m { break }
                }
            }
            
            if count <= m {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return left
    }
}