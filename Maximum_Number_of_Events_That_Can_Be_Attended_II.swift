/*
You are given an array of events where events[i] = [startDayi, endDayi, valuei]. The ith event starts at startDayi and ends at endDayi, and if you attend this event, you will receive a value of valuei. You are also given an integer k which represents the maximum number of events you can attend.

You can only attend one event at a time. If you choose to attend an event, you must attend the entire event. Note that the end day is inclusive: that is, you cannot attend two events where one of them starts and the other ends on the same day.

Return the maximum sum of values that you can receive by attending events.



Example 1:



Input: events = [[1,2,4],[3,4,3],[2,3,1]], k = 2
Output: 7
Explanation: Choose the green events, 0 and 1 (0-indexed) for a total value of 4 + 3 = 7.
Example 2:



Input: events = [[1,2,4],[3,4,3],[2,3,10]], k = 2
Output: 10
Explanation: Choose event 2 for a total value of 10.
Notice that you cannot attend any other event as they overlap, and that you do not have to attend k events.
Example 3:



Input: events = [[1,1,1],[2,2,2],[3,3,3],[4,4,4]], k = 3
Output: 9
Explanation: Although the events do not overlap, you can only attend 3 events. Pick the highest valued three.


Constraints:

1 <= k <= events.length
1 <= k * events.length <= 106
1 <= startDayi <= endDayi <= 109
1 <= valuei <= 106
*/

/*
Solution 1:
TLE

DP
j = right bound of events[i][1]
dp[i][k] = max(dp[i+1][k], events[i][2] + dp[j][k-1])

Time Complexity: O(nklog(n))
Space Complexity: O(nk)
*/
class Solution {
    func maxValue(_ events: [[Int]], _ k: Int) -> Int {
        var events = events.sorted(by: {$0[0] < $1[0]})
        let n = events.count
        var cache = Array(repeating: Array(repeating: -1, count: k+1), count: n+1)
        return check(0, k, n, events, &cache)
    }

    func check(_ index: Int, _ k: Int, _ n: Int, _ events: [[Int]], _ cache: inout [[Int]]) -> Int {
        guard index < n, k > 0 else { return 0 }
        if cache[index][k] != -1 { return cache[index][k] }
        let nextIndex = findIndex(events[index][1], n, events)
        return max(
            check(index+1, k, n, events, &cache),
            events[index][2] + check(nextIndex, k-1, n, events, &cache)
        )
    }

    func findIndex(_ target: Int, _ n: Int, _ events: [[Int]]) -> Int {
        var l = 0
        var r = n-1
        while l < r {
            let mid = l + (r-l)/2
            if events[mid][0] <= target {
                l = mid+1
            } else {
                r = mid
            }
        }
        return events[l][0] <= target ? l+1 : l
    }
}
