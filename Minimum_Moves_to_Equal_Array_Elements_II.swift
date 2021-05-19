/*
Given an integer array nums of size n, return the minimum number of moves required to make all array elements equal.

In one move, you can increment or decrement an element of the array by 1.



Example 1:

Input: nums = [1,2,3]
Output: 2
Explanation:
Only two moves are needed (remember each move increments or decrements one element):
[1,2,3]  =>  [2,2,3]  =>  [2,2,2]
Example 2:

Input: nums = [1,10,2,9]
Output: 16


Constraints:

n == nums.length
1 <= nums.length <= 105
-109 <= nums[i] <= 109
*/

/*
Solution 1:
2 pointer

for make all elements same
we sort array first
the sum of all nums[right]-nums[left] is the answer

this can help assigning all elements to most middle element

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minMoves2(_ nums: [Int]) -> Int {
        let n = nums.count
        var nums = nums.sorted()

        var left = 0
        var right = n-1

        var moves = 0
        while left < right {
            moves += nums[right] - nums[left]
            left += 1
            right -= 1
        }

        return moves
    }
}