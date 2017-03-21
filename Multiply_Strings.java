/*43. Multiply Strings   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 86165
Total Submissions: 333011
Difficulty: Medium
Contributors: Admin
Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2.

Note:

The length of both num1 and num2 is < 110.
Both num1 and num2 contains only digits 0-9.
Both num1 and num2 does not contain any leading zero.
You must not use any built-in BigInteger library or convert the inputs to integer directly.
Hide Company Tags Facebook Twitter
Hide Tags Math String
Hide Similar Problems (M) Add Two Numbers (E) Plus One (E) Add Binary (E) Add Strings
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Math
num1[i]*num2[j] will be placed at indices[i+1, i+j+1]
for example;
index 1			1 2 3   index i
index 0			  4 5   index j
-------------------------------
				  1 5
				1 0
			  0 5
-------------------------------
			    1 2
			  0 8		indices[1, 2] = index [i+j, i+j+1]
			0 4
-------------------------------
indices		0 1 2 3 4*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String multiply(String num1, String num2) {
        if(num1.length()==0 || num2.length()==0) return "0";

        int n1 = num1.length();
        int n2 = num2.length();

        int[] ret = new int[n1+n2]; // the length of the final result
        for(int i = n1-1; i >= 0; i--){
            for(int j = n2-1; j >= 0; j--){
                int temp = (num1.charAt(i)-'0') * (num2.charAt(j)-'0');
                int p1 = i + j;
                int p2 = i + j + 1;
                int sum = temp + ret[p2];

                ret[p2] = sum % 10;
                ret[p1] += sum / 10;
            }
        }

        StringBuilder str = new StringBuilder();
        for(int r : ret){
            if(!(str.length()==0 && r==0)){
                str.append(r);
            }
        }
        return str.length()==0 ? "0" : str.toString();
    }
}

