/*
You are given an array of points in the X-Y plane points where points[i] = [xi, yi].

Return the minimum area of any rectangle formed from these points, with sides not necessarily parallel to the X and Y axes. If there is not any such rectangle, return 0.

Answers within 10-5 of the actual answer will be accepted.



Example 1:


Input: points = [[1,2],[2,1],[1,0],[0,1]]
Output: 2.00000
Explanation: The minimum area rectangle occurs at [1,2],[2,1],[1,0],[0,1], with an area of 2.
Example 2:


Input: points = [[0,1],[2,1],[1,1],[1,0],[2,0]]
Output: 1.00000
Explanation: The minimum area rectangle occurs at [1,0],[1,1],[2,1],[2,0], with an area of 1.
Example 3:


Input: points = [[0,3],[1,2],[3,1],[1,3],[2,1]]
Output: 0
Explanation: There is no possible rectangle to form from these points.
Example 4:


Input: points = [[3,1],[1,1],[0,1],[2,1],[3,3],[3,2],[0,2],[2,3]]
Output: 2.00000
Explanation: The minimum area rectangle occurs at [2,1],[2,3],[3,3],[3,1], with an area of 2.


Constraints:

1 <= points.length <= 50
points[i].length == 2
0 <= xi, yi <= 4 * 104
All the given points are unique.

*/

/*
Solution 1:
brute force all possible 4 points pair, to check if it can made a rectangle or not
if it can, compare the area

- can made a rectangle function
    - ABCD, get all possible distance, if ABCD can be a rectangle, AC is the diagonal, then AC=BD, AB=CD, AD=BC
    - area would be AB*AD
    - similar for AD is diagonal and AB is diagonal

Time Complexity: O(A4n) -> n*(n-1)*(n-2)*(n-3)
Space Complexity: O(1)
*/
class Solution {
    func minAreaFreeRect(_ points: [[Int]]) -> Double {
        let n = points.count
        if n < 4 { return 0.0 }

        var area: Double = 0.0

        for i1 in 0..<(n-3) {
            for i2 in (i1+1)..<(n-2) {
                for i3 in (i2+1)..<(n-1) {
                    for i4 in (i3+1)..<n {
                        let A = points[i1]
                        let B = points[i2]
                        let C = points[i3]
                        let D = points[i4]

                        let (isRec, val) = canBeRectangle(A, B, C, D)
                        if isRec {
                            area = area == 0.0 ? val : min(area, val)
                        }
                    }
                }
            }
        }

        return Double(Int(area * 100_000)) / Double(100_000)
    }

    func canBeRectangle(_ A: [Int], _ B: [Int],
                        _ C: [Int], _ D: [Int]) -> (isRec: Bool, val: Double) {
        let ab = getDis(A, B)
        let ac = getDis(A, C)
        let ad = getDis(A, D)
        let bc = getDis(B, C)
        let bd = getDis(B, D)
        let cd = getDis(C, D)

        if ab > ac, ab > ad {
            // AB is diagonal, CD should be diagonal too
            guard ab == cd, ac == bd, ad == bc else { return (false, 0.0) }
            return (true, ac*ad)
        } else if ac > ab, ac > ad {
            // ac is diagonal, bd should be diagonal
            guard ac == bd, ad == bc, ab == cd else { return (false, 0.0) }
            return (true, ab*ad)
        } else if ad > ab, ad > ac {
            // ad is diagonal, bc should be diagonal
            guard ac == bd, ad == bc, ab == cd else { return (false, 0.0) }
            return (true, ab*ac)
        } else {
            return (false, 0.0)
        }
    }

    func getDis(_ p1: [Int], _ p2: [Int]) -> Double {
        let x0 = p1[0]
        let y0 = p1[1]

        let x1 = p2[0]
        let y1 = p2[1]

        return sqrt(Double((x1 - x0) * (x1 - x0)) + Double((y1 - y0) * (y1-y0)))
    }
}