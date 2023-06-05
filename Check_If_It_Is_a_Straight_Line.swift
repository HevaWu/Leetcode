/*
You are given an array coordinates, coordinates[i] = [x, y], where [x, y] represents the coordinate of a point. Check if these points make a straight line in the XY plane.





Example 1:



Input: coordinates = [[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]]
Output: true
Example 2:



Input: coordinates = [[1,1],[2,2],[3,4],[4,5],[5,6],[7,7]]
Output: false


Constraints:

2 <= coordinates.length <= 1000
coordinates[i].length == 2
-10^4 <= coordinates[i][0], coordinates[i][1] <= 10^4
coordinates contains no duplicate point.
*/

/*
Solution 1:
calculate the k for each 2 points

- always keep p1[0] < p2[0] to make sure k is in same order
- return nil for points has same x

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func checkStraightLine(_ coordinates: [[Int]]) -> Bool {
        let n = coordinates.count
        let k: Double? = getK(coordinates[0], coordinates[1])
        for i in 2..<n {
            if k != getK(coordinates[i], coordinates[i-1]) {
                return false
            }
        }
        return true
    }

    func getK(_ p1: [Int], _ p2: [Int]) -> Double? {
        if p1[0] > p2[0] { return getK(p2, p1) }
        // return nil for point has same x
        if p1[0] == p2[0] { return nil }
        return Double(p2[1] - p1[1]) / Double(p2[0] - p1[0])
    }
}
