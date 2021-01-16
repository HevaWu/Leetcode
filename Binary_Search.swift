/*
Given a sorted (in ascending order) integer array nums of n elements and a target value, write a function to search target in nums. If target exists, then return its index, otherwise return -1.


Example 1:

Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4
Explanation: 9 exists in nums and its index is 4

Example 2:

Input: nums = [-1,0,3,5,9,12], target = 2
Output: -1
Explanation: 2 does not exist in nums so return -1
 

Note:

You may assume that all elements in nums are unique.
n will be in the range [1, 10000].
The value of each element in nums will be in the range [-9999, 9999].
*/

/*
Solution 1:
binary search nums

Time Complexity: bese case, O(logn), worst case O(n)
Space Complexity: O(1)
*/
class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else { return -1 }
        
        // binarySearch between start and end, 
        // once we find target, return its index
        func binarySearch(_ start: Int, _ end: Int) -> Int {
			// use >= to avoid start out of limit
            if start >= end {
                return nums[start] == target ? start : -1
            }
            
            let mid = (start+end)/2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                // search right side
                return binarySearch(mid+1, end)
            } else {
                // search left side
                return binarySearch(start, mid-1)
            }
        }
        
        return binarySearch(0, nums.count-1)
    }
}