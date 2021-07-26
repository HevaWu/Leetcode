/*
You are given an integer array nums.

You should move each element of nums into one of the two arrays A and B such that A and B are non-empty, and average(A) == average(B).

Return true if it is possible to achieve that and false otherwise.

Note that for an array arr, average(arr) is the sum of all the elements of arr over the length of arr.



Example 1:

Input: nums = [1,2,3,4,5,6,7,8]
Output: true
Explanation: We can split the array into [1,4,5,8] and [2,3,6,7], and both of them have an average of 4.5.
Example 2:

Input: nums = [3,1]
Output: false


Constraints:

1 <= nums.length <= 30
0 <= nums[i] <= 104
*/

/*
Solution 2:
NP
totalSum/n = Asum/k = Bsum/(n-k), where k = A.size() and 1 <= k <= n/2;
Asum = totalSum*k/n, which is an integer. So we have totalSum*k%n == 0;

like knapsack problem. (Note: 1 <= k <= n/2)
Next, for each valid k, simply check whether the group sum, i.e. totalSum * k / n, exists in the kth combination sum hashset.

Time Complexity: O(n^3 * m)
- m is n/2
Space Complexity: O(n)
*/
class Solution {
    func splitArraySameAverage(_ nums: [Int]) -> Bool {
        let n = nums.count
        if n == 1 { return false }

        var total = nums.reduce(into: 0) { res, next in
            res += next
        }

        var isPossible = false
        for i in 1..<n {
            if total * i % n == 0 {
                isPossible = true
            }
        }
        if !isPossible { return false }

        var dp = Array(
            repeating: Set<Int>(),
            count: n/2 + 1
        )
        dp[0].insert(0)

        for num in nums {
            for i in stride(from: n/2, through: 1, by: -1) {
                for t in dp[i-1] {
                    dp[i].insert(t + num)
                }
            }
        }

        for i in 1...(n/2) {
            if total * i % n == 0, dp[i].contains(total * i / n) {
                return true
            }
        }
        return false
        return false
    }
}

/*
Solution 1:
bitmask + DP

TLE
*/
class Solution {
    func splitArraySameAverage(_ nums: [Int]) -> Bool {
        let n = nums.count
        if n == 1 { return false }

        var total = nums.reduce(into: 0) { res, next in
            res += next
        }

        // dp[i] store [(mask, sum)],
        // i is number of elements A take,
        // mask is the taken element
        // i from 1...n-1
        // sum is sum of current taken element
        var dp = Array(
            repeating: [(mask: Int, sum: Int)](),
            count: n
        )

        // i == 1
        for k in 0..<n {
            dp[1].append((1<<k, nums[k]))
            let averageA = Double(nums[k])
            let averageB = Double(total - nums[k]) / Double(n-1)
            if averageA == averageB { return true }
        }

        for i in 2..<n {
            for (mask, sum) in dp[i-1] {
                for k in 0..<n {
                    // current mask not take kth element
                    if mask & (1<<k) == 0 {
                        let val = sum + nums[k]
                        dp[i].append((mask ^ (1<<k), val))
                        let averageA = Double(val) / Double(i)
                        let averageB = Double(total-val) / Double(n-i)
                        if averageA == averageB {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
}