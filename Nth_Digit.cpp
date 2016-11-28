/*400. Nth Digit   QuestionEditorial Solution  My Submissions
Total Accepted: 6564 Total Submissions: 21733 Difficulty: Easy Contributors: Admin
Find the nth digit of the infinite integer sequence 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ...

Note:
n is positive and will fit within the range of a 32-bit signed integer (n < 231).

Example 1:

Input:
3

Output:
3
Example 2:

Input:
11

Output:
0

Explanation:
The 11th digit of the sequence 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, ... is a 0, which is part of the number 10.
Hide Company Tags Google
Hide Tags Math
*/



/*
Straight forward way to solve the problem in 3 steps:
1.find the length of the number where the nth digit is from; eg:11  len = 2
2.find the actual number where the nth digit is from; eg: 11 actual from 10
3.find the nth digit and return

first check 1-9, then increase to 10-90, each time increase the digit, this steop get the length of the number where nth digit is from
then find the actual number by  + the remain number/len
get the n digit*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int findNthDigit(int n) {
        int len = 1;
        long count = 9;
        int actual = 1;
        
        while(n > len*count){
            n -= len*count;
            len++;
            count *= 10;
            actual *= 10;
        }
        
        return to_string(actual+(n-1)/len)[(n-1)%len] - '0';
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int findNthDigit(int n) {
        int len = 1; //len start from 1, since 1-9
        long count = 9; //use long to store it
        int actual = 1; //the actual number where n digit is in
        
        while(n > len*count){
            n -= len*count; //get the remain number 
            len++; //transfer to next position of number, 10-90
            count *= 10;
            actual *= 10;
        }
        
        actual += (n-1)/len; //get the actual number where n digit is 
        String s = Integer.toString(actual);
        //get the n digit number s[(n-1)%len]
        //use Character.getNumericalValue() to get from char to int
        return Character.getNumericValue(s.charAt((n-1)%len));
    }
}
