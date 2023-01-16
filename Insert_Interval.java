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
/**
 * Definition for an interval.
 * public class Interval {
 *     int start;
 *     int end;
 *     Interval() { start = 0; end = 0; }
 *     Interval(int s, int e) { start = s; end = e; }
 * }
 */
public class Solution {
    public List<Interval> insert(List<Interval> intervals, Interval newInterval) {
        int s = newInterval.start;
        int e = newInterval.end;

        List<Interval> left = new LinkedList<>(); //stroe intervals small than new interval
        List<Interval> right = new LinkedList<>(); //store intervals larger than new interval
        for(Interval i:intervals){
            if(i.end < s){ //small than new interval, store it into left part
                left.add(i);
            } else if(i.start > e){//large than new interval, store it into right part
                right.add(i);
            } else{
                s = Math.min(s, i.start);
                e = Math.max(e, i.end);
            }
        }

        left.add(new Interval(s,e));
        left.addAll(left.size(), right); //add from the end of left
        return left;
    }
}
