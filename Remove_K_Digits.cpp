/*402. Remove K Digits  QuestionEditorial Solution  My Submissions
Total Accepted: 2948 Total Submissions: 10660 Difficulty: Medium
Given a non-negative integer num represented as a string, remove k digits from the number so that the new number is the smallest possible.

Note:
The length of num is less than 10002 and will be ≥ k.
The given num does not contain any leading zero.
Example 1:

Input: num = "1432219", k = 3
Output: "1219"
Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
Example 2:

Input: num = "10200", k = 1
Output: "200"
Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
Example 3:

Input: num = "10", k = 2
Output: "0"
Explanation: Remove all the digits from the number and it is left with nothing which is 0.
Subscribe to see which companies asked this question*/




/*use "remain" to keep the size of the ret string
start from the begin of string, if current int smaller than former int, pop former character
out, push current in
after pushing, resize to shorten the size to "remain" size
then remove the first 0*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    string removeKdigits(string num, int k) {
        int remain = num.size()-k;
        string ret(remain,0);
        int index = 0;
        for(int i = 0; i < num.size(); ++i){
            while((num.size()-i>remain-index) && index>0 && ret[index-1]>num[i]){
                index--;
            }
            if(index<remain) ret[index++] = num[i];
        }
        
        index = 0;
        while(index<remain && ret[index]=='0'){
            ret.erase(ret.begin());
        }
        
        return ret.empty() ? "0" : ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String removeKdigits(String num, int k) {
        int remain = num.length() - k;
        char[] numArray = num.toCharArray();
        char[] ret = new char[remain];
        int index = 0;
        for(int i = 0; i < numArray.length; ++i){
        	// n-i>remain-index---have enough remaining digits to be compared
            while((numArray.length-i>remain-index) && index>0 && ret[index-1]>numArray[i]){
                index--;
            }
            if(index<remain) ret[index++] = numArray[i];
            //System.out.println(ret);
        }

        index = 0;
        while(index < remain && ret[index]=='0'){
            index++;
        }
        
        String s = new String(ret).substring(index);
        
        return s.length()==0 ? "0" : s;
    }
}
