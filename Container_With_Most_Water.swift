// Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
// Note: You may not slant the container and n is at least 2.
// The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
// Example:
// Input: [1,8,6,2,5,4,8,3,7]
// Output: 49

// Solution 1: Brute Force
// Simply consider area for every possible pair, and find out maximum one
// Time Complexity: O(n^2)
// Space Complexity: O(1) 
class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var volume: Int = 0
        let n = height.count
        for i in 0..<n {
            for j in i..<n {
                volume = max(volume, min(height[i], height[j]) * (j - i))
            }
        }
        return volume
    }
}

// Solution 2: two pointer
// We take two pointers, one at the beginning and one at the end of the array constituting the length of the lines. Futher, we maintain a variable \text{maxarea}maxarea to store the maximum area obtained till now. At every step, we find out the area formed between them, update \text{maxarea}maxarea and move the pointer pointing to the shorter line towards the other end by one step.
// Initially we consider the area constituting the exterior most lines. Now, to maximize the area, we need to consider the area between the lines of larger lengths. If we try to move the pointer at the longer line inwards, we won't gain any increase in area, since it is limited by the shorter line. But moving the shorter line's pointer could turn out to be beneficial, as per the same argument, despite the reduction in the width. This is done since a relatively longer line obtained by moving the shorter line's pointer might overcome the reduction in area caused by the width reduction
//
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func maxArea(_ height: [Int]) -> Int {        
        var leftNode: Int = 0
        var rightNode: Int = height.count-1
        var area = 0
        while leftNode < rightNode {
            area = max(area, (rightNode - leftNode) * min(height[leftNode], height[rightNode]))
            
            // update leftNode & rightNode, update the shorter one since the next might larger than it
            if height[leftNode] < height[rightNode] {
                leftNode += 1
            } else {
                rightNode -= 1   
            }
        }
        return area
    }
}