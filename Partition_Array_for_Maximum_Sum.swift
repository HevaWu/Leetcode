/*
Given an integer array arr, you should partition the array into (contiguous) subarrays of length at most k. After partitioning, each subarray has their values changed to become the maximum value of that subarray.

Return the largest sum of the given array after partitioning.



Example 1:

Input: arr = [1,15,7,9,2,5,10], k = 3
Output: 84
Explanation: arr becomes [15,15,15,9,10,10,10]
Example 2:

Input: arr = [1,4,1,5,7,3,6,1,9,9,3], k = 4
Output: 83
Example 3:

Input: arr = [1], k = 1
Output: 1


Constraints:

1 <= arr.length <= 500
0 <= arr[i] <= 109
1 <= k <= arr.length
*/

/*
Solution 1:
DP

dp[i] will be answer of maxSum for arr[0..<i]
dp[i] = dp[i-j] + max(arr[i-1]...arr[i-k]) * j

Time Complexity: O(nk)
Space Complexity: O(n)
*/
class Solution {
    func maxSumAfterPartitioning(_ arr: [Int], _ k: Int) -> Int {
        let n = arr.count
        var dp = Array(repeating: 0, count: n+1)

        var preMax = 0
        for i in 1...n {
            preMax = 0
            for j in 1...min(i, k) {
                preMax = max(preMax, arr[i-j])
                dp[i] = max(dp[i], dp[i-j] + preMax*j)
            }
        }
        return dp[n]
    }
}