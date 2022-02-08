/*
Given an integer num, repeatedly add all its digits until the result has only one digit, and return it.



Example 1:

Input: num = 38
Output: 2
Explanation: The process is
38 --> 3 + 8 --> 11
11 --> 1 + 1 --> 2
Since 2 has only one digit, return it.
Example 2:

Input: num = 0
Output: 0


Constraints:

0 <= num <= 231 - 1


Follow up: Could you do it without any loop/recursion in O(1) runtime?
*/

/*
Solution 2:
digital root

Time Complexity: O(1)
Space Complexity: O(1)
*/
/*
Math --- digital roots
the digital root of 11 is 2, which means 11 is the second number after 9
the digital root of 2035 is 1, which means 2035-1 is a multiple of 9
if a number produces a digital root of exactly 9, then the number is a multiple of 9
could using floor function
dr(n) = 0       if n = 0
        9       if n != 0, n % 9 == 0
        n mod 9 if n%9 != 0
dr(n) = 1+(n-1)%9
 */

public class Solution {
    public int addDigits(int num) {
        return 1 + (num-1)%9;
    }
}
