'''
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.


The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

Example:

Input: [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6
'''
'''
Solution 1: two pointer
Set 2 pointer at left & right side, always keep maxL & maxR to help calculating the area

TimeComplexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def trap(self, height: List[int]) -> int:
        l = 0
        r = len(height) - 1

        maxL = height[l]
        maxR = height[r]

        water = 0
        while l <= r:
            if height[l] <= height[r]:
                if height[l] >= maxL:
                    maxL = height[l]
                else:
                    water += maxL - height[l]
                l += 1
            else:
                if height[r] >= maxR:
                    maxR = height[r]
                else:
                    water += maxR - height[r]
                r -= 1
        return water
