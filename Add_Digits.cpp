/*258. Add Digits Add to List
Description  Submission  Solutions
Total Accepted: 151350
Total Submissions: 299805
Difficulty: Easy
Contributors: Admin
Given a non-negative integer num, repeatedly add all its digits until the result has only one digit.

For example:

Given num = 38, the process is like: 3 + 8 = 11, 1 + 1 = 2. Since 2 has only one digit, return it.

Follow up:
Could you do it without any loop/recursion in O(1) runtime?

Hint:

A naive implementation of the above process is trivial. Could you come up with other methods?
What are all the possible results?
How do they occur, periodically or randomly?
You may find this Wikipedia article useful.
Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Adobe Microsoft
Hide Tags Math
Hide Similar Problems (E) Happy Number
*/




////////////////////////////////////////////////////////////////////////////////////////////////
///C++
class Solution {
public:
    int addDigits(int num) {
        return 1+(num-1)%9;
    }
};





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

////////////////////////////////////////////////////////////////////////////////////////////////
///Java
public class Solution {
    public int addDigits(int num) {
        return 1 + (num-1)%9;
    }
}
