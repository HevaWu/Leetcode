/*
Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.

If target is not found in the array, return [-1, -1].

Follow up: Could you write an algorithm with O(log n) runtime complexity?

 

Example 1:

Input: nums = [5,7,7,8,8,10], target = 8
Output: [3,4]
Example 2:

Input: nums = [5,7,7,8,8,10], target = 6
Output: [-1,-1]
Example 3:

Input: nums = [], target = 0
Output: [-1,-1]
 

Constraints:

0 <= nums.length <= 105
-109 <= nums[i] <= 109
nums is a non-decreasing array.
-109 <= target <= 109
*/

/*
Solution 3
another binary search

use left < right
if (isLeft && nums[mid] < target) || (!isLeft && nums[mid] <= target) {
    left = mid+1
} else {
    right = mid
}
return nums[left] == target 
        ? left 
        : (left > 0 && nums[left-1] == target 
           ? left-1 
           : -1)
*/
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.isEmpty { return [-1, -1] }
        
        let lp = findTarget(isLeft: true, nums, target)
        if lp == -1 {
            return [-1, -1]
        }
        
        let rp = findTarget(isLeft: false, nums, target)
        return [lp, rp]
    }
    
    func findTarget(isLeft: Bool, _ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count-1
        while left < right {
            let mid = left + (right-left)/2
            if (isLeft && nums[mid] < target) || (!isLeft && nums[mid] <= target) {
                left = mid+1
            } else {
                right = mid
            }
        }
        // print(nums[left], left)
        return nums[left] == target 
        ? left 
        : (left > 0 && nums[left-1] == target 
           ? left-1 
           : -1)
    }
}

/*
Solution 1:
Binary search

use left + 1 < right 
control isLeft by:
if nums[mid] > target || (isLeft && nums[mid] == target) {
	right = mid
} else {
	left = mid
}
if nums[left] == target { return left }
if nums[right] == target { return right }

Time Complexity: O(log n)
Space Complexity: O(1)
*/
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.isEmpty { return [-1, -1] }
        
        func findTarget(_ isLeft: Bool) -> Int {
            var left = 0
            var right = nums.count-1
            
            // use left+1 < right checking at here
            while left + 1 < right {
                let mid = left + (right - left) / 2
                if nums[mid] > target || (isLeft && nums[mid] == target) {
                    right = mid
                } else {
                    left = mid
                }
            }
            
            // left+1 == right now
            if nums[left] == target { return left }
            if nums[right] == target { return right }
            return -1
        }
        
        let lp = findTarget(true)
        if lp == -1 {
            return [-1, -1]
        }
        
        let rp = findTarget(false)
        return [lp, rp]
    }
}

/*
Solution 1
binary search

use left < right
- control isLeft checking at: 
if nums[pivot] > target || (isLeft && nums[pivot] == target) {
	right = pivot
} else {
	left = pivot + 1
}
return left

for right point, the result should -1

Time Complexity: O(log n)
Space Complexity: O(1)
*/
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var lp = check(nums, target, true)
        if lp == nums.count || nums[lp] != target {
            return [-1, -1]
        }

		// -1 for right side
        var rp = check(nums, target, false)-1
        return [lp, rp]
    }
    
    func check(_ nums: [Int], _ target: Int, _ isLeft: Bool) -> Int {
        var left = 0
        var right = nums.count
        var pivot = 0
        while left < right {
            pivot = (left+right)/2
            if nums[pivot] > target || 
            (isLeft && nums[pivot] == target) {
                right = pivot
            } else {
                left = pivot + 1
            }
        }
        return left
    }
}