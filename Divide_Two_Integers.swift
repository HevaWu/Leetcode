/*
Given two integers dividend and divisor, divide two integers without using multiplication, division, and mod operator.

Return the quotient after dividing dividend by divisor.

The integer division should truncate toward zero, which means losing its fractional part. For example, truncate(8.345) = 8 and truncate(-2.7335) = -2.

Note:

Assume we are dealing with an environment that could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For this problem, assume that your function returns 231 − 1 when the division result overflows.
 

Example 1:

Input: dividend = 10, divisor = 3
Output: 3
Explanation: 10/3 = truncate(3.33333..) = 3.
Example 2:

Input: dividend = 7, divisor = -3
Output: -2
Explanation: 7/-3 = truncate(-2.33333..) = -2.
Example 3:

Input: dividend = 0, divisor = 1
Output: 0
Example 4:

Input: dividend = 1, divisor = 1
Output: 1
 

Constraints:

-231 <= dividend, divisor <= 231 - 1
divisor != 0
*/

/*
Solution 1
binary search

1. check if res is isPositive
2. binary search between [0, dividend]
3. when return res, always check if it in bound

Time Complexity: O(log {divident} )
Space Complexity: O(1)
*/
class Solution {
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if dividend == 0 { return 0 }
        
        var isPositive = dividend * divisor > 0
        
        var dividend = abs(dividend)
        var divisor = abs(divisor)
        
        // check divisor is 1
        // when return res, always check if it in bound
        if divisor == 1 { 
            return isPositive 
            ? min(dividend, Int(Int32.max)) 
            : max(-dividend, Int(Int32.min))
        }
        
        // binary search find quotient
        var left = 0
        var right = dividend
        
        while left < right {
            let mid = left + (right - left)/2
            if mid * divisor < dividend {
                left = mid + 1
            } else {
                right = mid
            }
        }

        // check correct quotient, and update left
        if left * divisor > dividend {
            left -= 1
        }
        
        return isPositive 
        ? min(left, Int(Int32.max))
        : max(-left, Int(Int32.min))
    }
}