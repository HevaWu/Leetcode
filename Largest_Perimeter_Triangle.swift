/*
Given an integer array nums, return the largest perimeter of a triangle with a non-zero area, formed from three of these lengths. If it is impossible to form any triangle of a non-zero area, return 0.



Example 1:

Input: nums = [2,1,2]
Output: 5
Example 2:

Input: nums = [1,2,1]
Output: 0


Constraints:

3 <= nums.length <= 104
1 <= nums[i] <= 106
*/

/*
Solution 1:
to check if 3 side(a, b, c) can make triangle, we need to check
a + b > c
a + c > b
b + c > a

in an array, if we sorted,
if we can make sure: arr[i-2] + arr[i-1] > arr[i]
then we can make sure arr[i-2] + arr[i] > arr[i-1]
and arr[i-1] + arr[i] > arr[i-2]
if above failed, then it is impossible to make triangle by use arr[i]
to find largest, search array from end to beginning, until we find a 3 pair
if no pair, it's impossible to make triangle

Steps:
- sort array
- check from end to beginning to build triangle

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func largestPerimeter(_ nums: [Int]) -> Int {
        var nums = nums.sorted()
        for i in stride(from: nums.count-1, through: 2, by: -1) {
            if nums[i] < nums[i-1] + nums[i-2] {
                return nums[i] + nums[i-1] + nums[i-2]
            }
        }
        return 0
    }
}
