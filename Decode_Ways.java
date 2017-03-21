/*91. Decode Ways
Description  Submission  Solutions  Add to List
Total Accepted: 103594
Total Submissions: 546398
Difficulty: Medium
Contributors: Admin
A message containing letters from A-Z is being encoded to numbers using the following mapping:

'A' -> 1
'B' -> 2
...
'Z' -> 26
Given an encoded message containing digits, determine the total number of ways to decode it.

For example,
Given encoded message "12", it could be decoded as "AB" (1 2) or "L" (12).

The number of ways decoding "12" is 2.

Hide Company Tags Microsoft Uber Facebook
Hide Tags Dynamic Programming String
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*DP Dynamic Programming
O(n) time
init ret[len] = 1, ret[len-1]=s.charAt(len-1)!='0' ? 1 : 0
then, each time check if current number is 0
if not, check if current 2 digit <= 26,
if it is, ret[i] = ret[i+1]+ret[i+2]
if not, ret[i] = ret[i+1]
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int numDecodings(String s) {
        if(s.length() <= 0) return 0;

        int len = s.length();
        int[] ret = new int[len+1];
        ret[len] = 1;
        ret[len-1] = s.charAt(len-1)!='0' ? 1 : 0;

        for(int i = len-2; i >= 0; --i){
            if(s.charAt(i)=='0') continue;
            else {
                ret[i] = Integer.parseInt(s.substring(i,i+2))<=26 ? ret[i+1]+ret[i+2] : ret[i+1];
            }
        }

        return ret[0];
    }
}

