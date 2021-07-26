/*
You are given an integer array nums​​​ and an integer k. You are asked to distribute this array into k subsets of equal size such that there are no two equal elements in the same subset.

A subset's incompatibility is the difference between the maximum and minimum elements in that array.

Return the minimum possible sum of incompatibilities of the k subsets after distributing the array optimally, or return -1 if it is not possible.

A subset is a group integers that appear in the array with no particular order.



Example 1:

Input: nums = [1,2,1,4], k = 2
Output: 4
Explanation: The optimal distribution of subsets is [1,2] and [1,4].
The incompatibility is (2-1) + (4-1) = 4.
Note that [1,1] and [2,4] would result in a smaller sum, but the first subset contains 2 equal elements.
Example 2:

Input: nums = [6,3,8,1,3,1,2,2], k = 4
Output: 6
Explanation: The optimal distribution of subsets is [1,2], [2,3], [6,8], and [1,3].
The incompatibility is (2-1) + (3-2) + (8-6) + (3-1) = 6.
Example 3:

Input: nums = [5,3,3,6,3,3], k = 3
Output: -1
Explanation: It is impossible to distribute nums into 3 subsets where no two elements are equal in the same subset.


Constraints:

1 <= k <= nums.length <= 16
nums.length is divisible by k
1 <= nums[i] <= nums.length
*/

/*
Solution 1:
TLE
*/
class Solution {
    func minimumIncompatibility(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums.sorted()

        // var nums = nums.sorted()
        let n = nums.count
        let size = n / k
        if size == 1 { return 0 }

        var limit = 15 * k

        var dp = Array(
            repeating: Array(repeating: limit, count: n),
            count: 1<<n
        )

        for i in 0..<n {
            dp[1<<i][i] = 0
        }

        for mask in 0..<(1<<n) {
            var nz = [Int]()
            for i in 0..<n {
                if (mask & (1<<i)) != 0 {
                    nz.append(i)
                }
            }

            let nzc = nz.count
            if nzc % size == 1 {
                //neib is the mask we get after one of its 1s is set to 0

                //neib has nz[j]th bit set to 0
                for j in 0..<nzc {
                    //neib has at nz[k]th bit as the last bit set to 1
                    for k in 0..<nzc {
                        if k != j {
                            //after nz[j]th bit is set to 1, neib becomes mask
                            dp[mask][nz[j]] = min(
                                dp[mask][nz[j]],
                                dp[mask ^ (1<<nz[j])][nz[k]]
                            )
                        }
                    }
                }
            } else {
                // neib has nz[j]th bit set to 0
                for j in 0..<nzc {
                    //neib has at nz[k]th bit as the last bit set to 1
                    for k in 0..<j {
                        if nums[nz[j]] != nums[nz[k]] {
                            //after nz[j]th bit is set to 1, neib becomes mask
                            dp[mask][nz[j]] = min(
                                dp[mask][nz[j]],
                                dp[mask ^ (1<<nz[j])][nz[k]] - nums[nz[k]] + nums[nz[j]]
                            )
                        }
                    }
                }
            }
        }

        // print(dp.last)
        var res = dp.last?.min() ?? Int.max
        return res == limit ? -1 : res
    }
}