/*
You are given an array trees where trees[i] = [xi, yi] represents the location of a tree in the garden.

You are asked to fence the entire garden using the minimum length of rope as it is expensive. The garden is well fenced only if all the trees are enclosed.

Return the coordinates of trees that are exactly located on the fence perimeter.



Example 1:


Input: points = [[1,1],[2,2],[2,0],[2,4],[3,3],[4,2]]
Output: [[1,1],[2,0],[3,3],[2,4],[4,2]]
Example 2:


Input: points = [[1,2],[2,2],[4,2]]
Output: [[4,2],[2,2],[1,2]]


Constraints:

1 <= points.length <= 3000
points[i].length == 2
0 <= xi, yi <= 100
All the given points are unique.
*/

/*
Solution 2:
Graham Scan

Firsly we select an initial point(bmbm) to start the hull with. This point is chosen as the point with the lowest y-coordinate. In case of a tie, we need to choose the point with the lowest x-coordinate, from among all the given set of points. This point is indicated as point 0 in the animation. Then, we sort the given set of points based on their polar angles formed w.r.t. a vertical line drawn throught the intial point.

This sorting of the points gives us a rough idea of the way in which we should consider the points to be included in the hull while considering the boundary in counter-clockwise order. In order to sort the points, we make use of orientation function which is the same as discussed in the last approach. The points with a lower polar angle relative to the vertical line come first in the sorted array. In case, if the orientation of two points happens to be the same, the points are sorted based on their distance from the beginning point(bmbm). Later on we'll be considering the points in the sorted array in the same order. Because of this, we need to do the sorting based on distance for points collinear relative to bmbm, so that all the collinear points lying on the hull are included in the boundary.

But, we need to consider another important case. In case, the collinear points lie on the closing(last) edge of the hull, we need to consider the points such that the points which lie farther from the initial point bmbm are considered first. Thus, after sorting the array, we traverse the sorted array from the end and reverse the order of the points which are collinear and lie towards the end of the sorted array, since these will be the points which will be considered at the end while forming the hull and thus, will be considered at the end. Thus, after these preprocessing steps, we've got the points correctly arranged in the way that they need to be considered while forming the hull.

Now, as per the algorithm, we start off by considering the line formed by the first two points(0 and 1 in the animation) in the sorted array. We push the points on this line onto a stackstack. After this, we start traversing over the sorted pointspoints array from the third point onwards. If the current point being considered appears after taking a left turn(or straight path) relative to the previous line(line's direction), we push the point onto the stack, indicating that the point has been temporarily added to the hull boundary.

This checking of left or right turn is done by making use of orientation again. An orientation greater than 0, considering the points on the line and the current point, indicates a counterclockwise direction or a right turn. A negative orientation indicates a left turn similarly.

If the current point happens to be occuring by taking a right turn from the previous line's direction, it means that the last point included in the hull was incorrect, since it needs to lie inside the boundary and not on the boundary(as is indicated by point 4 in the animation). Thus, we pop off the last point from the stack and consider the second last line's direction with the current point.

Thus, the same process continues, and the popping keeps on continuing till we reach a state where the current point can be included in the hull by taking a right turn. Thus, in this way, we ensure that the hull includes only the boundary points and not the points inside the boundary. After all the points have been traversed, the points lying in the stack constitute the boundary of the convex hull.
*/

/*
Solution 1:
Jarvis Algorithm

We start with the leftmost point among the given set of points and try to wrap up all the given points considering the boundary points in counterclockwise direction.

This means that for every point pp considered, we try to find out a point qq, such that this point qq is the most counterclockwise relative to pp than all the other points. For checking this, we make use of orientation() function in the current implementation. This function takes three arguments pp, the current point added in the hull; qq, the next point being considered to be added in the hull; rr, any other point in the given point space. This function returns a negative value if the point qq is more counterclockwise to pp than the point rr.

The following figure shows the concept. The point qq is more counterclockwise to pp than the point rr.

Time Complexity: O(m*n)
Space Complexity: O(m)
*/
class Solution {
    func outerTrees(_ trees: [[Int]]) -> [[Int]] {
        let n = trees.count
        if n < 4 { return trees }

        var tSet = Set<[Int]>()
        var left_most = 0

        // find left most and lowest point
        for i in 0..<n {
            if (trees[i][0] < trees[left_most][0])
            || (trees[i][0] == trees[left_most][0]
            && trees[i][1] < trees[left_most][1]) {
                left_most = i
            }
        }

        var p = left_most
        repeat {
            var q = (p+1) % n
            for i in 0..<n {
                if orientation(trees[p], trees[i], trees[q]) < 0 {
                    q = i
                }
            }

            for i in 0..<n {
                if i != p, i != q, orientation(trees[p], trees[i], trees[q]) == 0, inBetween(trees[p], trees[i], trees[q]) {
                    tSet.insert(trees[i])
                }
            }

            tSet.insert(trees[q])
            p = q
        } while p != left_most

        return Array(tSet)
    }

    // pq * qr > 0
    func orientation(_ p: [Int], _ q: [Int], _ r: [Int]) -> Int {
        return (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])
    }

    func inBetween(_ p: [Int], _ i: [Int], _ q: [Int]) -> Bool {
        let a = (i[0] - p[0]) * (i[0] - q[0]) <= 0
        let b = (i[1] - p[1]) * (i[1] - q[1]) <= 0
        return a && b
    }
}
