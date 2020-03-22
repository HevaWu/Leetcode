// Given a 2D binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.

// Example:

// Input:
// [
//   ["1","0","1","0","0"],
//   ["1","0","1","1","1"],
//   ["1","1","1","1","1"],
//   ["1","0","0","1","0"]
// ]
// Output: 6

// Solution 1: brute force
// Trivially we can enumerate every possible rectangle. This is done by iterating over all possible combinations of coordinates (x1, y1) and (x2, y2) and letting them define a rectangle with the coordinates being opposite corners. This is too slow to pass all test cases.
// 
// Time complexity : O(N^3M^3), with N being the number of rows and M the number of columns. Iterating over all possible coordinates is O(N^2M^2), and iterating over the rectangle defined by two coordinates is an additional O(NM)O(NM). O(NM) * O(N^2M^2) = O(N^3M^3).
// Space complexity : O(1)O(1).

// Solution 2: DP
// We can compute the maximum width of a rectangle that ends at a given coordinate in constant time. We do this by keeping track of the number of consecutive ones each square in each row. As we iterate over each row we update the maximum possible width at that point. This is done using row[i] = row[i - 1] + 1 if row[i] == '1'.
// 
// Once we know the maximum widths for each point above a given point, we can compute the maximum rectangle with the lower right corner at that point in linear time. As we iterate up the column, we know that the maximal width of a rectangle spanning from the original point to the current point is the running minimum of each maximal width we have encountered.
// We define:
// maxWidth = min(maxWidth, widthHere)maxWidth=min(maxWidth,widthHere)
// curArea = maxWidth * (currentRow - originalRow + 1)curArea=maxWidth∗(currentRow−originalRow+1)
// maxArea = max(maxArea, curArea)maxArea=max(maxArea,curArea)
// 
// Time complexity : O(N^2M). Computing the maximum area for one point takes O(N)O(N) time, since it iterates over the values in the same column. This is done for all N * MN∗M points, giving O(N) * O(NM) = O(N^2M).
// Space complexity : O(NM)O(NM). We allocate an equal sized array to store the maximum width at each point.
class Solution {
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        
        let n = matrix.count
        let m = matrix[0].count
        
        var maxArea = 0
        
        // count the width for the row
        var dp = Array(repeating: Array(repeating: 0, count: m), count: n)
        for i in 0..<n {
            for j in 0..<m where matrix[i][j] == "1" {
                dp[i][j] = j == 0 ? 1 : (dp[i][j-1] + 1)
                
                var width = dp[i][j]
                
                // for this row, count area
                var k = i 
                while k >= 0 {
                    width = min(width, dp[k][j])
                    maxArea = max(maxArea, width * (i-k+1))
                    k -= 1
                }
            }
        }
        return maxArea
    }
}

// Solutoin 2: histogram
// In the previous approach we discussed breaking the input into a set of histograms - one histogram representing the substructure at each column. To compute the maximum area in our rectangle, we merely have to compute the maximum area of each histogram and find the global maximum (note that the below approach builds a histogram for each row instead of each column, but the idea is still the same).
// 
// Time complexity : O(NM)O(NM). Running leetcode84 on each row takes M (length of each row) time. This is done N times for O(NM)O(NM).
// Space complexity : O(M)O(M). We allocate an array the size of the the number of columns to store our widths at each row.
class Solution {
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        
        let n = matrix.count
        let m = matrix[0].count
        
		// for height
        var dp = Array(repeating: 0, count: m)
        var maxArea = 0
        for i in 0..<n {
            for j in 0..<m {
                // update the row histogram
                dp[j] = matrix[i][j] == "1" ? dp[j] + 1 : 0
            }
            maxArea = max(maxArea, getMaximumArea(from: dp))
        }
        return maxArea
    }
    
    // leetcode 84
    // get maximum area in histogram with its given heights
    func getMaximumArea(from heights: [Int]) -> Int {
        var stack = [-1]
        var maxArea = 0
        for i in 0..<heights.count {
            while stack.count > 1, heights[stack.last!] >= heights[i] {
                maxArea = max(maxArea, heights[stack.removeLast()] * (i - stack.last! - 1))
            }
            stack.append(i)
        }
        while stack.count > 1 {
            maxArea = max(maxArea, heights[stack.removeLast()] * (heights.count - stack.last! - 1))
        }
        return maxArea
    }
}

