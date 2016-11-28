/*
231. Power of Two  QuestionEditorial Solution  My Submissions
Total Accepted: 102496 Total Submissions: 265128 Difficulty: Easy
Given an integer, write a function to determine if it is a power of two.

Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Math Bit Manipulation
Hide Similar Problems (E) Number of 1 Bits (E) Power of Three (E) Power of Four
*/



/*1. it's a positive number
2. (n&(n-1)) == 0*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool isPowerOfTwo(int n) {
        return ((n>0) && !(n&(n-1)));
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isPowerOfTwo(int n) {
        return (n>0) && (n&(n-1))==0;
    }
}