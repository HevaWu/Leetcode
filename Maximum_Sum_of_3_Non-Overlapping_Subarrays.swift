/*
In a given array nums of positive integers, find three non-overlapping subarrays with maximum sum.

Each subarray will be of size k, and we want to maximize the sum of all 3*k entries.

Return the result as a list of indices representing the starting position of each interval (0-indexed). If there are multiple answers, return the lexicographically smallest one.

Example:

Input: [1,2,1,2,6,7,5,1], 2
Output: [0, 3, 5]
Explanation: Subarrays [1, 2], [2, 6], [7, 5] correspond to the starting indices [0, 3, 5].
We could have also taken [2, 1], but an answer of [1, 3, 5] would be lexicographically larger.


Note:

nums.length will be between 1 and 20000.
nums[i] will be between 1 and 65535.
k will be between 1 and floor(nums.length / 3).

*/

/*
Solution 1:

- build sum first, sum[i] = sum of nums[i-k+1...i]
- build left, right
  - left[z] -> first occurrence of the largest value of sum[i] on i in [0...z]
  - right[z] -> in [z...(w.count-1)]
- res is (left[j-k], j, right[j+k]) to make maximum of W[i]+W[j]+W[k]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maxSumOfThreeSubarrays(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count
        var sum = Array(repeating: 0, count: n-k+1)
        var cur = 0
        for i in 0..<n {
            cur += nums[i]
            if i >= k {
                cur -= nums[i-k]
            }
            if i >= k-1 {
                sum[i-k+1] = cur
            }
        }
        // print(sum)

        let size = sum.count
        var left = Array(repeating: 0, count: size)
        var best = 0
        for i in 0..<size {
            if sum[i] > sum[best] {
                best = i
            }
            left[i] = best
        }

        var right = Array(repeating: 0, count: size)
        best = size-1
        for i in stride(from: size-1, through: 0, by: -1) {
            if sum[i] >= sum[best] {
                best = i
            }
            right[i] = best
        }
        // print(left, right)

        var res = [-1, -1, -1]
        for j in k..<(size-k) {
            let i = left[j-k]
            let l = right[j+k]
            if res[0] == -1
            || sum[i]+sum[j]+sum[l] > sum[res[0]] + sum[res[1]] + sum[res[2]] {
                res = [i, j, l]
            }
        }
        return res
    }
}