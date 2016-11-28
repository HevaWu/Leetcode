/*362. Design Hit Counter   QuestionEditorial Solution  My Submissions
Total Accepted: 6017 Total Submissions: 11731 Difficulty: Medium Contributors: Admin
Design a hit counter which counts the number of hits received in the past 5 minutes.

Each function accepts a timestamp parameter (in seconds granularity) and you may assume that calls are being made to the system in chronological order (ie, the timestamp is monotonically increasing). You may assume that the earliest timestamp starts at 1.

It is possible that several hits arrive roughly at the same time.

Example:
HitCounter counter = new HitCounter();

// hit at timestamp 1.
counter.hit(1);

// hit at timestamp 2.
counter.hit(2);

// hit at timestamp 3.
counter.hit(3);

// get hits at timestamp 4, should return 3.
counter.getHits(4);

// hit at timestamp 300.
counter.hit(300);

// get hits at timestamp 300, should return 4.
counter.getHits(300);

// get hits at timestamp 301, should return 3.
counter.getHits(301); 
Follow up:
What if the number of hits per second could be very large? Does your design scale?

Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags Dropbox Google
Hide Tags Design
Hide Similar Problems (E) Logger Rate Limiter
*/



/* O(s) s is total seconds in given time interval, in this case 300

solution 1: using array
one bucket for one second, we only need to keep the recent hits info for 300 seconds,
which is 5 minutes
time[] bucket record current time, if it is no current time, means it is 300s or 600s
hit(timestamp) --- 
getHits(timestamp) --- 

solution 2: using queue which implemented linkedlist
use a queue to record the information of all hits,
each time call getHits() we delete the elements which hits beyond 5 mins(300 secons)
The result would be the length of the queue
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class HitCounter {
//solution 1
private:
    vector<int> times;
    vector<int> hits;
    
public:
    /** Initialize your data structure here. */
    HitCounter() {
        times.resize(300);
        hits.resize(300);
    }
    
    /** Record a hit.
        @param timestamp - The current timestamp (in seconds granularity). */
    void hit(int timestamp) {
        int index = timestamp % 300;
        if(times[index] != timestamp){
            times[index] = timestamp;
            hits[index] = 1;
        } else {
            hits[index] ++ ;
        }
    }
    
    /** Return the number of hits in the past 5 minutes.
        @param timestamp - The current timestamp (in seconds granularity). */
    int getHits(int timestamp) {
        int ret = 0;
        for(int i = 0; i < 300; ++i){
            if(timestamp-times[i] < 300){
                ret += hits[i];
            }
        }
        return ret;
    }
};

/**
 * Your HitCounter object will be instantiated and called as such:
 * HitCounter obj = new HitCounter();
 * obj.hit(timestamp);
 * int param_2 = obj.getHits(timestamp);
 */




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class HitCounter {
    //solution 1
    private int[] times;
    private int[] hits;

    /** Initialize your data structure here. */
    public HitCounter() {
        times = new int[300];
        hits = new int[300];
    }
    
    /** Record a hit.
        @param timestamp - The current timestamp (in seconds granularity). */
    public void hit(int timestamp) {
        int index = timestamp % 300; 
        if(times[index] != timestamp){
            //check if this timestamp is in 300 seconds
            times[index] = timestamp;
            hits[index] = 1;
        } else {
            hits[index]++;
        }
    }
    
    /** Return the number of hits in the past 5 minutes.
        @param timestamp - The current timestamp (in seconds granularity). */
    public int getHits(int timestamp) {
        int ret = 0;
        for(int i = 0; i < 300; ++i){
            if(timestamp - times[i] < 300){
                ret += hits[i];
            }
        }
        return ret;
    }
}

/**
 * Your HitCounter object will be instantiated and called as such:
 * HitCounter obj = new HitCounter();
 * obj.hit(timestamp);
 * int param_2 = obj.getHits(timestamp);
 */




public class HitCounter {
    //solution 2
    private Queue<Integer> Q;

    /** Initialize your data structure here. */
    public HitCounter() {
        Q = new LinkedList<>();
    }
    
    /** Record a hit.
        @param timestamp - The current timestamp (in seconds granularity). */
    public void hit(int timestamp) {
        //push timestamp into queue
        Q.offer(timestamp);
    }
    
    /** Return the number of hits in the past 5 minutes.
        @param timestamp - The current timestamp (in seconds granularity). */
    public int getHits(int timestamp) {
        //check if each timestamp is in 300 seconds
        while(!Q.isEmpty() && timestamp-Q.peek() >= 300){
            //remember >=
            // System.out.println(Q.peek());
            Q.poll();
        }
        return Q.size();
    }
}

/**
 * Your HitCounter object will be instantiated and called as such:
 * HitCounter obj = new HitCounter();
 * obj.hit(timestamp);
 * int param_2 = obj.getHits(timestamp);
 */