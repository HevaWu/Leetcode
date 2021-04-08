/*
On an infinite number line (x-axis), we drop given squares in the order they are given.

The i-th square dropped (positions[i] = (left, side_length)) is a square with the left-most point being positions[i][0] and sidelength positions[i][1].

The square is dropped with the bottom edge parallel to the number line, and from a higher height than all currently landed squares. We wait for each square to stick before dropping the next.

The squares are infinitely sticky on their bottom edge, and will remain fixed to any positive length surface they touch (either the number line or another square). Squares dropped adjacent to each other will not stick together prematurely.


Return a list ans of heights. Each height ans[i] represents the current highest height of any square we have dropped, after dropping squares represented by positions[0], positions[1], ..., positions[i].

Example 1:

Input: [[1, 2], [2, 3], [6, 1]]
Output: [2, 5, 5]
Explanation:
After the first drop of positions[0] = [1, 2]: _aa _aa ------- The maximum height of any square is 2.

After the second drop of positions[1] = [2, 3]: __aaa __aaa __aaa _aa__ _aa__ -------------- The maximum height of any square is 5. The larger square stays on top of the smaller square despite where its center of gravity is, because squares are infinitely sticky on their bottom edge.

After the third drop of positions[1] = [6, 1]: __aaa __aaa __aaa _aa _aa___a -------------- The maximum height of any square is still 5. Thus, we return an answer of [2, 5, 5].




Example 2:

Input: [[100, 100], [200, 100]]
Output: [100, 100]
Explanation: Adjacent squares don't get stuck prematurely - only their bottom edge can stick to surfaces.


Note:

1 <= positions.length <= 1000.
1 <= positions[i][0] <= 10^8.
1 <= positions[i][1] <= 10^6.

*/

/*
Solution 1:
similar to skyline problem

use pos to record x-coordinate
use height to record y-coordinate

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func fallingSquares(_ positions: [[Int]]) -> [Int] {
        // [leftMost x, curMaxHeight]
        var height = [0]
        var pos = [0]

        var maxHeight = 0
        var res = [Int]()
        for p in positions {
            let left = p[0]
            let side = p[1]

            let i = insert(left, pos, true)
            let j = insert(left+side, pos, false)
            // print(i, j, left, left+side)

            var high = 0
            for k in (i-1)..<j {
                high = max(high, height[k])
            }
            high += side

            pos[i..<j] = [left, left+side]
            height[i..<j] = [high, height[j-1]]

            maxHeight = max(maxHeight, high)
            res.append(maxHeight)

            // print(pos, height)
        }
        return res
    }

    // isLeft:
    // true if target exist, return left insert point
    // flase if target exist, return right insert point
    func insert(_ target: Int, _ nums: [Int], _ isLeft: Bool) -> Int {
        if nums.isEmpty { return 0 }
        var left = 0
        var right = nums.count-1
        while left < right {
            let mid = left + (right-left)/2
            if nums[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        // print("insert", left, nums, target)

        if nums[left] == target {
            return isLeft ? left + 1 : left
        } else if nums[left] < target {
            return left + 1
        } else {
            return left
        }
    }
}