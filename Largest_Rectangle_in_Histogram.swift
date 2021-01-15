// Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.

 


// Above is a histogram where width of each bar is 1, given height = [2,1,5,6,2,3].

 


// The largest rectangle is shown in the shaded area, which has area = 10 unit.

 

// Example:

// Input: [2,1,5,6,2,3]
// Output: 10

// Solution 1: brute force
// In mathematical terms, minheight=\min(minheight, heights(j))minheight=min(minheight,heights(j)), where heights(j)heights(j) refers to the height of the jjth bar.
// 
// Time complexity: O(n^2)
// Space complexity: O(1)
class Solution {
    func largestRectangleArea(_ heights: [Int]) -> Int {
        guard !heights.isEmpty else { return 0 }
        let n = heights.count
        var maxArea = 0
        for i in 0..<n {
            var temp = heights[i]
            for j in i..<n {
                temp = min(temp, heights[j])
                maxArea = max(maxArea, temp*(j-i+1))
            }
        }
        return maxArea
    }
}

// Solution 2: divide & conquer
// This approach relies on the observation that the rectangle with maximum area will be the maximum of:
// The widest possible rectangle with height equal to the height of the shortest bar.
// The largest rectangle confined to the left of the shortest bar(subproblem).
// The largest rectangle confined to the right of the shortest bar(subproblem).
// 
// Let's take an example:
// [6, 4, 5, 2, 4, 3, 9]
// Here, the shortest bar is of height 2. The area of the widest rectangle using this bar as height is 2x8=16. Now, we need to look for cases 2 and 3 mentioned above. Thus, we repeat the same process to the left and right of 2. In the left of 2, 4 is the minimum, forming an area of rectangle 4x3=12. Further, rectangles of area 6x1=6 and 5x1=5 exist in its left and right respectively. Similarly we find an area of 3x3=9, 4x1=4 and 9x1=9 to the left of 2. Thus, we get 16 as the correct maximum area. See the figure below for further clarification:
// 
// Time complexity :
// Average Case: O(nlogn).
// Worst Case: O(n^2). If the numbers in the array are sorted, we don't gain the advantage of divide and conquer.
// Space complexity : O(n). Recursion with worst case depth nn.
class Solution {
    var heights = [Int]()
    func largestRectangleArea(_ heights: [Int]) -> Int {
        guard !heights.isEmpty else { return 0 }
        self.heights = heights
        return checkArea(0, heights.count-1)
    }
    
    func checkArea(_ left: Int, _ right: Int) -> Int {
        if left > right { return 0 }
        var minIndex = left
        for i in left...right {
            if heights[i] < heights[minIndex] {
                minIndex = i
            }
        }
        return max(heights[minIndex] * (right-left+1),
                  max(checkArea(left, minIndex-1), checkArea(minIndex+1, right)))
    }
}

// Solution 3: Segment Tree
// You can observe that in the Divide and Conquer Approach, we gain the advantage, since the large problem is divided into substantially smaller subproblems. But, we won't gain much advantage with that approach if the array happens to be sorted in either ascending or descending order, since every time we need to find the minimum number in a large subarray O(n). Thus, the overall complexity becomes O(n^2) in the worst case. We can reduce the time complexity by using a Segment Tree to find the minimum every time which can be done in O(logn) time.
// 
// Time complexity : O(nlogn). Segment tree takes logn for a total of nn times.
// Space complexity : O(n). Space required for Segment Tree.

// Solution 4: Stack
// In this approach, we maintain a stack. Initially, we push a -1 onto the stack to mark the end. We start with the leftmost bar and keep pushing the current bar's index onto the stack until we get two successive numbers in descending order, i.e. until we get a[i]<a[i-1]. Now, we start popping the numbers from the stack until we hit a number stack[j] on the stack such that a\big[stack[j]\big] \leq a[i]a[stack[j]]≤a[i]. Every time we pop, we find out the area of rectangle formed using the current element as the height of the rectangle and the difference between the the current element's index pointed to in the original array and the element stack[top−1]−1 as the width i.e. if we pop an element stack[top]stack[top] and i is the current index to which we are pointing in the original array, the current area of the rectangle will be considered as:
// (i-stack[top-1]-1) \times a\big[stack[top]\big].(i−stack[top−1]−1)×a[stack[top]].
// Further, if we reach the end of the array, we pop all the elements of the stack and at every pop, this time we use the following equation to find the area: (stack[top]-stack[top-1]) \times a\big[stack[top]\big](stack[top]−stack[top−1])×a[stack[top]], where stack[top]stack[top] refers to the element just popped. Thus, we can get the area of the of the largest rectangle by comparing the new area found everytime.
// 
// Time complexity :O(n). nn numbers are pushed and popped.
// Space complexity : O(n). Stack is used.
class Solution {
    func largestRectangleArea(_ heights: [Int]) -> Int {
        guard !heights.isEmpty else { return 0 }
        
        var maxArea = 0
        
        // hold the index
        var stack = [-1]
        for i in 0..<heights.count {
            while stack.count > 1, heights[stack.last!] >= heights[i] {
                maxArea = max(maxArea,
                             heights[stack.removeLast()] * (i - stack.last! - 1))
            }
            stack.append(i)
        }
        
        while stack.count > 1 {
            maxArea = max(maxArea,
                         heights[stack.removeLast()] * (heights.count - stack.last! - 1))
        }
        return maxArea
    }
}

