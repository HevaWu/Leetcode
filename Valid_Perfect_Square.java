/*367. Valid Perfect Square Add to List
Description  Submission  Solutions
Total Accepted: 31761
Total Submissions: 84288
Difficulty: Easy
Contributors: Admin
Given a positive integer num, write a function which returns True if num is a perfect square else False.

Note: Do not use any built-in library function such as sqrt.

Example 1:

Input: 16
Returns: True
Example 2:

Input: 14
Returns: False
Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags LinkedIn
Hide Tags Binary Search Math
Hide Similar Problems (E) Sqrt(x)
*/






/*
start from 0, check whether their is a number(i*i==num), if there is, then current number is a perfect square
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isPerfectSquare(int num) {
        if(num <= 0 || num >= 2147483647) return false;
        if(num == 1) return true;
        for(int i = 0; i*i <= num; ++i){
            if(i*i == num){
                return true;
            }
        }
        return false;
    }
}
