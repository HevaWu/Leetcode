/*56. Merge Intervals  QuestionEditorial Solution  My Submissions
Total Accepted: 80949 Total Submissions: 300463 Difficulty: Hard
Given a collection of intervals, merge all overlapping intervals.

For example,
Given [1,3],[2,6],[8,10],[15,18],
return [1,6],[8,10],[15,18].

Subscribe to see which companies asked this question

Hide Company Tags LinkedIn Google Facebook Twitter Microsoft Bloomberg Yelp
Hide Tags Array Sort
Hide Similar Problems (H) Insert Interval (E) Meeting Rooms (M) Meeting Rooms II

*/



/*O(nlog(n))
1. sort the intervals according to their.start  takes O(nlog(n))
2. merging  takes O(n)
check if the former.end < next.start, if it is, it has overlap, combine them together
if not, insert the former interval into the return list*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
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
    vector<Interval> merge(vector<Interval>& intervals) {
        if(intervals.size() <= 1) return intervals;
        
        sort(intervals.begin(), intervals.end(), [](Interval i1, Interval i2){
            return i1.start < i2.start;
        });
        
        vector<Interval> ret;
        int s = intervals[0].start;
        int e = intervals[0].end;
        
        for(Interval i : intervals){
            if(i.start <= e){
                e = max(e, i.end); //remember max
            } else {
                ret.push_back(Interval(s, e));
                s = i.start;
                e = i.end;
            }
        }
        
        ret.push_back(Interval(s, e)); //push the last element 
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
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
    public List<Interval> merge(List<Interval> intervals) {
        if(intervals.size() <= 1) return intervals;
        
        //sort intervals according to their.start
        Collections.sort(intervals, new Comparator<Interval>(){
            @Override
            public int compare(Interval i1, Interval i2){
                return Integer.compare(i1.start, i2.start);
                //return i1.start-i2.start
            }
        });
        
        List<Interval> ret = new ArrayList<>(); //use ArrayList<>() faster than LinkedList<>()
        int s = intervals.get(0).start;
        int e = intervals.get(0).end;
        
        for(Interval i : intervals){
            if(i.start <= e){//overlap
                e = Math.max(e, i.end);
            } else { // add new interval into the return list
                ret.add(new Interval(s,e));
                s = i.start;
                e = i.end;
            }
        }
        
        ret.add(new Interval(s,e));//add the last interval
        
        return ret;
    }
}
