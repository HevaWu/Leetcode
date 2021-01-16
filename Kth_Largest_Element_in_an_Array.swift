// Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.

// Example 1:

// Input: [3,2,1,5,6,4] and k = 2
// Output: 5
// Example 2:

// Input: [3,2,3,1,2,4,5,5,6] and k = 4
// Output: 4
// Note:
// You may assume k is always valid, 1 ≤ k ≤ array's length.

// Solution: Swift default function
// TimeComplexity: O(klogn)
// SpaceComplexity: O(n)
class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var sortedNums: [Int] = nums.sorted()
        return sortedNums[nums.count-k]
    }
}

// Solution 2: Heap
// The idea is to init a heap "the smallest element first", and add all elements from the array into this heap one by one keeping the size of the heap always less or equal to k. That would results in a heap containing k largest elements of the array.
// The head of this heap is the answer, i.e. the kth largest element of the array.
// The time complexity of adding an element in a heap of size k is \mathcal{O}(\log k)O(logk), and we do it N times that means \mathcal{O}(N \log k)O(Nlogk) time complexity for the algorithm.
// This algorithm improves time complexity, but one pays with \mathcal{O}(k)O(k) space complexity.

// Solution 3: QuickSort
// By setting a pivot, all of the elements in the left side are smaller than pivot, and in the right side if larger than pivot.
// 
// Time complexity : O(N) in the average case, O(N^2)in the worst case.
// Space complexity : O(n).
class Solution {
    var sorted = [Int]()
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        sorted = nums
        return check(0, nums.count - 1, nums.count - k)
    }
    
    func check(_ start: Int, _ end: Int, _ target: Int) -> Int {
        if start == end { return sorted[start] }
        var pivotIndex = start + Int.random(in: 0...(end-start))
        pivotIndex = quickSort(start, end, pivotIndex)
        
        if pivotIndex == target {
            return sorted[pivotIndex]
        } else if pivotIndex < target {
            return check(pivotIndex + 1, end, target)
        } else {
            return check(start, pivotIndex - 1, target)
        }
    }
    
    func quickSort(_ start: Int, _ end: Int, _ pivotIndex: Int) -> Int {
        // return after sorting pivot index
        let pivot = sorted[pivotIndex]
        
        // move pivot to the end
        sorted.swapAt(pivotIndex, end)
        
        var tempIndex = start
        for index in start...end {
            if sorted[index] < pivot {
                sorted.swapAt(tempIndex, index)
                tempIndex += 1
            }
        }

        // put pivot into correct place
        sorted.swapAt(tempIndex, end)

        return tempIndex
    }
}

/*
Solution 4: 
quick sort
optimize solution 3 by use one help function to do it

// Time complexity : O(N) in the average case, O(N^2)in the worst case.
// Space complexity : O(n).
*/
class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        // sort by >, 9,8,7, ... 
        // then we need to find nums[k-1]
        return quickSort(&nums, k-1, 0, nums.count-1)
    }
    
    func quickSort(_ nums: inout [Int], _ k: Int, _ start: Int, _ end: Int) -> Int {        
        if start == end { return nums[start] }
        
        let pivot = nums[end]
        var i = start
        var j = end-1
        while i < end, i <= j {
            if nums[i] < pivot {
                nums.swapAt(i, j)
                j -= 1
            } else {
                i += 1
            }
        }
        
        nums.swapAt(i, end)
        // print(pivot, nums)
        
        if i == k {
            // find num
            return nums[i]
        } else if i < k {
            // search right side
            return quickSort(&nums, k, i+1, end)
        } else {
            // search left side
            return quickSort(&nums, k, start, i-1)
        }
    }
}