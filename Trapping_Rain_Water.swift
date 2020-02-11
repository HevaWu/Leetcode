// Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.


// The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

// Example:

// Input: [0,1,0,2,1,0,1,3,2,1,2,1]
// Output: 6

// Solution 1: two pointer
// Set 2 pointer at left & right side, always keep maxL & maxR to help calculating the area
// 
// TimeComplexity: O(n)
// Space Complexity: O(1)
class Solution {
    func trap(_ height: [Int]) -> Int {
        guard !height.isEmpty else { return 0 }
        
        // two pointer
        var left = 0
        var right = height.count - 1
        
        var maxL = 0
        var maxR = 0
        
        var total = 0
        
        while left <= right {
            if height[left] <= height[right] {
                // update left
                if height[left] >= maxL {
                    maxL = height[left]
                } else {
                    total += maxL - height[left]
                }
                left += 1
            } else {
                // update right
                if height[right] >= maxR {
                    maxR = height[right]
                } else {
                    total += maxR - height[right]
                }
                right -= 1
            }
        }
        return total
    }
}