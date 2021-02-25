/*
Given an integer array nums, you need to find one continuous subarray that if you only sort this subarray in ascending order, then the whole array will be sorted in ascending order.

Return the shortest such subarray and output its length.

 

Example 1:

Input: nums = [2,6,4,8,10,9,15]
Output: 5
Explanation: You need to sort [6, 4, 8, 10, 9] in ascending order to make the whole array sorted in ascending order.
Example 2:

Input: nums = [1,2,3,4]
Output: 0
Example 3:

Input: nums = [1]
Output: 0
 

Constraints:

1 <= nums.length <= 104
-105 <= nums[i] <= 105
 

Follow up: Can you solve it in O(n) time complexity?
*/

/*
Solution 2:

find `unsorted` array minEle, maxEle
then find start and end point

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        let n = nums.count

        // Note: init minEle from end of array, 
        // init maxEle from begin of array
        var minEle = nums[n-1]
        var maxEle = nums[0]
        
        var finded = false
        for i in 1..<n {
            if nums[i] < nums[i-1] {
                finded = true
            }
            if finded {
                minEle = min(minEle, nums[i])
            }
        }
        
        finded = false
        for i in stride(from: n-2, through: 0, by: -1) {
            if nums[i] > nums[i+1] {
                finded = true
            }
            if finded {
                maxEle = max(maxEle, nums[i])
            }
        }
        
        // print(minEle, maxEle)
        
        var s = 0
        var e = 0
        
        for i in 0..<n {
            if nums[i] > minEle {
                s = i
                break
            }
        }
        
        for i in stride(from: n-1, through: 0, by: -1) {
            if nums[i] < maxEle {
                e = i
                break
            }
        }
        
        return e-s > 0 ? e-s+1 : 0
    }
}

/*
Solution 1:
stack

use stack to memo current checked elements
1. find start (s)
  - from 0..<n, if nums[stack.last!] > nums[i], s = min(s, stack.removeLast())
2. find end (e)
  - from (n-1)...0, if nums[stack.last!] < nums[i], e = max(e, stack.removeLast())

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        let n = nums.count
        
        var stack = [Int]()
        var s = n
        var e = 0
        
        for i in 0..<n {
            while !stack.isEmpty, nums[stack.last!] > nums[i] {
                s = min(s, stack.removeLast())
            }
            stack.append(i)
        }
        
        stack = [Int]()
        for i in stride(from: n-1, through: 0, by: -1) {
            while !stack.isEmpty, nums[stack.last!] < nums[i] {
                e = max(e, stack.removeLast())
            }
            stack.append(i)
        }
        
        return e-s > 0 ? e-s+1 : 0
    }
}

