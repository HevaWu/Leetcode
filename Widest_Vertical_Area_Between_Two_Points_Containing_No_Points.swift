/*
Given n points on a 2D plane where points[i] = [xi, yi], Return the widest vertical area between two points such that no points are inside the area.

A vertical area is an area of fixed-width extending infinitely along the y-axis (i.e., infinite height). The widest vertical area is the one with the maximum width.

Note that points on the edge of a vertical area are not considered included in the area.



Example 1:

​
Input: points = [[8,7],[9,9],[7,4],[9,7]]
Output: 1
Explanation: Both the red and the blue area are optimal.
Example 2:

Input: points = [[3,1],[9,0],[1,0],[1,4],[5,3],[8,8]]
Output: 3


Constraints:

n == points.length
2 <= n <= 105
points[i].length == 2
0 <= xi, yi <= 109
*/

/*
Solution 1:
sort the point by x, then find maxWidth

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func maxWidthOfVerticalArea(_ points: [[Int]]) -> Int {
        var points = points.sorted(by: {p1, p2 -> Bool in
            return p1[0] < p2[0]
        })

        var maxWidth = 0
        for i in 1..<points.count {
            let width = points[i][0] - points[i-1][0]
            maxWidth = max(maxWidth, width)
        }
        return maxWidth
    }
}
