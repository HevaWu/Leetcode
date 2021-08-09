/*
A k-booking happens when k events have some non-empty intersection (i.e., there is some time that is common to all k events.)

You are given some events [start, end), after each given event, return an integer k representing the maximum k-booking between all the previous events.

Implement the MyCalendarThree class:

MyCalendarThree() Initializes the object.
int book(int start, int end) Returns an integer k representing the largest integer such that there exists a k-booking in the calendar.


Example 1:

Input
["MyCalendarThree", "book", "book", "book", "book", "book", "book"]
[[], [10, 20], [50, 60], [10, 40], [5, 15], [5, 10], [25, 55]]
Output
[null, 1, 1, 2, 3, 3, 3]

Explanation
MyCalendarThree myCalendarThree = new MyCalendarThree();
myCalendarThree.book(10, 20); // return 1, The first event can be booked and is disjoint, so the maximum k-booking is a 1-booking.
myCalendarThree.book(50, 60); // return 1, The second event can be booked and is disjoint, so the maximum k-booking is a 1-booking.
myCalendarThree.book(10, 40); // return 2, The third event [10, 40) intersects the first event, and the maximum k-booking is a 2-booking.
myCalendarThree.book(5, 15); // return 3, The remaining events cause the maximum K-booking to be only a 3-booking.
myCalendarThree.book(5, 10); // return 3
myCalendarThree.book(25, 55); // return 3


Constraints:

0 <= start < end <= 109
At most 400 calls will be made to book.
*/

/*
Solution 2:
binary search
user record (index, height) to help tracking interval status

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class MyCalendarThree {
    var maxInter = 0
    var record = [(index: Int, height: Int)]()

    init() {

    }

    func book(_ start: Int, _ end: Int) -> Int {
        maxInter = max(maxInter, insert(start, end))
        // print(record)
        return maxInter
    }

    // insert start, end, return max interval between [start...end]
    func insert(_ start: Int, _ end: Int) -> Int {
        if record.isEmpty {
            record.append((start, 1))
            record.append((end, 0))
            return 1
        }

        // try to insert between s,e , and return current max Inter
        var cur = 1

        let s = getIndex(start)

        if s == record.count {
            // directly append start,end into end of record
            record.append((start, 1))
            record.append((end, 0))
            return 1
        }

        if record[s].index == start {
            record[s].height += 1
        } else {
            let preHeight = s > 0 ? record[s-1].height : 0
            record.insert((start, preHeight+1), at: s)
        }
        cur = max(cur, record[s].height)

        let e = getIndex(end)
        // print(e, record.count)
        for i in (s+1)..<e {
            record[i].height += 1
            cur = max(cur, record[i].height)
        }

        if e == record.count {
            record.append((end, 0))
            return cur
        }

        // record[e].index == end do nothing
        if record[e].index > end {
            // some index between start and end
            // -1 because i in ..<e +1 for it, for finding original height, -1
            record.insert((end, record[e-1].height-1), at: e)
        }

        return cur
    }

    // return should inserted at index
    func getIndex(_ target: Int) -> Int {
        if record.isEmpty {
            return 0
        }

        var left = 0
        var right = record.count-1
        while left < right {
            let mid = left + (right-left)/2
            if record[mid].index < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        return record[left].index < target ? left+1 : left
    }
}

/**
 * Your MyCalendarThree object will be instantiated and called as such:
 * let obj = MyCalendarThree()
 * let ret_1: Int = obj.book(start, end)
 */

/*
Solution 1:
map counter

When booking a new event [start, end), count delta[start]++ and delta[end]--. When processing the values of delta in sorted order of their keys, the largest such value is the answer.

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/

class MyCalendarThree {

    var map = [Int: Int]()
    var sortedKey = [Int]()

    init() {

    }

    func book(_ start: Int, _ end: Int) -> Int {
        if !map.keys.contains(start) {
            insert(start)
        }
        if !map.keys.contains(end) {
            insert(end)
        }

        map[start, default: 0] += 1
        map[end, default: 0] -= 1

        var res = 0
        var cur = 0
        for k in sortedKey {
            cur += map[k]!
            res = max(res, cur)
        }
        return res
    }

    func insert(_ index: Int) {
        if sortedKey.isEmpty {
            sortedKey.append(index)
            return
        }

        var left = 0
        var right = sortedKey.count-1
        while left < right {
            let mid = left + (right-left)/2
            if sortedKey[mid] < index {
                left = mid+1
            } else {
                right = mid
            }
        }

        sortedKey.insert(index, at: sortedKey[left] < index ? left+1 : left)
    }
}

/**
 * Your MyCalendarThree object will be instantiated and called as such:
 * let obj = MyCalendarThree()
 * let ret_1: Int = obj.book(start, end)
 */