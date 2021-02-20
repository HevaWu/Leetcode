// Given a collection of intervals, merge all overlapping intervals.

// Example 1:

// Input: [[1,3],[2,6],[8,10],[15,18]]
// Output: [[1,6],[8,10],[15,18]]
// Explanation: Since intervals [1,3] and [2,6] overlaps, merge them into [1,6].
// Example 2:

// Input: [[1,4],[4,5]]
// Output: [[1,5]]
// Explanation: Intervals [1,4] and [4,5] are considered overlapping.
// NOTE: input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.

/*
Solution 2
optimize solution 1 at sort
*/
class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard !intervals.isEmpty else { return [[Int]]() }
        
        var intervals = intervals.sorted(by: { first, second -> Bool in
            return first[0] < second[0]
        })
        
        var res = [[Int]]()
        var start = intervals[0][0]
        var end = intervals[0][1]
        for interval in intervals {
            if interval[0] <= end {
                end = max(end, interval[1])
            } else {
                res.append([start, end])
                start = interval[0]
                end = interval[1]
            }
        }
    
        res.append([start, end])
        return res
    }
}

// Solution 1: 
// sort the array by start point first, then merge them by the end 
// 
// Time complexity: O(n\log{}n)O(nlogn) Other than the sort invocation, we do a simple linear scan of the list, so the runtime is dominated by the O(nlgn)O(nlgn) complexity of sorting.
// Space complexity : O(1)O(1) (or O(n)O(n))If we can sort intervals in place, we do not need more than constant additional space. Otherwise, we must allocate linear space to store a copy of intervals and sort that.
class Solution {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard !intervals.isEmpty else { return [[Int]]() }
        
        // sort according to start 
        var intervals = intervals
        intervals.sort { (first, second) -> Bool in 
            first[0] < second[0]
        }
        
        // pair list, (s,e) where s is start, e is end
        var list = [[Int]]()
        var start = intervals[0][0]
        var end = intervals[0][1]
        
        for interval in intervals {
            if interval[0] <= end {
                end = max(end, interval[1])
            } else {
                list.append([start, end])
                start = interval[0]
                end = interval[1]
            }
        }
        list.append([start, end])
        return list
    }
}