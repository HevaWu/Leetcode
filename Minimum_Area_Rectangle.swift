// Given a set of points in the xy-plane, determine the minimum area of a rectangle formed from these points, with sides parallel to the x and y axes.

// If there isn't any rectangle, return 0.

 

// Example 1:

// Input: [[1,1],[1,3],[3,1],[3,3],[2,2]]
// Output: 4
// Example 2:

// Input: [[1,1],[1,3],[3,1],[3,3],[4,1],[4,3]]
// Output: 2
 

// Note:

// 1 <= points.length <= 500
// 0 <= points[i][0] <= 40000
// 0 <= points[i][1] <= 40000
// All points are distinct.

// Solution 1: group x 
// Group the points by x coordinates, so that we have columns of points. Then, for every pair of points in a column (with coordinates (x,y1) and (x,y2)), check for the smallest rectangle with this pair of points as the rightmost edge. We can do this by keeping memory of what pairs of points we've seen before.
// 
// Time Complexity: O(N^2), where NN is the length of points.
// Space Complexity: O(N)O(N).
class Solution {
    func minAreaRect(_ points: [[Int]]) -> Int {
        guard !points.isEmpty else { return 0 }
        var xArr = [Int: [Int]]()
        for point in points {
            xArr[point[0], default: [Int]()].append(point[1])
        }
        
        var area = Int.max
        // key is y0*40001 + y1
        // value is lastX which have this value
        var lastX = [Int: Int]()
        for x in xArr.keys {
            var ylist = xArr[x]!
            // sort ylist for checking in order
            ylist.sort()
            guard ylist.count >= 2 else { continue }
            for i in 0..<ylist.count {
                var j = i + 1
                while j < ylist.count {
                    var y0 = ylist[i]
                    var y1 = ylist[j]
                    var temp = y0*40001 + y1
                    if lastX.keys.contains(temp) {
                        // compare area
                        var preX = lastX[temp]!
                        area = min(area, (x-preX)*(y1-y0))
                    }
                    lastX[temp] = x
                    j += 1
                }
            }
        }
        return area < Int.max ? area : 0
    }
}

// Solution 2: Count by Diagonal
// For each pair of points in the array, consider them to be the long diagonal of a potential rectangle. We can check if all 4 points are there using a Set.
// For example, if the points are (1, 1) and (5, 5), we check if we also have (1, 5) and (5, 1). If we do, we have a candidate rectangle.
// 
// Put all the points in a set. For each pair of points, if the associated rectangle are 4 distinct points all in the set, then take the area of this rectangle as a candidate answer.
// 
// Time Complexity: O(N^2) where NN is the length of points.
// Space Complexity: O(N)O(N), where HH is the height of the tree.
class Solution {
    func minAreaRect(_ points: [[Int]]) -> Int {
        guard !points.isEmpty else { return 0 }
        var area = Int.max
        
        var set = Set<Int>()
        for point in points {
            set.insert(point[0] * 40001 + point[1])
        }
        
        for i in 0..<points.count {
            let x0 = points[i][0]
            let y0 = points[i][1]
            var j = i + 1
            while j < points.count {
                let x1 = points[j][0]
                let y1 = points[j][1]
                
                if x0 != x1, y0 != y1, 
                set.contains(x0*40001 + y1), set.contains(x1*40001 + y0) {
                    // x0,y0, x1,y1 & x0,y1 & x1,y0
                    area = min(area, abs(x0-x1)*abs(y0-y1))
                }
                j += 1
            }
        }
        
        return area < Int.max ? area : 0
    }
}