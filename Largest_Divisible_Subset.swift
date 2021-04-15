/*
Given a set of distinct positive integers nums, return the largest subset answer such that every pair (answer[i], answer[j]) of elements in this subset satisfies:

answer[i] % answer[j] == 0, or
answer[j] % answer[i] == 0
If there are multiple solutions, return any of them.



Example 1:

Input: nums = [1,2,3]
Output: [1,2]
Explanation: [1,3] is also accepted.
Example 2:

Input: nums = [1,2,4,8]
Output: [1,2,4,8]


Constraints:

1 <= nums.length <= 1000
1 <= nums[i] <= 2 * 109
All the integers in nums are unique.
*/

/*
Solution 2:
optimize DP

use pre to record index of previous largest in the set

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution2 {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let n = nums.count

        var nums = nums.sorted()

        // dp[i], largest divisible subset count contains nums[i]
        var dp = Array(repeating: 1, count: n)

        // pre[i], record pre index of largest divisible set
        var pre = Array(repeating: -1, count: n)

        var maxIndex = 0
        for i in 1..<n {
            for j in 0..<i {
                if nums[i] % nums[j] == 0 {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1
                        pre[i] = j
                    }
                }
            }

            if dp[i] > dp[maxIndex] {
                maxIndex = i
            }
        }

        var maxSubset = [Int]()
        while maxIndex != -1 {
            maxSubset.append(nums[maxIndex])
            maxIndex = pre[maxIndex]
        }

        return maxSubset
    }
}

/*
Solution 1:
DP

- sort nums
- count dp[i], dp[i] -(len, sub) is largest divisible subset end with nums[i]
- maintain maxSubset

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution1 {
    func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
        let n = nums.count

        var nums = nums.sorted()

        // dp[i], largest divisible subset end with nums[i]
        var dp: [(len: Int, sub: [Int])] = Array(
            repeating: (0, []),
            count: n
        )
        dp[0] = (1, [nums[0]])

        var maxSubset = [nums[0]]
        for i in 1..<n {
            dp[i] = (1, [nums[i]])
            for j in 0..<i {
                if nums[i] % nums[j] == 0 {
                    if dp[j].len + 1 > dp[i].len {
                        dp[i] = (dp[j].len + 1, dp[j].sub+[nums[i]])
                    }
                }
            }

            if dp[i].len > maxSubset.count {
                maxSubset = dp[i].sub
            }
        }

        // print(dp)
        return maxSubset
    }
}