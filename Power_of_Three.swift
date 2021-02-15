/*
Given an integer n, return true if it is a power of three. Otherwise, return false.

An integer n is a power of three, if there exists an integer x such that n == 3x.

 

Example 1:

Input: n = 27
Output: true
Example 2:

Input: n = 0
Output: false
Example 3:

Input: n = 9
Output: true
Example 4:

Input: n = 45
Output: false
 

Constraints:

-231 <= n <= 231 - 1
 

Follow up: Could you do it without using any loop / recursion?
*/

/*
Solution 3
find maximum Int number that power of 3
3 ^⌊log_3 MaxInt⌋ = 3^ ⌊19.56⌋ = 3^19 = 1162261467

since 3 is prime number, the only divisors of 3^19 are 3^0, 3^1, ... 3^19
so divide 3^19 by n
remainder of 0 means n is a divisor of 3^19 => power of 3

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        return n > 0 && 1162261467 % n == 0
    }
}

/*
Solution 2
math, use log

Time Complexity: unknown, use log10() here, need to check how Swift implement this function
Space Complexity: O(1)
*/
class Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        // use truncatingRemainder(dividingBy: 1)
        // to check if there is any decimal part
        return (log10(Double(n)) / log10(Double(3))).truncatingRemainder(dividingBy: 1) == 0
    }
}

/*
Solution 1
transfer to string radix

Time Complexity: O(log_3 n)
Space Complexity: O(log_3 n)
*/
class Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        var n = Array(String(n, radix: 3))
        for i in 0..<n.count {
            if i == 0 {
                if n[i] != "1" { return false }
            } else {
                if n[i] != "0" { return false}
            }
        }
        return true
    }
}