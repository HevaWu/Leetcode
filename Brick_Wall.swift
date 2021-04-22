/*
There is a brick wall in front of you. The wall is rectangular and has several rows of bricks. The bricks have the same height but different width. You want to draw a vertical line from the top to the bottom and cross the least bricks.

The brick wall is represented by a list of rows. Each row is a list of integers representing the width of each brick in this row from left to right.

If your line go through the edge of a brick, then the brick is not considered as crossed. You need to find out how to draw the line to cross the least bricks and return the number of crossed bricks.

You cannot draw a line just along one of the two vertical edges of the wall, in which case the line will obviously cross no bricks.



Example:

Input: [[1,2,2,1],
        [3,1,2],
        [1,3,2],
        [2,4],
        [3,1,2],
        [1,3,1,1]]

Output: 2

Explanation:



Note:

The width sum of bricks in different rows are the same and won't exceed INT_MAX.
The number of bricks in each row is in range [1,10,000]. The height of wall is in range [1,10,000]. Total number of bricks of the wall won't exceed 20,000.
*/

/*
Solution 1:
map

map - [space: how many row have this space]
Then check maximum rows contains this space,
return n-maxCount

Time Complexity: O(bricks count)
Space Complexity: O(wall widths)
*/
class Solution {
    func leastBricks(_ wall: [[Int]]) -> Int {
        let n = wall.count
        if n == 1 { return wall[0].count == 1 ? 1 : 0 }

        // [space: how many row have this space]
        var map = [Int: Int]()
        for row in wall {
            var space = 0
            for i in 0..<(row.count-1) {
                space += row[i]
                map[space, default: 0] += 1
            }
        }

        // maximum row contains same space
        var maxCount = 0
        for v in map.values {
            maxCount = max(maxCount, v)
        }
        return n - maxCount
    }
}