/*
An array is considered special if every pair of its adjacent elements contains two numbers with different parity.

You are given an array of integers nums. Return true if nums is a special array, otherwise, return false.



Example 1:

Input: nums = [1]

Output: true

Explanation:

There is only one element. So the answer is true.

Example 2:

Input: nums = [2,1,4]

Output: true

Explanation:

There is only two pairs: (2,1) and (1,4), and both of them contain numbers with different parity. So the answer is true.

Example 3:

Input: nums = [4,3,1,6]

Output: false

Explanation:

nums[1] and nums[2] are both odd. So the answer is false.



Constraints:

1 <= nums.length <= 100
1 <= nums[i] <= 100
*/

/*
Solution 1:
Iterate to check if adjacent number have same parity or not
parity: in LSB(least significant bit) rightmost bit of number which decides if number is even or odd.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func isArraySpecial(_ nums: [Int]) -> Bool {
        let n = nums.count
        if n == 1 { return true }
        for i in 1..<n {
           let num1IsOdd = nums[i-1] % 2
           let num2IsOdd = nums[i] % 2
           if num1IsOdd == num2IsOdd {
                return false
           }
        }
        return true
    }
}
