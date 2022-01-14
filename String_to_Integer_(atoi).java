/*
Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer (similar to C/C++'s atoi function).

The algorithm for myAtoi(string s) is as follows:

Read in and ignore any leading whitespace.
Check if the next character (if not already at the end of the string) is '-' or '+'. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.
Read in next the characters until the next non-digit charcter or the end of the input is reached. The rest of the string is ignored.
Convert these digits into an integer (i.e. "123" -> 123, "0032" -> 32). If no digits were read, then the integer is 0. Change the sign as necessary (from step 2).
If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then clamp the integer so that it remains in the range. Specifically, integers less than -231 should be clamped to -231, and integers greater than 231 - 1 should be clamped to 231 - 1.
Return the integer as the final result.
Note:

Only the space character ' ' is considered a whitespace character.
Do not ignore any characters other than the leading whitespace or the rest of the string after the digits.


Example 1:

Input: s = "42"
Output: 42
Explanation: The underlined characters are what is read in, the caret is the current reader position.
Step 1: "42" (no characters read because there is no leading whitespace)
         ^
Step 2: "42" (no characters read because there is neither a '-' nor '+')
         ^
Step 3: "42" ("42" is read in)
           ^
The parsed integer is 42.
Since 42 is in the range [-231, 231 - 1], the final result is 42.
Example 2:

Input: s = "   -42"
Output: -42
Explanation:
Step 1: "   -42" (leading whitespace is read and ignored)
            ^
Step 2: "   -42" ('-' is read, so the result should be negative)
             ^
Step 3: "   -42" ("42" is read in)
               ^
The parsed integer is -42.
Since -42 is in the range [-231, 231 - 1], the final result is -42.
Example 3:

Input: s = "4193 with words"
Output: 4193
Explanation:
Step 1: "4193 with words" (no characters read because there is no leading whitespace)
         ^
Step 2: "4193 with words" (no characters read because there is neither a '-' nor '+')
         ^
Step 3: "4193 with words" ("4193" is read in; reading stops because the next character is a non-digit)
             ^
The parsed integer is 4193.
Since 4193 is in the range [-231, 231 - 1], the final result is 4193.
Example 4:

Input: s = "words and 987"
Output: 0
Explanation:
Step 1: "words and 987" (no characters read because there is no leading whitespace)
         ^
Step 2: "words and 987" (no characters read because there is neither a '-' nor '+')
         ^
Step 3: "words and 987" (reading stops immediately because there is a non-digit 'w')
         ^
The parsed integer is 0 because no digits were read.
Since 0 is in the range [-231, 231 - 1], the final result is 0.
Example 5:

Input: s = "-91283472332"
Output: -2147483648
Explanation:
Step 1: "-91283472332" (no characters read because there is no leading whitespace)
         ^
Step 2: "-91283472332" ('-' is read, so the result should be negative)
          ^
Step 3: "-91283472332" ("91283472332" is read in)
                     ^
The parsed integer is -91283472332.
Since -91283472332 is less than the lower bound of the range [-231, 231 - 1], the final result is clamped to -231 = -2147483648.


Constraints:

0 <= s.length <= 200
s consists of English letters (lower-case and upper-case), digits (0-9), ' ', '+', '-', and '.'.
*/

/*
requirements:
allow whitespace
allow non-integer element
consider invalid situation, return 0 if invalid
if out of limit, return(Integer.MAX_VALUE, Integer.MIN_VALUE)

Solution 2 faster than Solution 1

Solution 1: 56 ms/ 1047 test
1. trim string
2. use ifpos to check if the first char is positive, positive(1), negative(-1)
3. for loop update num value, if num>Integer.MAX_VALUE, break the loop
    if current char is not in (0,9) break the loop
4. num = num*ifpos
5. compare with Integer.MAX_VALUE and Integer.MIN_VALUE
6. return num

Solution 2: 46 ms / 1047 test
same idea
in step 3 use /10 to help check :
    //check if total will be overflow after 10 times and add digit
    if(Integer.MAX_VALUE/10 < total || Integer.MAX_VALUE/10 == total && Integer.MAX_VALUE %10 < digit)
    return sign == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;
this method could keep num as int type, no need to long type
 */
public class Solution {
    public int myAtoi(String str) {
        if(str==null || str.length()==0) return 0;
        long num = 0;

        str = str.trim();
        //check the sign
        int ifpos = 1;
        char c = str.charAt(0);
        if(c == '-'){
            ifpos = -1;
        } else if(c == '+') {
            ifpos = 1;
        } else if(c>='0' && c<='9'){
            num = Integer.valueOf(c+"");
        } else {
            return 0;
        }

        for(int i = 1; i < str.length(); ++i){
            c = str.charAt(i);
            if(c>='0' && c<='9'){
                num = num*10+Integer.valueOf(c+"");
                if(num > Integer.MAX_VALUE){
                    break;
                }
            } else {
                break;
            }
        }

        //System.out.println(ifpos + " " + num);
        num = num*ifpos;
        if(num > Integer.MAX_VALUE){
            num =  Integer.MAX_VALUE;
        }
        if(num < Integer.MIN_VALUE){
            num = Integer.MIN_VALUE;
        }
        return (int)num;
    }
}




//Solution 2
public class Solution {
    public int myAtoi(String str) {
        if(str==null || str.length()==0) return 0;

        int index = 0;
        int len = str.length();
        //find the first char not " "
        while(index<len && str.charAt(index)==' '){
            index++;
        }

        int sign = 1;
        if(str.charAt(index)=='+' || str.charAt(index)=='-'){
            if(str.charAt(index++)=='-'){
                sign = -1;
            }
        }

        int num = 0;
        while(index<len){
            char c = str.charAt(index);
            if(c<'0' || c>'9') break;
            int temp = Integer.valueOf(c+"");
            if(Integer.MAX_VALUE/10 < num ||(Integer.MAX_VALUE/10==num && Integer.MAX_VALUE%10<temp)){
                return sign==1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;
            }
            num = num*10 + temp;
            index++;
        }

        return num*sign;
    }
}
