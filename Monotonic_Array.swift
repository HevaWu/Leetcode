/*
An array is monotonic if it is either monotone increasing or monotone decreasing.

An array nums is monotone increasing if for all i <= j, nums[i] <= nums[j]. An array nums is monotone decreasing if for all i <= j, nums[i] >= nums[j].

Given an integer array nums, return true if the given array is monotonic, or false otherwise.



Example 1:

Input: nums = [1,2,2,3]
Output: true
Example 2:

Input: nums = [6,5,4,4]
Output: true
Example 3:

Input: nums = [1,3,2]
Output: false


Constraints:

1 <= nums.length <= 105
-105 <= nums[i] <= 105
*/

/*
Solution 1:
iterate array, check if it is keep increasing / decreasing

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func isMonotonic(_ nums: [Int]) -> Bool {
        let n = nums.count
        if n <= 1 { return true }
        var gap = nums[1] - nums[0]
        for i in 2..<n {
            let tmp = nums[i] - nums[i-1]
            if gap == 0 {
                gap = tmp
            } else if gap > 0 {
                if tmp < 0 { return false }
            } else {
                if tmp > 0 { return false }
            }
        }
        return true
    }
}
