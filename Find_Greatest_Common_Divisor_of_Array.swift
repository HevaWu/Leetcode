/*
Given an integer array nums, return the greatest common divisor of the smallest number and largest number in nums.

The greatest common divisor of two numbers is the largest positive integer that evenly divides both numbers.



Example 1:

Input: nums = [2,5,6,9,10]
Output: 2
Explanation:
The smallest number in nums is 2.
The largest number in nums is 10.
The greatest common divisor of 2 and 10 is 2.
Example 2:

Input: nums = [7,5,6,8,3]
Output: 1
Explanation:
The smallest number in nums is 3.
The largest number in nums is 8.
The greatest common divisor of 3 and 8 is 1.
Example 3:

Input: nums = [3,3]
Output: 3
Explanation:
The smallest number in nums is 3.
The largest number in nums is 3.
The greatest common divisor of 3 and 3 is 3.


Constraints:

2 <= nums.length <= 1000
1 <= nums[i] <= 1000

*/

class Solution {
    func findGCD(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return nums[0] }

        var s = nums[0]
        var l = nums[0]
        for i in 1..<n {
            s = min(s, nums[i])
            l = max(l, nums[i])
        }
        return gcd(s, l)
    }

    // return greatest common divisor of 2 number
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        var t = 0

        while b != 0 {
            t = a
            a = b
            b = t % a
        }
        return a
    }
}