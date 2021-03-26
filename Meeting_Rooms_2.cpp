/*253. Meeting Rooms II  QuestionEditorial Solution  My Submissions
Total Accepted: 19103 Total Submissions: 51279 Difficulty: Medium
Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), find the minimum number of conference rooms required.

For example,
Given [[0, 30],[5, 10],[15, 20]],
return 2.

Hide Company Tags Google Snapchat Facebook
Hide Tags Heap Greedy Sort
Hide Similar Problems (H) Merge Intervals (E) Meeting Rooms
*/



/* o(n)
rooms --- count how many room we need
int[] starts --- store the start for each intervals
int[] ends --- store end for each intervals

seperately sort starts and ends

for example, we have meetings that span along time as follows:
|_____|
      |______|
|________|
        |_______|
Then, the start time array and end time array after sorting appear like follows:
||    ||
     |   |   |  |
startIndex points to the start, endIndex points to the end
once startIndex < endIndex, increase a room, startIndex++
otherwise moved the newly started meeting into that vacant room, thus we don’t need to increment rooms at this time and move both of the pointers forward.*/

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
    int minMeetingRooms(vector<Interval>& intervals) {
        if(intervals.size()<1) return intervals.size();

        int n = intervals.size();
        vector<int> starts(n);
        vector<int> ends(n);

        //store all intervals starts and ends
        for(Interval i:intervals){
            starts.push_back(i.start);
            ends.push_back(i.end);
        }

        //sort starts and ends
        sort(starts.begin(), starts.end());
        sort(ends.begin(), ends.end());

        int rooms = 0; //count the rooms we need
        int e = 0; //end index
        for(int s = 0; s < starts.size(); ++s){
            //s is start index
            if(starts[s] < ends[e]){
                //build a new root
                rooms++;
            } else {
                //keep current room, move end index
                e++;
            }
        }
        return rooms;
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
    public int minMeetingRooms(Interval[] intervals) {
        if(intervals.length < 1) return intervals.length;

        int n = intervals.length;
        int[] starts = new int[n];
        int[] ends = new int[n];

        //store all starts and ends of intervals
        for(int i = 0; i < n; ++i){
            starts[i] = intervals[i].start;
            ends[i] = intervals[i].end;
        }

        //sort starts and ends
        Arrays.sort(starts);
        Arrays.sort(ends);

        int rooms = 0; //store the number of rooms we need
        int e = 0; //index of ends
        for(int s = 0; s < starts.length; ++s){
            // s is index of starts
            if(starts[s] < ends[e]){
                //create a new room
                rooms++;
            } else {
                //keep current rooms, and move end index
                e++;
            }
        }
        return rooms;
    }
}


/*use min heap O(nlogn) --- use priority queue
sort intervals according to their start
use a min heap to track the minimum end time of merged intervals
start with the first interval, put it into heap
if cur.start >= heap.poll.end, merge two interval, no need to open new room
else open a new room
return heap.size()
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
    public int minMeetingRooms(Interval[] intervals) {
        if(intervals.length < 1) return intervals.length;

        //sort intervals according their start
        Arrays.sort(intervals, new Comparator<Interval>(){
           public int compare(Interval a, Interval b){
               return a.start-b.start;
           }
        });

        //build a heap for room
        PriorityQueue<Interval> room = new PriorityQueue<>(intervals.length,
            new Comparator<Interval>(){
                public int compare(Interval a, Interval b){
                    return a.end-b.end;
                }
            });

        room.offer(intervals[0]);
        for(int i = 1; i < intervals.length; ++i){
            Interval temp = room.poll();
            if(intervals[i].start >= temp.end){ //remember >= not >
                //merge two intervals, no need to open new room
                temp.end = intervals[i].end;
            } else {
                //open a new room for this intervals
                room.offer(intervals[i]);
            }
            room.offer(temp); //remember to put the temp back to room queue
        }

        return room.size();
    }
}