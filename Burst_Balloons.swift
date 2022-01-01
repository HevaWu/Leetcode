/*
Given n balloons, indexed from 0 to n-1. Each balloon is painted with a number on it represented by array nums. You are asked to burst all the balloons. If the you burst balloon i you will get nums[left] * nums[i] * nums[right] coins. Here left and right are adjacent indices of i. After the burst, the left and right then becomes adjacent.

Find the maximum coins you can collect by bursting the balloons wisely.

Note:

You may imagine nums[-1] = nums[n] = 1. They are not real therefore you can not burst them.
0 ≤ n ≤ 500, 0 ≤ nums[i] ≤ 100
Example:

Input: [3,1,5,8]
Output: 167
Explanation: nums = [3,1,5,8] --> [3,5,8] -->   [3,8]   -->  [8]  --> []
             coins =  3*1*5      +  3*5*8    +  1*3*8      + 1*8*1   = 167
*/

/*
Solution 1: DP
instead of divide the problem by the first balloon to burst, we divide the problem by the last balloon to burst.

For the first we have nums[i-1]*nums[i]*nums[i+1] for the last we have nums[-1]*nums[i]*nums[n].

Note that we put 2 balloons with 1 as boundaries and also burst all the zero balloons in the first round since they won't give any coins.
The algorithm runs in O(n^3) which can be easily seen from the 3 loops in dp solution.

dp[i][j]: coins obtained from bursting all the balloons between index i and j (not including i or j)
dp[i][j] = max(nums[i] * nums[k] * nums[j] + dp[i][k] + dp[k][j]) (k in (i+1,j))
If k is the index of the last balloon burst in (i, j), the coins that burst will get are nums[i] * nums[k] * nums[j], and to calculate dp[i][j], we also need to add the coins obtained from bursting balloons between i and k, and between k and j, i.e., dp[i][k] and dp[k][j]

Time Complexity:
O(n^3)
*/
class Solution {
    func maxCoins(_ nums: [Int]) -> Int {
        if nums.count == 1 { return nums[0] }

        // burst all zeros firs
        var nums = nums.filter { $0 > 0 }
        nums.insert(1, at: 0)
        nums.append(1)

        let n = nums.count

        var dp = Array(repeating: Array(repeating: 0, count: n),
                       count: n)

        for size in 2..<n {
            var left = 0
            while left < n-size {
                var right = left+size

                var k = left+1
                while k < right {
                    dp[left][right] = max(dp[left][right],
                                          dp[left][k] + dp[k][right] + nums[left] * nums[k] * nums[right])
                    k += 1
                }
                left += 1
            }
        }

        return dp[0][n-1]
    }
}

/*
Solution 2:
DP

dp[i][j] max coins burst ballon in nums[i...j]
for len from 2..<n, update dp[i][j]
dp[i][j] = max(nums[i] * nums[k] * nums[j] + dp[i][k] + dp[k][j]) (k in (i+1,j))

Time Complexity: O(n^3)
Space Complexity: O(n^2)
*/
class Solution {
    func maxCoins(_ nums: [Int]) -> Int {
        var nums = nums
        nums.insert(1, at: 0)
        nums.append(1)

        let n = nums.count

        // dp[i][j] max coins burst ballon in nums[i+1..<j]
        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for len in 2..<n {
            for j in len..<n {
                let i = j-len

                var k = i+1
                while k < j {
                   dp[i][j] = max(
                       dp[i][j],
                       dp[i][k] + dp[k][j] + nums[i]*nums[k]*nums[j]
                    )
                    k += 1
                }
            }
            // print(dp)
        }

        return dp[0][n-1]
    }
}
