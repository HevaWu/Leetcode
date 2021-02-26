/*
Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

Example:

Input:  [1,2,3,4]
Output: [24,12,8,6]
Constraint: It's guaranteed that the product of the elements of any prefix or suffix of the array (including the whole array) fits in a 32 bit integer.

Note: Please solve it without division and in O(n).

Follow up:
Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose of space complexity analysis.)
*/

/*
Solution 2
optimize solution 1 
only use one space to handle it

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n = nums.count
        
        var res = Array(repeating: 0, count: n)
        res[0] = 1        
        for i in 1..<n {
            res[i] = nums[i-1] * res[i-1]
        }
        
        var R = 1
        for i in stride(from: n-1, through: 0, by: -1) {
            res[i] *= R
            R = R*nums[i]
        }
        
        return res
    }
}

/*
Solution 1: 
2 array 

product: a*b
left array is product of whole left elements
right array is product of whole right elements 

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n = nums.count
        
        var left = Array(repeating: 0, count: n)
        var right = Array(repeating: 0, count: n)
        
        left[0] = 1
        for i in 1..<n {
            left[i] = nums[i-1] * left[i-1]
        }
        
        right[n-1] = 1
        for i in stride(from: n-2, through: 0, by: -1) {
            right[i] = right[i+1] * nums[i+1]
        }
        
        var res = Array(repeating: 0, count: n)
        for i in 0..<n {
            res[i] = left[i] * right[i]
        }
        
        return res
    }
}