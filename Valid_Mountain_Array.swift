/*
Given an array of integers arr, return true if and only if it is a valid mountain array.

Recall that arr is a mountain array if and only if:

arr.length >= 3
There exists some i with 0 < i < arr.length - 1 such that:
arr[0] < arr[1] < ... < arr[i - 1] < A[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

 

Example 1:

Input: arr = [2,1]
Output: false
Example 2:

Input: arr = [3,5,5]
Output: false
Example 3:

Input: arr = [0,3,2,1]
Output: true
 

Constraints:

1 <= arr.length <= 104
0 <= arr[i] <= 104
*/

/*
Solution 2:
seperate logic
use 2 while
*/
class Solution {
    func validMountainArray(_ arr: [Int]) -> Bool {
        let n = arr.count
        var index = 0
        while index < n-1, arr[index] < arr[index+1] {
            index += 1
        }
        
        if index == 0 || index == n-1 { return false }

        // find mountain top
        while index < n-1, arr[index] > arr[index+1] {
            index += 1
        }
        
        return index == n-1
    }
}

/*
Solution 1: 
check arr by order

Time Complexity: O(n)
*/
class Solution {
    func validMountainArray(_ arr: [Int]) -> Bool {
        guard arr.count >= 3 else { return false }
        var isIncrease = true
        
        // check if at first is decreasing
        if arr[0] >= arr[1] {
            return false
        }
        
        var cur = arr[1]
        for i in 2..<arr.count {
            if cur == arr[i] {
                return false
            }
            
            if isIncrease {
                if cur < arr[i] {
                    cur = arr[i]
                } else {
                    // update cur when switching flag
                    cur = arr[i]
                    isIncrease = false
                }
            } else {
                if cur > arr[i] {
                    cur = arr[i]
                } else {
                    return false
                }
            }
        }
        
        // check if keep increasing until end, if so, return false
        return !isIncrease
    }
}