/*
Given an array intervals where intervals[i] = [li, ri] represent the interval [li, ri), remove all intervals that are covered by another interval in the list.

The interval [a, b) is covered by the interval [c, d) if and only if c <= a and b <= d.

Return the number of remaining intervals.



Example 1:

Input: intervals = [[1,4],[3,6],[2,8]]
Output: 2
Explanation: Interval [3,6] is covered by [2,8], therefore it is removed.
Example 2:

Input: intervals = [[1,4],[2,3]]
Output: 1


Constraints:

1 <= intervals.length <= 1000
intervals[i].length == 2
0 <= li <= ri <= 105
All the given intervals are unique.
*/

/*
Solution 2:
optimize solution 1

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func removeCoveredIntervals(_ intervals: [[Int]]) -> Int {
        let n = intervals.count
        if n <= 1 {
            return n
        }

        var intervals = intervals.sorted(by: {
            // sort by
            // increasing left
            // then decreading right
            $0[0] == $1[0] ? $0[1] > $1[1] : $0[0] < $1[0]
        })

        var cover = 0
        var cur = intervals[0]
        for i in 1..<n {
            if intervals[i][1] <= cur[1] {
                cover += 1
            } else {
                cur = intervals[i]
            }
        }

        return n - cover
    }
}

/*
Solution 1:
sort intervals
check each interval is coverred by is left neighbor or right neighbor, if covered, remove it

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func removeCoveredIntervals(_ intervals: [[Int]]) -> Int {
        let n = intervals.count
        if n <= 1 {
            return n
        }

        var intervals = intervals.sorted(by: {
            $0[0] == $1[0] ? $0[1] < $1[1] : $0[0] < $1[0]
        })

        var index = 0
        while index < intervals.count {
            if index > 0, intervals[index][1] <= intervals[index-1][1] {
                intervals.remove(at: index)
            } else if index+1 < intervals.count, intervals[index+1][0] == intervals[index][0], intervals[index+1][1] >= intervals[index][1] {
                intervals.remove(at: index)
            } else {
                index += 1
            }
        }
        return intervals.count
    }
}