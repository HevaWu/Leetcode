/*397. Integer Replacement
Description  Submission  Solutions  Add to List
Total Accepted: 14488
Total Submissions: 49412
Difficulty: Medium
Contributors: Admin
Given a positive integer n and you can do operations as follow:

If n is even, replace n with n/2.
If n is odd, you can replace n with either n + 1 or n - 1.
What is the minimum number of replacements needed for n to become 1?

Example 1:

Input:
8

Output:
3

Explanation:
8 -> 4 -> 2 -> 1
Example 2:

Input:
7

Output:
4

Explanation:
7 -> 8 -> 4 -> 2 -> 1
or
7 -> 6 -> 3 -> 2 -> 1
Hide Company Tags Google Baidu
Hide Tags Math Bit Manipulation
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Math, bit manipulation
if n is even, half it
if n = 3 or n-1 has less 1's than n+1, do n-1
		two ways to test the 1's
		1. Integer.bitCount(n-1) < Integer.bitCount(n+1)
		2. (n>>>1) & 1 == 0
otherwise, do n+1
just need to remove as many 1's as possible
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int integerReplacement(int n) {
        if(n <= 0) return 0;

        int ret = 0;
        while(n != 1){
            if((n&1) == 0){//even number, remember add()
                System.out.println("before " + n);
                n >>>= 1; //do n = n / 2; if n>>>=2, is do n=n/4;
                System.out.println("after " + n);
            } else if(n==3 || Integer.bitCount(n-1) < Integer.bitCount(n+1)){
            //use bitCount function to get how many 1's in current int value
            // or use n==3 || ((n>>>1)&1)==0
            // if a number ends with 01, then certainly do n--
            // if ends with 11. then do n++
            // >>> is logical shift, unsign shift, right shift
                --n;
            } else {
                ++n;
            }
            ++ret; //add one operation
        }
        return ret;
    }
}

