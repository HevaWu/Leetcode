/*
Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

Example:

Input: [0,1,0,3,12]
Output: [1,3,12,0,0]
Note:

You must do this in-place without making a copy of the array.
Minimize the total number of operations.

Hint 1
In-place means we should not be allocating any space for extra array. But we are allowed to modify the existing array. However, as a first step, try coming up with a solution that makes use of additional space. For this problem as well, first apply the idea discussed using an additional array and the in-place solution will pop up eventually.

Hint 2
A two-pointer approach could be helpful here. The idea would be to have one pointer for iterating the array and another pointer that just works on the non-zero elements of the array.
*/

/*
Solution 2
1 loop
*/
class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        // non-zero index
        var nzIndex = 0
        
        let n = nums.count
        for i in 0..<n {
            if nums[i] != 0 {
                nums.swapAt(nzIndex, i)
                nzIndex += 1
            }
        }
    }
}

/*
Solution 1
array
2 loop 

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        // non-zero index
        var nzIndex = 0
        
        let n = nums.count
        for i in 0..<n where nums[i] != 0 {
            nums[nzIndex] = nums[i]
            nzIndex += 1
        }
        
        while nzIndex < n {
            nums[nzIndex] = 0
            nzIndex += 1
        }
    }
}