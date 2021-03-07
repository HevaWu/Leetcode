/*
Given an integer array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

You may assume the input array always has a valid answer.

 

Example 1:

Input: nums = [1,5,1,1,6,4]
Output: [1,6,1,5,1,4]
Explanation: [1,4,1,5,1,6] is also accepted.
Example 2:

Input: nums = [1,3,2,2,3,1]
Output: [2,3,1,3,1,2]
 

Constraints:

1 <= nums.length <= 5 * 104
0 <= nums[i] <= 5000
It is guaranteed that there will be an answer for the given input nums.
 

Follow Up: Can you do it in O(n) time and/or in-place with O(1) extra space?
*/

/*
Solution 2:
sort
then
put element from largest to smallest

put larger element at index 1,3,5
put remaining element at index 0,2,4

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func wiggleSort(_ nums: inout [Int]) {
        if nums.count == 1 { return }
        let n = nums.count
        
        var temp = nums.sorted(by: { $0 > $1 })
        
        var oddIndex = 0
        while oddIndex * 2 + 1 < n {
            nums[oddIndex*2 + 1] = temp[oddIndex]
            oddIndex += 1
        }
        
        var evenIndex = 0
        while evenIndex*2 < n {
            nums[evenIndex*2] = temp[oddIndex]
            oddIndex += 1
            evenIndex += 1
        }
    }
}

/*
Solution 1:

https://leetcode.com/explore/interview/card/top-interview-questions-hard/120/sorting-and-searching/857/discuss/77677/O(n)+O(1)-after-median-Virtual-Indexing

mapping of subscript, from 0~mid to odd numbers(1,3,5,7...), and from mid+1~n-1 to even numbers(0,2,4,6...). So the big numbers which formerly in 0~mid will be placed in 1,3,5,7..., and small numbers in 0,2,4,6....

virtualIndex
Accessing A(0) actually accesses nums[1].
Accessing A(1) actually accesses nums[3].
Accessing A(2) actually accesses nums[5].
Accessing A(3) actually accesses nums[7].
Accessing A(4) actually accesses nums[9].
Accessing A(5) actually accesses nums[0].
Accessing A(6) actually accesses nums[2].
Accessing A(7) actually accesses nums[4].
Accessing A(8) actually accesses nums[6].
Accessing A(9) actually accesses nums[8]

Time Complexity: O(n)
Space Complexity: O(1)
*/

class Solution {
    func wiggleSort(_ nums: inout [Int]) {
        if nums.count == 1 { return }
        
        let n = nums.count
        var midEle = findKthLargest(nums, (n+1)/2)
        
        // print(midEle)
        
        var virtualIndex: (Int) -> Int = { index -> Int in
            return (1 + 2*index) % (n|1)
        }
        
        var left = 0
        var right = n-1
        var i = 0
        
        while i <= right {
            // print(virtualIndex(i), i, left, right, nums)
            
            if nums[virtualIndex(i)] > midEle {
                nums.swapAt(virtualIndex(i), virtualIndex(left))
                left += 1
                i += 1
            } else if nums[virtualIndex(i)] < midEle {
                nums.swapAt(virtualIndex(i), virtualIndex(right))
                right -= 1
            } else {
                i += 1
            }
        }
    }
    
    // ====== findKthLargest ======
    
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        return check(&nums, k, 0, nums.count-1)
    }
    
    func check(_ nums: inout [Int], _ k: Int, _ start: Int, _ end: Int) -> Int {
        if start == end { return nums[start] }
        var pivotIndex = start + Int.random(in: 0...(end-start))
        pivotIndex = quickSort(&nums, start, end, pivotIndex)
        
        if pivotIndex == k {
            return nums[pivotIndex]
        } else if pivotIndex < k {
            return check(&nums, k, pivotIndex+1, end)
        } else {
            return check(&nums, k, start, pivotIndex-1)
        }
    }
    
    func quickSort(_ nums: inout[Int], _ start: Int, _ end: Int, _ pivotIndex: Int) -> Int {
        let pivot = nums[pivotIndex]
        nums.swapAt(pivotIndex, end)
        
        var tempIndex = start
        for i in start...end {
            if nums[i] < pivot {
                nums.swapAt(tempIndex, i)
                tempIndex += 1
            }
        }
        nums.swapAt(tempIndex, end)
        return tempIndex
    }
}