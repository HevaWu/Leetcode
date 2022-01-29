'''
Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.




Above is a histogram where width of each bar is 1, given height = [2,1,5,6,2,3].




The largest rectangle is shown in the shaded area, which has area = 10 unit.



Example:

Input: [2,1,5,6,2,3]
Output: 10
'''

'''
Solution 4: Stack
In this approach, we maintain a stack. Initially, we push a -1 onto the stack to mark the end. We start with the leftmost bar and keep pushing the current bar's index onto the stack until we get two successive numbers in descending order, i.e. until we get a[i]<a[i-1]. Now, we start popping the numbers from the stack until we hit a number stack[j] on the stack such that a[stack[j]]≤a[i]. Every time we pop, we find out the area of rectangle formed using the current element as the height of the rectangle and the difference between the the current element's index pointed to in the original array and the element stack[top−1]−1 as the width i.e. if we pop an element stack[top]stack[top] and i is the current index to which we are pointing in the original array, the current area of the rectangle will be considered as:
(i-stack[top-1]-1) \times a\big[stack[top]\big].(i−stack[top−1]−1)×a[stack[top]].
Further, if we reach the end of the array, we pop all the elements of the stack and at every pop, this time we use the following equation to find the area: (stack[top]-stack[top-1]) \times a\big[stack[top]\big](stack[top]−stack[top−1])×a[stack[top]], where stack[top]stack[top] refers to the element just popped. Thus, we can get the area of the of the largest rectangle by comparing the new area found everytime.

Time complexity :O(n). nn numbers are pushed and popped.
Space complexity : O(n). Stack is used.
'''
class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        n = len(heights)
        stack = [-1]
        area = 0

        for i in range(n):
            while len(stack) > 1 and heights[stack[len(stack)-1]] >= heights[i]:
                area = max(area, heights[stack.pop()] * (i - stack[len(stack)-1] - 1))
            stack.append(i)

        while len(stack) > 1:
            area = max(area, heights[stack.pop()] * (n - stack[len(stack)-1] - 1))

        return area
