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
    public int removeCoveredIntervals(int[][] intervals) {
        Arrays.sort(intervals, (i1, i2) -> {
            // first sort by left, then sort by decreasing right
            if (i1[0] == i2[0]) {
                return Integer.compare(i2[1], i1[1]);
            } else {
                return Integer.compare(i1[0], i2[0]);
            }
        });

        int cover = 0;
        int[] cur = intervals[0];
        for(int i = 1; i < intervals.length; i++) {
            if (intervals[i][1] <= cur[1]) {
                cover += 1;
            } else {
                cur = intervals[i];
            }
        }
        return intervals.length - cover;
    }
}