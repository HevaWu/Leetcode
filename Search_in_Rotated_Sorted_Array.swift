/*
You are given an integer array nums sorted in ascending order (with distinct values), and an integer target.

Suppose that nums is rotated at some pivot unknown to you beforehand (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

If target is found in the array return its index, otherwise, return -1.

 

Example 1:

Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4
Example 2:

Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1
Example 3:

Input: nums = [1], target = 0
Output: -1
 

Constraints:

1 <= nums.length <= 5000
-104 <= nums[i] <= 104
All values of nums are unique.
nums is guaranteed to be rotated at some pivot.
-104 <= target <= 104
*/

/*
Solution 2:
Tricky binary search
If target is let's say 14, then we adjust nums to this, where "inf" means infinity:
[12, 13, 14, 15, 16, 17, 18, 19, inf, inf, inf, inf, inf, inf, inf, inf, inf, inf, inf, inf]

If target is let's say 7, then we adjust nums to this:
[-inf, -inf, -inf, -inf, -inf, -inf, -inf, -inf, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

TimeComplexity: O(logn)
SpaceComplexity: O(1)
*/
class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count-1
        while left <= right {
            let mid = left + (right-left)/2
            
            let num = (nums[mid] < nums[0]) == (target < nums[0]) 
             ? nums[mid]
             : target < nums[0] ? Int.min : Int.max
            
            if num == target {
                return mid
            } else if num > target {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return -1
    }
}

/*
Solution 1:
Binary search

if nums[left] <= target < nums[mid], right = mid-1, else, left = mid+1
if nums[mid] < target <= nums[right], left = mid+1, else, right = mid-1

TimeComplexity: O(logn)
SpaceComplexity: O(1)
*/
class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count-1
        while left <= right {
            let mid = left + (right-left)/2
            if nums[mid] == target {
                return mid
            }
            
            if nums[left] <= nums[mid] {
                if nums[left] <= target, nums[mid] > target {
                    // nums[left] < target < nums[mid]
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                if nums[right] >= target, nums[mid] < target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        return -1
    }
}