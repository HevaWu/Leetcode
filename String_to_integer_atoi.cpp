/*
8. String to Integer (atoi) Add to List
Description  Submission  Solutions
Total Accepted: 154490
Total Submissions: 1113068
Difficulty: Medium
Contributors: Admin
Implement atoi to convert a string to an integer.

Hint: Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.

Notes: It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.

Update (2015-02-10):
The signature of the C++ function had been updated. If you still see your function signature accepts a const char * argument, please click the reload button  to reset your code definition.

spoilers alert... click to show requirements for atoi.

Requirements for atoi:
The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned. If the correct value is out of the range of representable values, INT_MAX (2147483647) or INT_MIN (-2147483648) is returned.

Hide Company Tags Amazon Microsoft Bloomberg Uber
Hide Tags Math String
Hide Similar Problems (E) Reverse Integer (H) Valid Number
*/






////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int myAtoi(string str) {
        long results = 0;
        int flag = 1;

        int i = 0;
        if(i < str.size())
        //for(int i = 0; i < str.size();)
        {
            i = str.find_first_not_of(' ');
            if(str[i] == '+' || str[i] == '-')
                flag = str[i++] == '-' ? -1 : 1;
            while(str[i] >= '0' && str[i] <= '9'){
                results = results*10 + (str[i++]-'0');
                if(results*flag >= INT_MAX) return INT_MAX;
                if(results*flag <= INT_MIN) return INT_MIN;
            }
            //return results*flag;
        }
        return results*flag;

    }
};





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

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
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
