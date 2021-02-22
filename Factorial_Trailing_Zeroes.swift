/*
Given an integer n, return the number of trailing zeroes in n!.

Follow up: Could you write a solution that works in logarithmic time complexity?

 

Example 1:

Input: n = 3
Output: 0
Explanation: 3! = 6, no trailing zero.
Example 2:

Input: n = 5
Output: 1
Explanation: 5! = 120, one trailing zero.
Example 3:

Input: n = 0
Output: 0
 

Constraints:

0 <= n <= 104
*/

/*
Solution 1
n < 5, trailing zero 0
n < 5*2, trailing zero 1
n < 5*3, trailing zero 2

n /= 5
res += n

Time Complexity: O(log_5 n)
Space Complexity: O(1)
*/

class Solution {
    func trailingZeroes(_ n: Int) -> Int {
        if n == 0 { return 0 }
        var n = n
        var res = 0
        while n >= 5 {
            n /= 5
            res += n
        }
        return res
    }
}