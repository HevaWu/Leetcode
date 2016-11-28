/*295. Find Median from Data Stream  QuestionEditorial Solution  My Submissions
Total Accepted: 21475
Total Submissions: 94825
Difficulty: Hard
Median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle value.

Examples: 
[2,3,4] , the median is 3

[2,3], the median is (2 + 3) / 2 = 2.5

Design a data structure that supports the following two operations:

void addNum(int num) - Add a integer number from the data stream to the data structure.
double findMedian() - Return the median of all elements so far.
For example:

add(1)
add(2)
findMedian() -> 1.5
add(3) 
findMedian() -> 2

Credits:
Special thanks to @Louis1992 for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Heap Design

*/




/*I keep two heaps (or priority queues):

small-heap small has the smaller half of the numbers.
large-heap large has the larger half of the numbers.

always let small.size() > large.size()
This gives me direct access to the one or two middle values (they're the tops of the heaps), so getting the median takes O(1) time. And adding a number takes O(log n) time.

Supporting both min- and max-heap is more or less cumbersome, depending on the language, so I simply negate the numbers in the heap in which I want the reverse of the default order. To prevent this from causing a bug with -231 (which negated is itself, when using 32-bit ints), I use integer types larger than 32 bits.

Using larger integer types also prevents an overflow error when taking the mean of the two middle numbers. I think almost all solutions posted previously have that bug.
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class MedianFinder {
private:
    priority_queue<long> small, large;
    
public:

    // Adds a number into the data structure.
    void addNum(int num) {
        small.push(num);
        large.push(-small.top());
        small.pop();
        if(small.size() < large.size()){
            small.push(-large.top());
            large.pop();
        }
    }

    // Returns the median of current data stream
    double findMedian() {
        return small.size() > large.size() ? small.top() : (small.top()-large.top())/2.0;
    }
};

// Your MedianFinder object will be instantiated and called as such:
// MedianFinder mf;
// mf.addNum(1);
// mf.findMedian();







/////////////////////////////////////////////////////////////////////////////////////
//Java
public class MedianFinder {
    private Queue<Long> small = new PriorityQueue();
    private Queue<Long> large = new PriorityQueue();

    // Adds a number into the data structure.
    public void addNum(int num) {
        large.add((long) num); //remember (long)
        small.add(-large.poll());
        if(large.size() < small.size()){
            large.add(-small.poll());
        }
    }

    // Returns the median of current data stream
    public double findMedian() {
        return large.size() > small.size() ? large.peek() : (large.peek()-small.peek())/2.0;
    }
};

// Your MedianFinder object will be instantiated and called as such:
// MedianFinder mf = new MedianFinder();
// mf.addNum(1);
// mf.findMedian();