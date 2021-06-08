/*
Given an integer array nums and an integer k, return true if it is possible to divide this array into k non-empty subsets whose sums are all equal.



Example 1:

Input: nums = [4,3,2,3,5,2,1], k = 4
Output: true
Explanation: It's possible to divide it into 4 subsets (5), (1, 4), (2,3), (2,3) with equal sums.
Example 2:

Input: nums = [1,2,3,4], k = 3
Output: false


Constraints:

1 <= k <= nums.length <= 16
1 <= nums[i] <= 104
The frequency of each element is in the range [1, 4].
*/

/*
Solution 1:
backtracking

Idea:
- find each single subset target
- backTrack to see if we can make k subset with each subset's sum is target
(use visited to help recording current index is already counted or not)

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func canPartitionKSubsets(_ nums: [Int], _ k: Int) -> Bool {
        var maxEle = nums[0]
        var sum = 0
        for num in nums {
            maxEle = max(maxEle, num)
            sum += num
        }

        guard sum % k == 0 && maxEle <= sum/k else { return false }
        let n = nums.count

        let target = sum / k
        var visited = Array(repeating: false, count: n)
        return check(0, n, nums, k, &visited, target, 0)
    }

    func check(_ index: Int, _ n: Int, _ nums: [Int], _ k: Int,
               _ visited: inout [Bool], _ target: Int,
               _ curSum: Int) -> Bool {
        if k == 0 { return true }

        if curSum == target {
            return check(0, n, nums, k-1, &visited, target, 0)
        }

        for i in index..<n {
            if !visited[i], curSum + nums[i] <= target {
                visited[i] = true
                if check(i+1, n, nums, k, &visited, target, curSum+nums[i]) {
                    return true
                }
                visited[i] = false
            }
        }
        return false
    }
}