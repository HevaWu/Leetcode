/*
Given two integers left and right that represent the range [left, right], return the bitwise AND of all numbers in this range, inclusive.



Example 1:

Input: left = 5, right = 7
Output: 4
Example 2:

Input: left = 0, right = 0
Output: 0
Example 3:

Input: left = 1, right = 2147483647
Output: 0


Constraints:

0 <= left <= right <= 231 - 1
*/

/*
Solution 1:
right move one bit each time, until they equal to each other 
record the number of this bit, and return the value left move this number

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
        if left == right { return left }
        var left = left
        var right = right
        var i = 0
        while left != right, i < 32 {
            left >>= 1
            right >>= 1
            i += 1
        }
        return left << i
    }
}
