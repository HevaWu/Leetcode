/*
Given an integer array nums, return the number of longest increasing subsequences.

Notice that the sequence has to be strictly increasing.



Example 1:

Input: nums = [1,3,5,4,7]
Output: 2
Explanation: The two longest increasing subsequences are [1, 3, 4, 7] and [1, 3, 5, 7].
Example 2:

Input: nums = [2,2,2,2,2]
Output: 5
Explanation: The length of longest continuous increasing subsequence is 1, and there are 5 subsequences' length is 1, so output 5.



Constraints:

1 <= nums.length <= 2000
-106 <= nums[i] <= 106

*/

/*
Solution 1:
DP

dp[i] -> [(max step until nums[i], how many way get this step)]

For every i < j with A[i] < A[j], we might append A[j] to a longest subsequence ending at A[i]. It means that we have demonstrated count[i] subsequences of length length[i] + 1.

Now, if those sequences are longer than length[j], then we know we have count[i] sequences of this length. If these sequences are equal in length to length[j], then we know that there are now count[i] additional sequences to be counted of that length (ie. count[j] += count[i]).

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func findNumberOfLIS(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return 1 }

        // dp[i] -> [(max step until nums[i], how many way get this step)]
        var dp = Array(repeating: (step: 1, count: 1), count: n)
        var longest = 1

        for i in 0..<n {
            for j in 0..<i {
                if nums[i] > nums[j] {
                    let temp = dp[j].step+1
                    if temp == dp[i].step {
                        dp[i].count += dp[j].count
                    } else if temp > dp[i].step {
                        dp[i] = (temp, dp[j].count)
                    }
                }
            }
            longest = max(longest, dp[i].step)
        }
        // print(dp)

        var count = 0
        for i in 0..<n {
            count += (dp[i].step == longest ? dp[i].count : 0)
        }
        return count
    }
}