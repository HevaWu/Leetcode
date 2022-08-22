/*
Given an integer n, return true if it is a power of four. Otherwise, return false.

An integer n is a power of four, if there exists an integer x such that n == 4x.



Example 1:

Input: n = 16
Output: true
Example 2:

Input: n = 5
Output: false
Example 3:

Input: n = 1
Output: true


Constraints:

-231 <= n <= 231 - 1


Follow up: Could you solve it without loops/recursion?
*/

/*the power of 4 numbers have three features:
1. greater than 0
2. only have one 1 'bit' in their binary notation, use x&(x-1) to delete the lowest '1', if the result is 0, this number only have one bit
3. the only '1' bit should locate at the odd location, use '0x55555555' to check, or use
(x-1)%3==0 to check*/
public class Solution {
    public boolean isPowerOfFour(int num) {
        return (num != 0) && (num & (num - 1)) == 0 && (num - 1) % 3 == 0;
    }
}