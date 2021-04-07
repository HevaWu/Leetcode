/*
Given a data stream input of non-negative integers a1, a2, ..., an, ..., summarize the numbers seen so far as a list of disjoint intervals.

For example, suppose the integers from the data stream are 1, 3, 7, 2, 6, ..., then the summary will be:

[1, 1]
[1, 1], [3, 3]
[1, 1], [3, 3], [7, 7]
[1, 3], [7, 7]
[1, 3], [6, 7]
Follow up:
What if there are lots of merges and the number of disjoint intervals are small compared to the data stream's size?

Credits:
Special thanks to @yunhong for adding this problem and creating most of the test cases.

Subscribe to see which companies asked this question
*/

/**
 * Definition for an interval.
 * struct Interval {
 *     int start;
 *     int end;
 *     Interval() : start(0), end(0) {}
 *     Interval(int s, int e) : start(s), end(e) {}
 * };
 */
class SummaryRanges {
public:
    /** Initialize your data structure here. */
    SummaryRanges() {

    }

    void addNum(int val) {
        auto cmp = [](Interval a, Interval b){return a.start<b.start;};
        auto it = lower_bound(inter.begin(), inter.end(), Interval(val,val), cmp);
        int start = val, end = val;
        if(it != inter.begin() && (it-1)->end+1>=val)
            it--;
        while(it!=inter.end() && val+1>=it->start && val-1<=it->end){
            start = min(start,it->start);
            end = max(end, it->end);
            it = inter.erase(it);
        }
        inter.insert(it,Interval(start,end));
    }

    vector<Interval> getIntervals() {
        return inter;
    }
private:
    vector<Interval> inter;
};

/**
 * Your SummaryRanges object will be instantiated and called as such:
 * SummaryRanges obj = new SummaryRanges();
 * obj.addNum(val);
 * vector<Interval> param_2 = obj.getIntervals();
 */





 ///////////////////////////////////////////////////////////////////////////////////
 //java
 /**
 * Definition for an interval.
 * public class Interval {
 *     int start;
 *     int end;
 *     Interval() { start = 0; end = 0; }
 *     Interval(int s, int e) { start = s; end = e; }
 * }
 */
public class SummaryRanges {

    /** Initialize your data structure here. */
    private TreeMap<Integer, Interval> mytree;
    public SummaryRanges() {
        mytree = new TreeMap<>();
    }

    public void addNum(int val) {
        if(mytree.containsKey(val))
            return;
        Integer low = mytree.lowerKey(val);
        Integer high = mytree.higherKey(val);
        if(low!=null && high!=null && mytree.get(low).end+1==val && high==val+1){
            mytree.get(low).end = mytree.get(high).end;
            mytree.remove(high);
        } else if(low!=null && mytree.get(low).end+1>=val){
            mytree.get(low).end = Math.max(mytree.get(low).end,val);
        } else if(high!=null && high==val+1){
            mytree.put(val, new Interval(val, mytree.get(high).end));
            mytree.remove(high);
        } else{
            mytree.put(val, new Interval(val,val));
        }
    }

    public List<Interval> getIntervals() {
        return new ArrayList<>(mytree.values());
    }
}

/**
 * Your SummaryRanges object will be instantiated and called as such:
 * SummaryRanges obj = new SummaryRanges();
 * obj.addNum(val);
 * List<Interval> param_2 = obj.getIntervals();
 */