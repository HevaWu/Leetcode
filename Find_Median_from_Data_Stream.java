/*
Median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle value.

For example,
[2,3,4], the median is 3

[2,3], the median is (2 + 3) / 2 = 2.5

Design a data structure that supports the following two operations:

void addNum(int num) - Add a integer number from the data stream to the data structure.
double findMedian() - Return the median of all elements so far.


Example:

addNum(1)
addNum(2)
findMedian() -> 1.5
addNum(3)
findMedian() -> 2


Follow up:

If all integer numbers from the stream are between 0 and 100, how would you optimize it?
If 99% of all integer numbers from the stream are between 0 and 100, how would you optimize it?
*/

/*
Solution 1:
insert to correct position when addNum
findMedian() <- by directly checking the sorted list

Time complexity:
addNum: O(logn)
findMedian: O(1)
Space complexity: O(n)
*/

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

