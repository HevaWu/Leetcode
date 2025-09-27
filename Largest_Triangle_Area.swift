/*
Given an array of points on the X-Y plane points where points[i] = [xi, yi], return the area of the largest triangle that can be formed by any three different points. Answers within 10-5 of the actual answer will be accepted.



Example 1:


Input: points = [[0,0],[0,1],[1,0],[0,2],[2,0]]
Output: 2.00000
Explanation: The five points are shown in the above figure. The red triangle is the largest.
Example 2:

Input: points = [[1,0],[0,0],[0,1]]
Output: 0.50000


Constraints:

3 <= points.length <= 50
-50 <= xi, yi <= 50
All the given points are unique.
*/

class Solution {
    func largestTriangleArea(_ points: [[Int]]) -> Double {
        let n = points.count
        var area = 0.0
        for i in 0..<n {
            if i+1 == n { break }
            // print(i)
            for j in (i+1)..<n {
                if j+1 == n { break }
                // print(j)
                for k in (j+1)..<n {
                    // print(k)
                    area = max(area, getArea(points[i], points[j], points[k]))
                }
            }
        }
        return area
    }

    func getArea(_ p1: [Int], _ p2: [Int], _ p3: [Int]) -> Double {
        var val: Double = Double(p1[0]*p2[1] + p2[0]*p3[1] + p3[0]*p1[1] - p1[1]*p2[0] - p2[1]*p3[0] - p3[1]*p1[0])
        return 0.5 * abs(val)
    }
}
