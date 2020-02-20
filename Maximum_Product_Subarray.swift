// Given an integer array nums, find the contiguous subarray within an array (containing at least one number) which has the largest product.

// Example 1:

// Input: [2,3,-2,4]
// Output: 6
// Explanation: [2,3] has the largest product 6.
// Example 2:

// Input: [-2,0,-1]
// Output: 0
// Explanation: The result cannot be 2, because [-2,-1] is not a subarray.

// Solution 2: DP
// 2 pointer find largest product
// imax <- until i, max product
// imin <- unitl i, min product
// if num[i] < 0, for finding largest product one, swap them
// keep latest imax & imin
// everytime update product
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var product = nums[0]
        var imax = product
        var imin = product
        for i in 1..<nums.count {
            if nums[i] < 0 {
                // swap min & max
                let temp = imax
                imax = imin
                imin = temp
            }
            
            imax = max(nums[i], nums[i]*imax)
            imin = min(nums[i], nums[i]*imin)
            
            product = max(product, imax)
        }
        return product
    }
}