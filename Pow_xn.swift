/*
Implement pow(x, n), which calculates x raised to the power n (i.e. xn).

 

Example 1:

Input: x = 2.00000, n = 10
Output: 1024.00000
Example 2:

Input: x = 2.10000, n = 3
Output: 9.26100
Example 3:

Input: x = 2.00000, n = -2
Output: 0.25000
Explanation: 2-2 = 1/22 = 1/4 = 0.25
 

Constraints:

-100.0 < x < 100.0
-231 <= n <= 231-1
-104 <= xn <= 104
*/

/*
Solution 1:
cut pow in half

- check the sign, if n is negative, update x and n
- quick improve pow by go 2 steps together, n%2 == 0 ? myPow(x*x, n/2) : x*myPow(x*x, n/2)

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 { return 1 }
        
        var n = n
        var x = x
        if n < 0 {
            n = -n
            x = 1/x
        }
        
        return n%2 == 0 ? myPow(x*x, n/2) : x*myPow(x*x, n/2)
    }
}
