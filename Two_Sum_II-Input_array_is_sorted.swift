/*
Given an array of integers that is already sorted in ascending order, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2.

Note:

Your returned answers (both index1 and index2) are not zero-based.
You may assume that each input would have exactly one solution and you may not use the same element twice.
 

Example 1:

Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.
Example 2:

Input: numbers = [2,3,4], target = 6
Output: [1,3]
Example 3:

Input: numbers = [-1,0], target = -1
Output: [1,2]
 

Constraints:

2 <= nums.length <= 3 * 104
-1000 <= nums[i] <= 1000
nums is sorted in increasing order.
-1000 <= target <= 1000
*/

/*
Solution 1:
Binary Search

for each num, check if we can find target-num in remaining nums

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        let n = numbers.count
        for i in 0..<n {
            if let finded = canSearch(numbers, i+1, n-1, target-numbers[i]) {
                return [i+1, finded+1]
            }
        }
        
        // cannot find such pair
        return []
    }
    
    func canSearch(_ nums: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int? {
        var left = start
        var right = end
        while left <= right {
            let mid = left + (right-left)/2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid+1
            } else {
                right = mid-1
            }
        }
        return nil
    }
}