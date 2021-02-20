/*
Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.

 

Example 1:

Input: nums = [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
Example 2:

Input: nums = [2,0,1]
Output: [0,1,2]
Example 3:

Input: nums = [0]
Output: [0]
Example 4:

Input: nums = [1]
Output: [1]
 

Constraints:

n == nums.length
1 <= n <= 300
nums[i] is 0, 1, or 2.
 

Follow up:

Could you solve this problem without using the library's sort function?
Could you come up with a one-pass algorithm using only O(1) constant space?
*/

/*
Solution 2
one pass

use index to control current checked element
left record 0
right record 2

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func sortColors(_ nums: inout [Int]) {
        let n = nums.count
        var left = 0
        var right = n-1
        var index = 0
        
        // use <= here, in case forget check right again
        while index <= right {
            if nums[index] == 0 {
                nums.swapAt(index, left)
                left += 1
            } else if nums[index] == 2 {
                nums.swapAt(index, right)
                right -= 1
                // use continue to avoid miss update element
                continue
            }
            index += 1
        }
    }
}

/*
Solution 1
keep r, w, b
record how many times it appears in nums

then iteratively update nums val

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func sortColors(_ nums: inout [Int]) {
        var r = 0
        var w = 0
        var b = 0
        
        for num in nums {
            if num == 0 {
                r += 1
            } else if num == 1 {
                w += 1
            } else {
                b += 1
            }
        }
        
        var index = 0
        while r > 0 {
            nums[index] = 0
            r -= 1
            index += 1
        }
        
        while w > 0 {
            nums[index] = 1
            w -= 1
            index += 1
        }
        
        while b > 0 {
            nums[index] = 2
            b -= 1
            index += 1
        }
    }
}