/*
A sequence is special if it consists of a positive number of 0s, followed by a positive number of 1s, then a positive number of 2s.

For example, [0,1,2] and [0,0,1,1,1,2] are special.
In contrast, [2,1,0], [1], and [0,1,2,0] are not special.
Given an array nums (consisting of only integers 0, 1, and 2), return the number of different subsequences that are special. Since the answer may be very large, return it modulo 109 + 7.

A subsequence of an array is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements. Two subsequences are different if the set of indices chosen are different.



Example 1:

Input: nums = [0,1,2,2]
Output: 3
Explanation: The special subsequences are [0,1,2,2], [0,1,2,2], and [0,1,2,2].
Example 2:

Input: nums = [2,2,0,0]
Output: 0
Explanation: There are no special subsequences in [2,2,0,0].
Example 3:

Input: nums = [0,1,2,0,1,2]
Output: 7
Explanation: The special subsequences are:
- [0,1,2,0,1,2]
- [0,1,2,0,1,2]
- [0,1,2,0,1,2]
- [0,1,2,0,1,2]
- [0,1,2,0,1,2]
- [0,1,2,0,1,2]
- [0,1,2,0,1,2]


Constraints:

1 <= nums.length <= 105
0 <= nums[i] <= 2

*/

/*
Solution 1:
DP

Define dp[num] as the number of special subsequences ending with num, and presum[num+1] as the sum of dp[num] up to the current index. Here we added a padding of presum[0] = 1 to make the dp transition cleaner.

At index i, we only have two cases:

creating a new special subsequence ending with nums[i]
e.g. 0, 1, 2 -> 0, 1, 2, 2
extend an existing special subsequence ending with nums[i]
e.g. 0, 1, 2 -> 0, 1, 2, 2
Therefore, the dp transition function is dp[num] = presum[num] + presum[num+1] for each num in nums.

Take nums = [0,1,2,2] as an example. At index i = 2, we have dp = [1,1,1] and presum = [1,1,1,1].

Now we move to i = 3 and num = nums[3] = 2. presum[2] means the number of 0,1-special subsequence prior to the current index (case 1), and presum[3] means the number of special subsequence (case 2). Thus, at index i = 3 we have dp[2] = 1 + 1 = 2.

*/
class Solution {
    func countSpecialSubsequences(_ nums: [Int]) -> Int {
        let n = nums.count
        let mod = Int(1e9 + 7)

        var dp = Array(repeating: 0, count: 3)
        var presum = Array(repeating: 0, count: 4)
        presum[0] = 1

        for num in nums {
            dp[num] = (presum[num] + presum[num+1]) % mod
            presum[num+1] = (presum[num+1] + dp[num]) % mod
        }

        return presum[3]
    }
}