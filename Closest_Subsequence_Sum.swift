/*
You are given an integer array nums and an integer goal.

You want to choose a subsequence of nums such that the sum of its elements is the closest possible to goal. That is, if the sum of the subsequence's elements is sum, then you want to minimize the absolute difference abs(sum - goal).

Return the minimum possible value of abs(sum - goal).

Note that a subsequence of an array is an array formed by removing some elements (possibly all or none) of the original array.



Example 1:

Input: nums = [5,-7,3,5], goal = 6
Output: 0
Explanation: Choose the whole array as a subsequence, with a sum of 6.
This is equal to the goal, so the absolute difference is 0.
Example 2:

Input: nums = [7,-9,15,-2], goal = -5
Output: 1
Explanation: Choose the subsequence [7,-9,-2], with a sum of -4.
The absolute difference is abs(-4 - (-5)) = abs(1) = 1, which is the minimum.
Example 3:

Input: nums = [1,2,3], goal = -7
Output: 7


Constraints:

1 <= nums.length <= 40
-107 <= nums[i] <= 107
-109 <= goal <= 109
*/

/*
Solution 1:
Idea:
divide into 2 equal size subset first
dfs find all possible sums in each subset
for second subset, sort it for later binary search
for first sum subset, for each val, find if there is a (goal-val) in sumSet2 which can shorten difference,

Time Complexity: O(2^(n/2) + 2^(n/2) * log(n/2))
Space Complexity: O(n/2)
*/
class Solution {
    func minAbsDifference(_ nums: [Int], _ goal: Int) -> Int {
        let n = nums.count

        var nums = nums.sorted()

        var sumSet1 = Set<Int>()
        var sumSet2 = Set<Int>()

        dfs(0, 0, Array(nums[..<(n/2)]), &sumSet1)
        dfs(0, 0, Array(nums[(n/2)...]), &sumSet2)

        var arr2 = sumSet2.sorted()
        var diff = Int.max

        for s in sumSet1 {
            let remain = goal - s

            let index = binarySearch(arr2, remain)
            if index < arr2.count {
                diff = min(diff, abs(arr2[index] - remain))
            }
            if index > 0 {
                diff = min(diff, abs(arr2[index-1] - remain))
            }
        }

        return diff
    }

    // return index where we can left insert target
    func binarySearch(_ arr: [Int], _ target: Int) -> Int {
        if arr.isEmpty { return 0 }

        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }
        return arr[left] < target ? left+1 : left
    }

    // generate all possible sums of subsequences
    func dfs(_ i: Int, _ cur: Int, _ arr: [Int], _ sumSet: inout Set<Int>) {
        if i == arr.count {
            sumSet.insert(cur)
            return
        }
        dfs(i+1, cur, arr, &sumSet)
        dfs(i+1, cur+arr[i], arr, &sumSet)
    }
}