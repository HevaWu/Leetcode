// Given an array of integers nums sorted in ascending order, find the starting and ending position of a given target value.

// Your algorithm's runtime complexity must be in the order of O(log n).

// If the target is not found in the array, return [-1, -1].

// Example 1:

// Input: nums = [5,7,7,8,8,10], target = 8
// Output: [3,4]
// Example 2:

// Input: nums = [5,7,7,8,8,10], target = 6
// Output: [-1,-1]

// Solution 1: binary search 2 pointer
// set left & right pointer, and use pivot to check if we find the target
// 
// Time complexity: O(logn)
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        guard !nums.isEmpty, nums.contains(target) else { return [-1, -1] }
        var left = 0
        var right = nums.count-1
        var pivot = 0
        
        while left <= right {
            pivot = (left+right)/2
            if nums[pivot] == target {
                // try to find the range
                var lp = pivot - 1
                while lp>=left, nums[lp]==target {
                    lp -= 1
                }               
                
                var rp = pivot + 1
                while rp<=right, nums[rp]==target {
                    rp += 1
                }
                
                return [lp+1, rp-1]
            } else if nums[pivot] < target {
                left = pivot + 1
            } else {
                right = pivot - 1
            }
        }
        return [-1,-1]
    }
}

// Time complexity : O(\log_{10}(n))Because binary search cuts the search space roughly in half on each iteration, there can be at most \lceil \log_{10}(n) iterations. Binary search is invoked twice, so the overall complexity is logarithmic.
// Space complexity : O(1)O(1)
// All work is done in place, so the overall memory usage is constant.
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var lp = check(nums, target, true)
        if lp == nums.count || nums[lp] != target {
            return [-1, -1]
        }
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