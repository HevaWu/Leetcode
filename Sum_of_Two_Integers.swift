/*
Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -.

Example 1:

Input: a = 1, b = 2
Output: 3
Example 2:

Input: a = -2, b = 3
Output: 1
*/

/*
Solution 1
bit
*/
class Solution {
    func getSum(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        while b != 0 {
            let temp = a^b
            let carry = (a & b) << 1
            a = temp
            b = carry
        }
        return a
    }
}
