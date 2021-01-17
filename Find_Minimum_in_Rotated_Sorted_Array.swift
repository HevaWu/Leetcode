/*
Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:

[4,5,6,7,0,1,2] if it was rotated 4 times.
[0,1,2,4,5,6,7] if it was rotated 7 times.
Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].

Given the sorted rotated array nums, return the minimum element of this array.

 

Example 1:

Input: nums = [3,4,5,1,2]
Output: 1
Explanation: The original array was [1,2,3,4,5] rotated 3 times.
Example 2:

Input: nums = [4,5,6,7,0,1,2]
Output: 0
Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
Example 3:

Input: nums = [11,13,15,17]
Output: 11
Explanation: The original array was [11,13,15,17] and it was rotated 4 times. 
 

Constraints:

n == nums.length
1 <= n <= 5000
-5000 <= nums[i] <= 5000
All the integers of nums are unique.
nums is sorted and rotated between 1 and n times.

Hint 1:
Array was originally in ascending order. Now that the array is rotated, there would be a point in the array where there is a small deflection from the increasing sequence. eg. The array would be something like [4, 5, 6, 7, 0, 1, 2].

Hint 2:
You can divide the search space into two and see which direction to go. Can you think of an algorithm which has O(logN) search complexity?

Hint 3:
All the elements to the left of inflection point > first element of the array.
All the elements to the right of inflection point < first element of the array.
*/

/*
Solution 2:
binary search

loop when left < right
- if nums[mid] < nums[right], right = mid
- else, left = mid+1
- return nums[left]

Time Complexity: O(log n)
Space Complexity: O(1)
*/
class Solution {
    func findMin(_ nums: [Int]) -> Int {
        if nums.count == 1 { return nums[0] }
        var left = 0
        var right = nums.count-1
        while left < right {
            let mid = left+(right-left)/2
            if nums[mid] < nums[right] {
                right = mid
            } else {
                left = mid+1
            }
        }
        return nums[left]
    }
}

/*
Solution 1:
binary search

loop when left<=right
- nums[mid] > nums[mid+1], return nums[mid+1]
- nums[mid-1] > nums[mid], return nums[mid]
- nums[left] < nums[mid], left = mid+1, else right = mid-1

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func findMin(_ nums: [Int]) -> Int {
        if nums.count == 1 { return nums[0] }
        let n = nums.count
        var left = 0
        var right = n - 1
        
        if nums[left] < nums[right] {
            return nums[left]
        }
        
        while left <= right {
            let mid = left + (right-left)/2
            if nums[mid] > nums[mid+1] {
                return nums[mid+1]
            }
            
            if nums[mid-1] > nums[mid] {
                return nums[mid]
            }
            
            if nums[mid] > nums[left] {
                left = mid+1
            } else {
                right = mid-1
            }
        }
        
        return -1
    }
}