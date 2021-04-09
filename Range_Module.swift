/*
A Range Module is a module that tracks ranges of numbers. Your task is to design and implement the following interfaces in an efficient manner.

addRange(int left, int right) Adds the half-open interval [left, right), tracking every real number in that interval. Adding an interval that partially overlaps with currently tracked numbers should add any numbers in the interval [left, right) that are not already tracked.
queryRange(int left, int right) Returns true if and only if every real number in the interval [left, right) is currently being tracked.
removeRange(int left, int right) Stops tracking every real number currently being tracked in the interval [left, right).
Example 1:
addRange(10, 20): null
removeRange(14, 16): null
queryRange(10, 14): true (Every number in [10, 14) is being tracked)
queryRange(13, 15): false (Numbers like 14, 14.03, 14.17 in [13, 15) are not being tracked)
queryRange(16, 17): true (The number 16 in [16, 17) is still being tracked, despite the remove operation)
Note:

A half open interval [left, right) denotes all real numbers left <= x < right.
0 < left < right < 10^9 in all calls to addRange, queryRange, removeRange.
The total number of calls to addRange in a single test case is at most 1000.p
The total number of calls to queryRange in a single test case is at most 5000.
The total number of calls to removeRange in a single test case is at most 1000.
*/

/*
Solution 1:
make (pos, height) intervals
when height = 1, means there is a valid range

Time Complexity: O(log(intervals.count) + K)
- K is r-l

Space Complexity: intervals.count
*/
class RangeModule {
    // height = 1 means a valid range
    var intervals: [(pos: Int, height: Int)]

    init() {
        intervals = [(pos: Int, height: Int)]()
    }

    func addRange(_ left: Int, _ right: Int) {
        // defer {
        //     print("add", left, right, intervals)
        // }

        if intervals.isEmpty {
            intervals.append((left, 1))
            intervals.append((right, 0))
            return
        }

        if intervals.first!.pos > right {
            intervals.insert((right, 0), at: 0)
            intervals.insert((left, 1), at:0)
            return
        }

        if intervals.last!.pos < left {
            intervals.append((left, 1))
            intervals.append((right, 0))
            return
        }

        let l = getIndex(left, true)
        let r = getIndex(right, false)

        if l == r {
            if l > 0, intervals[l-1].height == 1, intervals[l].pos >= right {
                // this range already added, ignore
                return
            }
        }

        // merge with previous one, if previous.height == 1
        if l > 0, intervals[l-1].height == 1 {
            if r > 0, intervals[r-1].height == 1 {
                intervals[l..<r] = []
            } else {
                intervals[l..<r] = [(right, intervals[r-1].height)]
            }
        } else {
            if r > 0, intervals[r-1].height == 1 {
                intervals[l..<r] = [(left, 1)]
            } else {
                intervals[l..<r] = [
                    (left, 1),
                    (right, intervals[r-1].height)
                ]
            }
        }
    }

    func queryRange(_ left: Int, _ right: Int) -> Bool {
        if intervals.isEmpty { return false }
        if intervals.last!.pos <= left { return false }
        if intervals.first!.pos >= right { return false }

        // for left, use isLeft false, and for right, use isLeft true
        // this will help checking if (left,right) are in same range
        let l = getIndex(left, false)
        let r = getIndex(right, true)

        // print("query", intervals, left, right, l, r)

        guard l == r else { return false }
        if intervals[l].pos == left {
            return intervals[l].height == 1
        } else {
            return l > 0 && intervals[l-1].height == 1
        }
    }

    func removeRange(_ left: Int, _ right: Int) {
//         defer {
//             print("remove", left, right, intervals)
//         }

        if intervals.isEmpty { return }
        if right <= intervals[0].pos { return }
        if left >= intervals.last!.pos { return }

        var l = getIndex(left, true)
        var r = getIndex(right, false)

        if l == r {
            // check if this remove range is in the addedRange
            if intervals[l].pos >= right, intervals[l].height == 1,
            (l > 0 && intervals[l-1].height == 0 && intervals[l-1].pos <= left) {
                // this range is not valid range now, don't need to do extra remove action
                return
            }
        }

        if l == 0 || (l > 0 && intervals[l-1].height == 0) {
            if r == intervals.count || (intervals[r].pos >= right && intervals[r].height == 1) {
                intervals[l..<r] = []
            } else {
                intervals[l..<r] = [(right, 1)]
            }
        } else if r < intervals.count, intervals[r].height == 1 {
            intervals[l..<r] = [(left, 0)]
        } else {
            if r == intervals.count {
                intervals[l..<r] = [(left, 0)]
            } else {
                intervals[l..<r] = [
                    (left, 0),
                    (right, 1)
                ]
            }
        }
    }

    func getIndex(_ target: Int, _ isLeft: Bool) -> Int {
        var left = 0
        var right = intervals.count-1

        while left < right {
            let mid = left + (right-left)/2
            if intervals[mid].pos < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        if intervals[left].pos == target {
            return isLeft ? left : left+1
        } else if intervals[left].pos < target {
            return left+1
        } else {
            return left
        }
    }
}

/**
 * Your RangeModule object will be instantiated and called as such:
 * let obj = RangeModule()
 * obj.addRange(left, right)
 * let ret_2: Bool = obj.queryRange(left, right)
 * obj.removeRange(left, right)
 */