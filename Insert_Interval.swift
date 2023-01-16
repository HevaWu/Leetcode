/*
Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary).

You may assume that the intervals were initially sorted according to their start times.

Example 1:

Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
Output: [[1,5],[6,9]]
Example 2:

Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
Output: [[1,2],[3,10],[12,16]]
Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
NOTE: input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.
*/

/*
Solution 1:
set start and end for newinterval
store all interval less than newInterval to left
store all interval larger than newInterval to right
at the end, add

TimeComplexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var start: Int = newInterval[0]
        var end: Int = newInterval[1]

        var left = [[Int]]()
        var right = [[Int]]()

        for interval in intervals {
            if interval[1] < start {
                left.append(interval)
            } else if interval[0] > end {
                right.append(interval)
            } else {
                start = min(start, interval[0])
                end = max(end, interval[1])
            }
        }

        left.append([start, end])
        return left + right
    }
}
