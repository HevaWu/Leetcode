/*
Given a non-negative integer x, compute and return the square root of x.

Since the return type is an integer, the decimal digits are truncated, and only the integer part of the result is returned.

 

Example 1:

Input: x = 4
Output: 2
Example 2:

Input: x = 8
Output: 2
Explanation: The square root of 8 is 2.82842..., and since the decimal part is truncated, 2 is returned.
 

Constraints:

0 <= x <= 231 - 1

Hint 1: Try exploring all integers. (Credits: @annujoshi)
Hint 2: Use the sorted property of integers to reduced the search space. (Credits: @annujoshi)
*/

/*
Solution 2:
Newton's method

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func mySqrt(_ x: Int) -> Int {
        if x == 0 { return 0 }
        if x <= 3 { return 1 }
        
        var r = x/2
        while r*r > x {
            r = (r + x/r)/2
        }
        return r
    }
}

/*
Solution 1: 
binary search

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func mySqrt(_ x: Int) -> Int {
        if x == 0 { return 0 }
        if x <= 3 { return 1 }
        
        var left = 0
        var right = x-1
        
        // use <= here, not <
        while left <= right {
            var mid = left + (right - left)/2
            let mid2 = mid*mid
            if mid2 == x {
                return mid
            } else if mid2 < x {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left-1
    }
}