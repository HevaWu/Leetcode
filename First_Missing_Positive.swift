/*
Given an unsorted integer array nums, find the smallest missing positive integer.

 

Example 1:

Input: nums = [1,2,0]
Output: 3
Example 2:

Input: nums = [3,4,-1,1]
Output: 2
Example 3:

Input: nums = [7,8,9,11,12]
Output: 1
 

Constraints:

0 <= nums.length <= 300
-231 <= nums[i] <= 231 - 1
 

Follow up: Could you implement an algorithm that runs in O(n) time and uses constant extra space?
*/

/*
Solution 2: 
use set to check if number exist in array 

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 1 }
        
        var nums = Set(nums)
        let n = nums.count
        
        for i in 1...n {
            if !nums.contains(i) {
                return i
            }
        }
        
        return n+1
    }
}

/*
Solution 1:
put each number to correct place in nums
ex: nums[2] should be 3

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 1 }
        
        var nums = nums
        let n = nums.count
        
        for i in 0..<n {
            while nums[i] > 0, nums[i] <= n, nums[nums[i]-1] != nums[i] {
                nums.swapAt(i, nums[i]-1)
            }
        }
        
        for i in 0..<n {
            if nums[i] != i+1 {
                return i+1
            }
        }
        return n+1
    }
}