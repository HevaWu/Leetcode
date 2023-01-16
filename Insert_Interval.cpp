/*57. Insert Interval  QuestionEditorial Solution  My Submissions
Total Accepted: 68182 Total Submissions: 271472 Difficulty: Hard
Given a set of non-overlapping intervals, insert a new interval into the
intervals (merge if necessary).

You may assume that the intervals were initially sorted according to their start
times.

Example 1:
Given intervals [1,3],[6,9], insert and merge [2,5] in as [1,5],[6,9].

Example 2:
Given [1,2],[3,5],[6,7],[8,10],[12,16], insert and merge [4,9] in as
[1,2],[3,10],[12,16].

This is because the new interval [4,9] overlaps with [3,5],[6,7],[8,10].

This is because the new interval [4,9] overlaps with [3,5],[6,7],[8,10].

Hide Company Tags LinkedIn Google Facebook
Hide Tags Array Sort
Hide Similar Problems (H) Merge Intervals
*/

/*merge interval once
since only insert one interval, we mark "s" variable as start of new interval,
mark "e" variable as end of new interval
through comparing s to each single interval.end and by comparing e to each
single interval.start, we can know if this interval can be covered into new
interval, if it covered, we reset current s and e if it is not, the left part we
store into left vector, the right part we store into right vector at the end,
combine the left part, new interval and the right part as return  */
/**
 * Definition for an interval.
 * struct Interval {
 *     int start;
 *     int end;
 *     Interval() : start(0), end(0) {}
 *     Interval(int s, int e) : start(s), end(e) {}
 * };
 */
class Solution {
 public:
  vector<Interval> insert(vector<Interval>& intervals, Interval newInterval) {
    int s = newInterval.start;
    int e = newInterval.end;

    vector<Interval> left, right;
    for (Interval i : intervals) {
      if (i.end < s) {
        left.push_back(i);
      } else if (i.start > e) {
        right.push_back(i);
      } else {
        s = min(s, i.start);
        e = max(e, i.end);
      }
    }

    left.push_back(Interval(s, e));  // not new interval, just interval
    left.insert(left.end(), right.begin(), right.end());
    return left;
  }
};
