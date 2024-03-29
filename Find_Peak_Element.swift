/*
A peak element is an element that is strictly greater than its neighbors.

Given an integer array nums, find a peak element, and return its index. If the array contains multiple peaks, return the index to any of the peaks.

You may imagine that nums[-1] = nums[n] = -∞.



Example 1:

Input: nums = [1,2,3,1]
Output: 2
Explanation: 3 is a peak element and your function should return the index number 2.
Example 2:

Input: nums = [1,2,1,3,5,6,4]
Output: 5
Explanation: Your function can return either index number 1 where the peak element is 2, or index number 5 where the peak element is 6.


Constraints:

1 <= nums.length <= 1000
-231 <= nums[i] <= 231 - 1
nums[i] != nums[i + 1] for all valid i.


Follow up: Could you implement a solution with logarithmic complexity?
*/

/*
Solution 2:
binary search

use left+1 < right
- right = mid
- left = mid
- return nums[left] > nums[right] ? left : right

Time Complexity: O(log n)
Space Complexity: O(1)
*/
class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        if nums.count <= 1 { return 0 }
        var left = 0
        var right = nums.count - 1
        while left+1 < right {
            let mid = left + (right-left)/2
            if nums[mid] > nums[mid+1] {
                right = mid
            } else {
                left = mid
            }
        }

        return nums[left] > nums[right] ? left : right
    }
}

/*
Solution 1:
Binary search

use left < right
- right = mid
- left = mid+1
- return left

Time Complexity: O(log n)
Space Complexity: O(1)
*/
class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        if nums.count <= 1 { return 0 }
        var left = 0
        var right = nums.count - 1
        while left < right {
            let mid = left + (right-left)/2
			// compare mid & mid+1 here
            if nums[mid] > nums[mid+1] {
                right = mid
            } else {
                left = mid+1
            }
        }

        return left
    }
}

/*
one more binary search solution writing way
*/
class Solution {
    func findPeakElement(_ nums: [Int]) -> Int {
        let n = nums.count

        var left = 0
        var right = n-1
        while left <= right {
            let mid = left + (right-left)/2
            if ( mid == 0
                || (mid > 0 && nums[mid] > nums[mid-1]))
            && ( mid == n-1
                || (mid+1 < n && nums[mid] > nums[mid+1])) {
                return mid
            }

            if mid > 0 && nums[mid] < nums[mid-1] {
                right = mid-1
            } else if mid+1 < n && nums[mid] < nums[mid+1] {
                left = mid+1
            }
        }
        return -1
    }
}