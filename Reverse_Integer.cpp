/*7. Reverse Integer Add to List
Description  Submission  Solutions
Total Accepted: 216776
Total Submissions: 909249
Difficulty: Easy
Contributors: Admin
Reverse digits of an integer.

Example1: x = 123, return 321
Example2: x = -123, return -321

click to show spoilers.

Have you thought about this?
Here are some good questions to ask before coding. Bonus points for you if you have already thought through this!

If the integer's last digit is 0, what should the output be? ie, cases such as 10, 100.

Did you notice that the reversed integer might overflow? Assume the input is a 32-bit integer, then the reverse of 1000000003 overflows. How should you handle such cases?

For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

Note:
The input is assumed to be a 32-bit signed integer. Your function should return 0 when the reversed integer overflows.

Hide Company Tags Bloomberg Apple
Hide Tags Math
Hide Similar Problems (M) String to Integer (atoi)
*/





////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int reverse(int x) {
        long reverseX=0;
        while(x){
            reverseX = reverseX*10 + x%10;
            x = x/10;
            if(reverseX > INT_MAX || reverseX < INT_MIN) return 0;
        }
        return static_cast<int>(reverseX);
    }
};





/*
Math
init return num as long type
each time
    num = num*10 + x%10;
    x = x/10;
    //judge if current num is out of limit
    //if it is, return 0
    if(num>Integer.MAX_VALUE || num<Integer.MIN_VALUE) return 0;
at the end, return (int)num
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int reverse(int x) {
        long num = 0;
        while(x!=0){
            num = num*10+x%10;
            x = x/10;
            if(num>Integer.MAX_VALUE || num<Integer.MIN_VALUE) return 0;
        }
        return (int)num;
    }
}
