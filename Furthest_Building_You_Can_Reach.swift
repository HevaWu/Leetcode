/*
You are given an integer array heights representing the heights of buildings, some bricks, and some ladders.

You start your journey from building 0 and move to the next building by possibly using bricks or ladders.

While moving from building i to building i+1 (0-indexed),

If the current building's height is greater than or equal to the next building's height, you do not need a ladder or bricks.
If the current building's height is less than the next building's height, you can either use one ladder or (h[i+1] - h[i]) bricks.
Return the furthest building index (0-indexed) you can reach if you use the given ladders and bricks optimally.



Example 1:


Input: heights = [4,2,7,6,9,14,12], bricks = 5, ladders = 1
Output: 4
Explanation: Starting at building 0, you can follow these steps:
- Go to building 1 without using ladders nor bricks since 4 >= 2.
- Go to building 2 using 5 bricks. You must use either bricks or ladders because 2 < 7.
- Go to building 3 without using ladders nor bricks since 7 >= 6.
- Go to building 4 using your only ladder. You must use either bricks or ladders because 6 < 9.
It is impossible to go beyond building 4 because you do not have any more bricks or ladders.
Example 2:

Input: heights = [4,12,2,7,3,18,20,3,19], bricks = 10, ladders = 2
Output: 7
Example 3:

Input: heights = [14,3,19,3], bricks = 17, ladders = 0
Output: 3


Constraints:

1 <= heights.length <= 105
1 <= heights[i] <= 106
0 <= bricks <= 109
0 <= ladders <= heights.length
*/

/*
Solution 1:
greedy

- memo pre needs, and always record pre largest steps
- each time, if total gap larger than bricks, put ladders on pre largest steps

Time Complexity: O(n log k)
- n is heights.count
- k is needs.count

Space Complexity: O(k)
*/
class Solution {
    func furthestBuilding(_ heights: [Int], _ bricks: Int, _ ladders: Int) -> Int {
        let n = heights.count
        if n == 1 { return 0 }
        var needs = [Int]()
        var total = 0
        var ladders = ladders
        for i in 1..<n {
            let gap = heights[i] - heights[i-1]
            if gap > 0 {
                // require bricks or ladders
                insert(&needs, gap)
                total += gap
            }

            if total > bricks {
                if ladders == 0 { return i-1 }
                ladders -= 1
                total -= needs.removeLast()
            }
        }

        return n-1
    }

    func insert(_ arr: inout [Int], _ target: Int) {
        if arr.isEmpty {
            arr.append(target)
            return
        }

        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        if arr[left] <= target {
            arr.insert(target, at: left+1)
        } else {
            arr.insert(target, at: left)
        }
    }
}
