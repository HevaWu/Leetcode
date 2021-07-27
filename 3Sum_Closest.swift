/*
Given an array nums of n integers and an integer target, find three integers in nums such that the sum is closest to target. Return the sum of the three integers. You may assume that each input would have exactly one solution.



Example 1:

Input: nums = [-1,2,1,-4], target = 1
Output: 2
Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).


Constraints:

3 <= nums.length <= 10^3
-10^3 <= nums[i] <= 10^3
-10^4 <= target <= 10^4
*/

/*
Solution 1:
sort + 2 pointer

sort array
fix first element, then use two pointer to get close to target

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let n = nums.count
        var nums = nums.sorted()
        var sum = nums[0] + nums[1] + nums[2]

        for i in 0..<(n-2) {
            var left = i+1
            var right = n-1
            while left < right {
                var temp = nums[i] + nums[left] + nums[right]
                if temp > target {
                    right -= 1
                } else {
                    left += 1
                }
                if abs(temp - target) < abs(sum - target) {
                    sum = temp
                }
            }
        }
        return sum
    }
}