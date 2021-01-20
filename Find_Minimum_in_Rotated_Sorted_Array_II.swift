/*
Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e.,  [0,1,2,4,5,6,7] might become  [4,5,6,7,0,1,2]).

Find the minimum element.

The array may contain duplicates.

Example 1:

Input: [1,3,5]
Output: 1
Example 2:

Input: [2,2,2,0,1]
Output: 0
Note:

This is a follow up problem to Find Minimum in Rotated Sorted Array.
Would allow duplicates affect the run-time complexity? How and why?
*/

/*
Solution 1:
Binary Search

use left < right
- add == checking, if == , right -= 1
- if nums[mid] < nums[right], right = mid
- else left = mid+1

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func findMin(_ nums: [Int]) -> Int {
        let n = nums.count
        var left = 0
        var right = n-1
        while left < right {
            let mid = left + (right-left)/2

			// add == checking for avoid duplicate element
            if nums[mid] == nums[right] {
                right -= 1
            } else if nums[mid] < nums[right] {
                right = mid
            } else {
                left = mid+1
            }
        }
        
        return nums[left]
    }
}