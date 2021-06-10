/*
Implement a MyCalendar class to store your events. A new event can be added if adding the event will not cause a double booking.

Your class will have the method, book(int start, int end). Formally, this represents a booking on the half open interval [start, end), the range of real numbers x such that start <= x < end.

A double booking happens when two events have some non-empty intersection (ie., there is some time that is common to both events.)

For each call to the method MyCalendar.book, return true if the event can be added to the calendar successfully without causing a double booking. Otherwise, return false and do not add the event to the calendar.

Your class will be called like this: MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)
Example 1:

MyCalendar();
MyCalendar.book(10, 20); // returns true
MyCalendar.book(15, 25); // returns false
MyCalendar.book(20, 30); // returns true
Explanation:
The first event can be booked.  The second can't because time 15 is already booked by another event.
The third event can be booked, as the first event takes every time less than 20, but not including 20.


Note:

The number of calls to MyCalendar.book per test case will be at most 1000.
In calls to MyCalendar.book(start, end), start and end are integers in the range [0, 10^9].

*/

/*
Solution 1:
sort interval
+binary search

Time Complexity: O(logn)
Space Complexity: O(n)
*/
class MyCalendar {

    // store by ascending order of start
    var event: [(start: Int, end: Int)]

    init() {
        event = [(start: Int, end: Int)]()
    }

    func book(_ start: Int, _ end: Int) -> Bool {
        if event.isEmpty {
            event.append((start, end))
            return true
        }

        var left = 0
        var right = event.count-1

        while left < right {
            let mid = left+(right-left)/2

            // print(event, left)
            if event[mid].end <= start {
                left = mid+1
            } else if event[mid].start >= end {
                right = mid
            } else {
                return false
            }
        }

        if event[left].end <= start || event[left].start >= end {
            event.insert((start, end), at: event[left].start < start ? left+1 : left)
            return true
        } else {
            return false
        }
    }
}

/**
 * Your MyCalendar object will be instantiated and called as such:
 * let obj = MyCalendar()
 * let ret_1: Bool = obj.book(start, end)
 */