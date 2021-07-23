/*
Given a 0-indexed integer array nums, return true if it can be made strictly increasing after removing exactly one element, or false otherwise. If the array is already strictly increasing, return true.

The array nums is strictly increasing if nums[i - 1] < nums[i] for each index (1 <= i < nums.length).



Example 1:

Input: nums = [1,2,10,5,7]
Output: true
Explanation: By removing 10 at index 2 from nums, it becomes [1,2,5,7].
[1,2,5,7] is strictly increasing, so return true.
Example 2:

Input: nums = [2,3,1,2]
Output: false
Explanation:
[3,1,2] is the result of removing the element at index 0.
[2,1,2] is the result of removing the element at index 1.
[2,3,2] is the result of removing the element at index 2.
[2,3,1] is the result of removing the element at index 3.
No resulting array is strictly increasing, so return false.
Example 3:

Input: nums = [1,1,1]
Output: false
Explanation: The result of removing any element is [1,1].
[1,1] is not strictly increasing, so return false.
Example 4:

Input: nums = [1,2,3]
Output: true
Explanation: [1,2,3] is already strictly increasing, so return true.


Constraints:

2 <= nums.length <= 1000
1 <= nums[i] <= 1000

*/

/*
Solution 1:

iterate all array,
once find decreasing i-1, i,
if previous already successfully remove one element, return false, because we can only remove one element from array
try remove i-1 th element or ith element,
if neither of removing them cannot make array strictly increasing, return false

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func canBeIncreasing(_ nums: [Int]) -> Bool {
        let n = nums.count

        var isFinded = false
        var i = 1
        while i < n {
            defer { i += 1 }

            if nums[i] > nums[i-1] {
                continue
            } else {
                if isFinded { return false }

                // try if remove i-1 or i can make array strictly increasing
                if (i == 1 || i >= 2 && nums[i-2] < nums[i]),
                (i == n-1 || (i < n-1 && nums[i] < nums[i+1])) {
                    // remove i-1 can make array strictly increasing
                    isFinded = true
                }
                if isFinded { continue }
                if i == n-1 || (i < n-1 && nums[i-1] < nums[i+1]) {
                    isFinded = true
                }

                // either remove i-1 or i cannot make array strictly increasing
                guard isFinded else { return false }
            }
        }

        return true
    }
}