// Solution 3: Dynamic Programming - Maximum Height at Each Point
// Given a maximal rectangle with height h, left bound l, and right bound r, there must be a point on the interval [l, r] on the rectangle's base where the number of consecutive ones (height) above the point is <=h. If this point exists, then the rectangle defined by the point in the above manner will be the maximal rectangle, as it will reach height h iterating upward and then expand to the bounds of [l, r] as all heights within those bounds must accommodate h for the rectangle to exist.
// As a result for each point you only need to compute h, l, and r - the height, left bound, and right bound of the rectangle it defines.
// Using dynamic programming, we can use the h, l, and r of each point in the previous row to compute the h, l, and r for every point in the next row in linear time.
// 
// Given row matrix[i], we keep track of the h, l, and r of each point in the row by defining three arrays - height, left, and right.
// height[j] will correspond to the height of matrix[i][j], and so on and so forth with the other arrays.
// 
// how to update each array.
// Height:
// This one is easy. h is defined as the number of continuous ones in a line from our point. We explored how to compute this in Approach 2 in one row with:
// row[j] = row[j - 1] + 1 if row[j] == '1'
// We can just make a minor modification for it to work for us here:
// new_height[j] = old_height[j] + 1 if row[j] == '1' else 0
// 
// Left:
// Consider what causes changes to the left bound of our rectangle. Since all instances of zeros occurring in the row above the current one have already been factored into the current version of left, the only thing that affects our left is if we encounter a zero in our current row.
// As a result we can define:
// new_left[j] = max(old_left[j], cur_left)
// cur_left is one greater than rightmost occurrence of zero we have encountered. When we "expand" the rectangle to the left, we know it can't expand past that point, otherwise it'll run into the zero.
// 
// Right:
// Here we can reuse our reasoning in left and define:
// new_right[j] = min(old_right[j], cur_right)
// cur_right is the leftmost occurrence of zero we have encountered. For the sake of simplicity, we don't decrement cur_right by one (like how we increment cur_left) so we can compute the area of the rectangle with height[j] * (right[j] - left[j]) instead of height[j] * (right[j] + 1 - left[j]).

// This means that technically the base of the rectangle is defined by the half-open interval [l, r) instead of the closed interval [l, r], and right is really one greater than right boundary. Although the algorithm will still work if we don't do this with right, doing it this way makes the area calculation a little cleaner.
// Note that to keep track of our cur_right correctly, we must iterate from right to left, so this is what is done when updating right.
// With our left, right, and height arrays appropriately updated, all that there is left to do is compute the area of each rectangle.
// Since we know the bounds and height of rectangle j, we can trivially compute it's area with height[j] * (right[j] - left[j]), and change our max_area if we find that rectangle j's area is greater.
// 
// Time complexity : O(NM)O(NM). In each iteration over N we iterate over M a constant number of times.
// Space complexity : O(M)O(M). M is the length of the additional arrays we keep.
// 
// Time complexity : O(NM)O(NM). In each iteration over N we iterate over M a constant number of times.
// Space complexity : O(M)O(M). M is the length of the additional arrays we keep.
class Solution {
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        let n = matrix.count
        let m = matrix[0].count
        
        var height = Array(repeating: 0, count: m)
        var left = Array(repeating: 0, count: m)    // init left as the leftmost boundary
        var right = Array(repeating: m, count: m)   // init right as the rightmost boundary -> m
        
        var maxArea = 0
        
        for i in 0..<n {
            // update height
            for j in 0..<m {
                height[j] = matrix[i][j] == "1" ? height[j] + 1 : 0
            }
            
            // update left
            var curLeft = 0
            for j in 0..<m {
                if matrix[i][j] == "1" {
                    left[j] = max(left[j], curLeft)
                } else {
                    // reset left to 0
                    left[j] = 0
                    curLeft = j+1
                }
            }
            
            // update right, start from right side
            var curRight = m
            var j = m-1
            while j >= 0 {
                if matrix[i][j] == "1" {
                    right[j] = min(right[j], curRight)
                } else {
                    right[j] = m // reset right to m
                    curRight = j // reset curRight to `j` not j-1
                }
                j -= 1
            }
            
            // check area
            for j in 0..<m {
                maxArea = max(maxArea, (right[j]-left[j])*height[j])
            }
        }
        return maxArea
    }
}
