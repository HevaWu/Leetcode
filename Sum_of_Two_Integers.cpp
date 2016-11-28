/*371. Sum of Two Integers  QuestionEditorial Solution  My Submissions
Total Accepted: 30580
Total Submissions: 59156
Difficulty: Easy
Calculate the sum of two integers a and b, but you are not allowed to use the operator + and -.

Example:
Given a = 1 and b = 2, return 3.

Credits:
Special thanks to @fujiaozhu for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/



/*Bit Manipulation
Use XOR and AND operations
Use XOR to find the different bit in a and b, and assign it to a
store a^b to carrry, shift one position left and assign it to b
do this loop until b is 0*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int getSum(int a, int b) {
        if(a==0) return b;
        if(b==0) return a;
        while(b!=0){
            int carry = a & b;
            a = a ^ b;
            b = carry << 1;
        }
        return a;
    }
};

public int getSubtract(int a, int b) {
	while (b != 0) {
		int borrow = (~a) & b;
		a = a ^ b;
		b = borrow << 1;
	}
	
	return a;
}


public int negate(int x) {
	return ~x + 1;
}





/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int getSum(int a, int b) {
        if(a==0) return b;
        if(b==0) return a;
        
        while(b!=0){
            int carry = a & b;
            a = a ^ b;
            b = carry << 1;
        }
        
        return a;
    }
}
