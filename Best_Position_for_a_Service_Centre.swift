/*
A delivery company wants to build a new service centre in a new city. The company knows the positions of all the customers in this city on a 2D-Map and wants to build the new centre in a position such that the sum of the euclidean distances to all customers is minimum.

Given an array positions where positions[i] = [xi, yi] is the position of the ith customer on the map, return the minimum sum of the euclidean distances to all customers.

In other words, you need to choose the position of the service centre [xcentre, ycentre] such that the following formula is minimized:


Answers within 10^-5 of the actual value will be accepted.



Example 1:


Input: positions = [[0,1],[1,0],[1,2],[2,1]]
Output: 4.00000
Explanation: As shown, you can see that choosing [xcentre, ycentre] = [1, 1] will make the distance to each customer = 1, the sum of all distances is 4 which is the minimum possible we can achieve.
Example 2:


Input: positions = [[1,1],[3,3]]
Output: 2.82843
Explanation: The minimum possible sum of distances = sqrt(2) + sqrt(2) = 2.82843
Example 3:

Input: positions = [[1,1]]
Output: 0.00000
Example 4:

Input: positions = [[1,1],[0,0],[2,0]]
Output: 2.73205
Explanation: At the first glance, you may think that locating the centre at [1, 0] will achieve the minimum sum, but locating it at [1, 0] will make the sum of distances = 3.
Try to locate the centre at [1.0, 0.5773502711] you will see that the sum of distances is 2.73205.
Be careful with the precision!
Example 5:

Input: positions = [[0,1],[3,2],[4,5],[7,6],[8,9],[11,1],[2,12]]
Output: 32.94036
Explanation: You can use [4.3460852395, 4.9813795505] as the position of the centre.


Constraints:

1 <= positions.length <= 50
positions[i].length == 2
0 <= positions[i][0], positions[i][1] <= 100
*/

/*
Solution 1:

control delta
We first find the best 10x10 square to put the service center in the 100x100 grid. Then, find the best 1x1 square in the 30x30 grid (with 10x10 square from the previous step in the middle).

Continue this process, dividing the grid size (delta) by 10 till it's smaller than 10^-5

*/
class Solution {
    func getMinDistSum(_ positions: [[Int]]) -> Double {
        if positions.count == 1 { return 0.0 }

        // [xmin, xmax, ymin, ymax]
        let xyRange = getXYRange(from: positions)
        var xmin = Double(xyRange[0])
        var xmax = Double(xyRange[1])
        var ymin = Double(xyRange[2])
        var ymax = Double(xyRange[3])

        var res: Double = 1e7
        var xc: Double = 0
        var yc: Double = 0

        var delta: Double = 10
        while delta >= 0.00001 {
            for x in stride(from: xmin, through: xmax, by: delta) {
                for y in stride(from: ymin, through: ymax, by: delta) {
                    var dis: Double = 0
                    for p in positions {
                        let xdiff = Double(p[0]) - x
                        let ydiff = Double(p[1]) - y
                        dis += (sqrt(xdiff * xdiff + ydiff * ydiff))
                    }

                    if res > dis {
                        res = dis
                        xc = x
                        yc = y
                    }
                }
            }

            xmin = xc - delta
            xmax = xc + delta
            ymin = yc - delta
            ymax = yc + delta

            delta /= 10
        }

        return res
    }

    // return [xmin, xmax, ymin, ymax]
    func getXYRange(from positions: [[Int]]) -> [Int] {
        var xmin = 101
        var xmax = -1
        var ymin = 101
        var ymax = -1

        for p in positions {
            xmin = min(xmin, p[0])
            xmax = max(xmax, p[0])
            ymin = min(ymin, p[1])
            ymax = max(ymax, p[1])
        }

        return [xmin, xmax, ymin, ymax]
    }
}