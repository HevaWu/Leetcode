/*
Given an integer array nums of length n where all the integers of nums are in the range [1, n] and each integer appears once or twice, return an array of all the integers that appears twice.

You must write an algorithm that runs in O(n) time and uses only constant extra space.



Example 1:

Input: nums = [4,3,2,7,8,2,3,1]
Output: [2,3]
Example 2:

Input: nums = [1,1,2]
Output: [1]
Example 3:

Input: nums = [1]
Output: []


Constraints:

n == nums.length
1 <= n <= 105
1 <= nums[i] <= n
Each element in nums appears once or twice.
*/

/*
Solution 2
Since 1 ≤ a[i] ≤ n (n = size of array),
for ith element, we flip the i-1 element from positive to negative
if we find one element is already negative, we push this element to the return list

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var nums = nums
        var res = [Int]()
        for i in 0..<nums.count {
            let index = abs(nums[i]) - 1
            if nums[index] < 0 {
                res.append(index+1)
            } else {
                nums[index] = -nums[index]
            }
        }
        return res
    }
}

/*
Solution 1:
Set
*/
class Solution {
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var numSet = Set<Int>()
        var res = [Int]()
        for num in nums {
            if numSet.contains(num) {
                res.append(num)
            } else {
                numSet.insert(num)
            }
        }

        return res
    }
}