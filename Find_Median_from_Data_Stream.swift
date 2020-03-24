// Median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle value.

// For example,
// [2,3,4], the median is 3

// [2,3], the median is (2 + 3) / 2 = 2.5

// Design a data structure that supports the following two operations:

// void addNum(int num) - Add a integer number from the data stream to the data structure.
// double findMedian() - Return the median of all elements so far.
 

// Example:

// addNum(1)
// addNum(2)
// findMedian() -> 1.5
// addNum(3) 
// findMedian() -> 2
 

// Follow up:

// If all integer numbers from the stream are between 0 and 100, how would you optimize it?
// If 99% of all integer numbers from the stream are between 0 and 100, how would you optimize it?

// Solution 1: 
// insert to correct position when addNum
// findMedian() <- by directly checking the sorted list
// 
// Time complexity:
// addNum: O(logn)
// findMedian: O(1)
// Space complexity: O(n)
class MedianFinder {
    var list = [Int]()

    /** initialize your data structure here. */
    init() {
        
    }
    
    func addNum(_ num: Int) {
        if list.isEmpty { 
            list.append(num)
            return
        }
        
        var left = 0
        var right = list.count - 1
        while left < right {
            var mid = (left+right)/2
            if list[mid] <= num {
                left = mid + 1
            } else {
                right = mid
            }
        }
        
        // check list[left] > num
        list.insert(num, at: list[left] > num ? left : left + 1)
    }
    
    func findMedian() -> Double {
        guard !list.isEmpty else { return Double(0) }
        
        let n = list.count
        if n % 2 == 0 {
            return Double(list[n/2]+list[n/2-1]) / Double(2.0)
        } else {
            return Double(list[n/2])
        }
    }
}

/**
 * Your MedianFinder object will be instantiated and called as such:
 * let obj = MedianFinder()
 * obj.addNum(num)
 * let ret_2: Double = obj.findMedian()
 */