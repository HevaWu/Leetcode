/*
Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane, return the maximum number of points that lie on the same straight line.

 

Example 1:


Input: points = [[1,1],[2,2],[3,3]]
Output: 3
Example 2:


Input: points = [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
Output: 4
 

Constraints:

1 <= points.length <= 300
points[i].length == 2
-104 <= xi, yi <= 104
All the points are unique.
*/

/*
Solution 1:
calculate co-prime slope

- Initiate the maximum number of points max_count = 1.
- Iterate over all points i from 0 to N - 2.
	- For each point i find a maximum number of points max_count_i on a line passing through the point i :
		- Initiate the maximum number of points on a line passing through the point i : count = 1.
		- Iterate over next points j from i + 1 to N - 1.
			- If j is a duplicate of i, update a number of duplicates for point i.
			- If not:
			- Save the line passing through the points i and j.
			- Update count at each step.
		- Return max_count_i = count + duplicates.
	- Update the result max_count = max(max_count, max_count_i)

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    var points = [[Int]]()
    var n = 0
    
    func maxPoints(_ points: [[Int]]) -> Int {
        self.points = points
        n = points.count
        if n < 3 { return n }
        
        var maxCount = 1
        for i in 0..<(n-1) {
            maxCount = max(maxCount, getMaxPointsOnLine(i))
        }
        return maxCount
    }
    
    // return max points for a line containing point[i]
    func getMaxPointsOnLine(_ i: Int) -> Int {
        var lines = [Slope: Int]()
        var horizontal = 1
        
        var count = 1
        var duplicates = 0
        
        for j in (i+1)..<n {
            addLine(i, j, &count, &duplicates, &lines, &horizontal)
        }
        return count+duplicates
    }
    
    // add line passing through i, j points
    // update max points on this line
    // update count
    // update duplicates
    func addLine(_ i: Int, _ j: Int, 
                 _ count: inout Int, _ duplicates: inout Int, 
                 _ lines: inout [Slope: Int], _ horizontal: inout Int) {
        let x1 = points[i][0]
        let y1 = points[i][1]
        let x2 = points[j][0]
        let y2 = points[j][1]
        
        if x1 == x2, y1 == y2 {
            duplicates += 1
        } else if y1 == y2 {
            horizontal += 1
            count = max(count, horizontal)
        } else {
            let slope = getCoprimeSlope(x1, y1, x2, y2)
            lines[slope, default: 1] += 1
            count = max(count, lines[slope]!)
        }
    }
    
    // calculate coprime slope of x1, y1, x2, y2
    func getCoprimeSlope(_ x1: Int, _ y1: Int, 
                         _ x2: Int, _ y2: Int) -> Slope {
        var deltaX = x1-x2
        var deltaY = y1-y2
        
        if deltaX == 0 {
            return Slope(x: 0, y: 0)
        } else if deltaY == 0 {
            return Slope(x: Int.max, y: Int.max)
        } else if deltaX < 0 {
            deltaX = -deltaX
            deltaY = -deltaY
        }
        let gcdVal = gcd(deltaX, deltaY)
        // print(gcdVal, deltaX, deltaY)
        return Slope(x: deltaX/gcdVal, y: deltaY/gcdVal)
    }
    
    // check Greatest Common Divisor
    func gcd(_ a: Int, _ b: Int) -> Int {
        var t = 0
        var a = a
        var b = b
        while b != 0 {
            t = a
            a = b
            b = t%b
        }
        return a
    }
    
    // slope would be y/x
    // co-prime slope point
    struct Slope: Hashable {
        let x: Int
        let y: Int
    }
}