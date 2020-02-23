// Implement a MyCalendarTwo class to store your events. A new event can be added if adding the event will not cause a triple booking.

// Your class will have one method, book(int start, int end). Formally, this represents a booking on the half open interval [start, end), the range of real numbers x such that start <= x < end.

// A triple booking happens when three events have some non-empty intersection (ie., there is some time that is common to all 3 events.)

// For each call to the method MyCalendar.book, return true if the event can be added to the calendar successfully without causing a triple booking. Otherwise, return false and do not add the event to the calendar.

// Your class will be called like this: MyCalendar cal = new MyCalendar(); MyCalendar.book(start, end)
// Example 1:

// MyCalendar();
// MyCalendar.book(10, 20); // returns true
// MyCalendar.book(50, 60); // returns true
// MyCalendar.book(10, 40); // returns true
// MyCalendar.book(5, 15); // returns false
// MyCalendar.book(5, 10); // returns true
// MyCalendar.book(25, 55); // returns true
// Explanation: 
// The first two events can be booked.  The third event can be double booked.
// The fourth event (5, 15) can't be booked, because it would result in a triple booking.
// The fifth event (5, 10) can be booked, as it does not use time 10 which is already double booked.
// The sixth event (25, 55) can be booked, as the time in [25, 40) will be double booked with the third event;
// the time [40, 50) will be single booked, and the time [50, 55) will be double booked with the second event.
 

// Note:

// The number of calls to MyCalendar.book per test case will be at most 1000.
// In calls to MyCalendar.book(start, end), start and end are integers in the range [0, 10^9].

// Hint
// Store two sorted lists of intervals: one list will be all times that are at least single booked, and another list will be all times that are definitely double booked. If none of the double bookings conflict, then the booking will succeed, and you should update your single and double bookings accordingly.

// Solution 1: 2 array
// Evidently, two events [s1, e1) and [s2, e2) do not conflict if and only if one of them starts after the other one ends: either e1 <= s2 OR e2 <= s1. By De Morgan's laws, this means the events conflict when s1 < e2 AND s2 < e1.
// If our event conflicts with a double booking, it's invalid. Otherwise, we add conflicts with the calendar to our double bookings, and add the event to our calendar.
// 
// Time Complexity: O(N^2), where NN is the number of events booked. For each new event, we process every previous event to decide whether the new event can be booked. This leads to \sum_k^N O(k) = O(N^2) complexity.
// Space Complexity: O(N)O(N), the size of the calendar.
class MyCalendarTwo {
    var firstBook = [(Int, Int)]()
    var secondBook = [(Int, Int)]()
    
    init() {
        
    }
    
    func book(_ start: Int, _ end: Int) -> Bool {
        for i in secondBook {
            if i.0 < end, i.1 > start {
                return false
            }
        }
        for i in firstBook {
            if i.0 < end, i.1 > start {
                secondBook.append((max(i.0, start), min(i.1, end)))
            }
        }
        firstBook.append((start, end))
        return true
    }
}

/**
 * Your MyCalendarTwo object will be instantiated and called as such:
 * let obj = MyCalendarTwo()
 * let ret_1: Bool = obj.book(start, end)
 */

// Solution 2: treemap
// When booking a new event [start, end), count delta[start]++ and delta[end]--. When processing the values of delta in sorted order of their keys, the running sum active is the number of events open at that time. If the sum is 3 or more, that time is (at least) triple booked.
// 
// Time Complexity: O(N^2), where NN is the number of events booked. For each new event, we traverse delta in O(N)O(N) time.
// Space Complexity: O(N)O(N), the size of delta.