/*
The Hamming distance between two integers is the number of positions at which the corresponding bits are different.

Given two integers x and y, calculate the Hamming distance.

Note:
0 ≤ x, y < 231.

Example:

Input: x = 1, y = 4

Output: 2

Explanation:
1   (0 0 0 1)
4   (0 1 0 0)
       ↑   ↑

The above arrows point to positions where the corresponding bits are different.
*/

/*
Solution 2
check x^y number of 1 bit count(hamming weight)

Time Complexity: O(x^y digit)
Space Complexity: O(1)
*/
class Solution {
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var n = x^y
        var res = 0
        while n != 0 {
            n &= (n-1)
            res += 1
        }
        return res
    }
}

/*
Solution 1
bit
use >> bit operation to divide 2

Time Complexity: O(max bit_len of (x,y))
Space Complexity: O(1)
*/
class Solution {
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var x = x 
        var y = y
        var res = 0
        while x != 0 || y != 0 {
            if (x % 2)^(y % 2) == 1 {
                res += 1
            }
            x = x >> 1
            y = y >> 1
        }
        return res
    }
}