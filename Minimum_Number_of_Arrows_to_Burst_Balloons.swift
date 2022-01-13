/*
There are some spherical balloons taped onto a flat wall that represents the XY-plane. The balloons are represented as a 2D integer array points where points[i] = [xstart, xend] denotes a balloon whose horizontal diameter stretches between xstart and xend. You do not know the exact y-coordinates of the balloons.

Arrows can be shot up directly vertically (in the positive y-direction) from different points along the x-axis. A balloon with xstart and xend is burst by an arrow shot at x if xstart <= x <= xend. There is no limit to the number of arrows that can be shot. A shot arrow keeps traveling up infinitely, bursting any balloons in its path.

Given the array points, return the minimum number of arrows that must be shot to burst all balloons.



Example 1:

Input: points = [[10,16],[2,8],[1,6],[7,12]]
Output: 2
Explanation: The balloons can be burst by 2 arrows:
- Shoot an arrow at x = 6, bursting the balloons [2,8] and [1,6].
- Shoot an arrow at x = 11, bursting the balloons [10,16] and [7,12].
Example 2:

Input: points = [[1,2],[3,4],[5,6],[7,8]]
Output: 4
Explanation: One arrow needs to be shot for each balloon for a total of 4 arrows.
Example 3:

Input: points = [[1,2],[2,3],[3,4],[4,5]]
Output: 2
Explanation: The balloons can be burst by 2 arrows:
- Shoot an arrow at x = 2, bursting the balloons [1,2] and [2,3].
- Shoot an arrow at x = 4, bursting the balloons [3,4] and [4,5].


Constraints:

1 <= points.length <= 105
points[i].length == 2
-231 <= xstart < xend <= 231 - 1
*/

/*
Solution 1:
sort points by start, then by end

- overlap: current arrow shoot
- arrow: current prepare arrow

prepare arrow to see, if current balloon can be shoot with previous balloon

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        let n = points.count
        if n == 1 { return 1 }

        var points = points.sorted(by: {
            $0[0] == $1[0] ? $0[1] < $1[1] : $0[0] < $1[0]
        })
        var arrow = 1

        // [start, end]
        var overlap = points[0]
        for i in 1..<n {
            if points[i][0] <= overlap[1] {
                // update overlap
                overlap[1] = min(overlap[1], points[i][1])
                overlap[0] = max(overlap[0], points[i][0])
            } else {
                // no overlap, increase arrows
                arrow += 1
                overlap = points[i]
            }
            // print(overlap)
        }

        return arrow
    }
}