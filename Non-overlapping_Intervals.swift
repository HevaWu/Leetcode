/*
Given an array of intervals intervals where intervals[i] = [starti, endi], return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.



Example 1:

Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
Output: 1
Explanation: [1,3] can be removed and the rest of the intervals are non-overlapping.
Example 2:

Input: intervals = [[1,2],[1,2],[1,2]]
Output: 2
Explanation: You need to remove two [1,2] to make the rest of the intervals non-overlapping.
Example 3:

Input: intervals = [[1,2],[2,3]]
Output: 0
Explanation: You don't need to remove any of the intervals since they're already non-overlapping.


Constraints:

1 <= intervals.length <= 105
intervals[i].length == 2
-5 * 104 <= starti < endi <= 5 * 104
*/

/*
Solution 1:
find maximum non-overlapping Intervals
return n-maximumNonOverlapping

sort intervals by end
then iterate intervals to check overlapping count

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        // sort by end
        var intervals = intervals.sorted(by: { first, second -> Bool in
            return first[1] < second[1]
        })

        let n = intervals.count

        // find maximum non-overlapping intervals
        var count = 1
        var end = intervals[0][1]

        for i in 1..<n {
            if intervals[i][0] >= end {
                end = intervals[i][1]
                count += 1
            }
        }
        return n-count
    }
}