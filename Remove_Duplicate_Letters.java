/*316. Remove Duplicate Letters   QuestionEditorial Solution  My Submissions
Total Accepted: 22635
Total Submissions: 80596
Difficulty: Hard
Contributors: Admin
Given a string which contains only lowercase letters, remove duplicate letters so that every letter appear once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.

Example:
Given "bcabc"
Return "abc"

Given "cbacdcbc"
Return "acdb"

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Subscribe to see which companies asked this question

Hide Tags Stack Greedy
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*O(26n)=O(n)
recursively do this function
1. record the repeat times of each character
2. find the position for the smallest s[i]
3. current s.pos + the remainning string replace all the current s.pos*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String removeDuplicateLetters(String s) {
        int[] str = new int[26];

        //record the letters repeat times
        for(int i = 0; i < s.length(); ++i){
            str[s.charAt(i)-'a']++;
        }

        int pos = 0; //record the smallest value in this string
        for(int i = 0; i < s.length(); ++i){
            if(s.charAt(i) < s.charAt(pos)){
                pos = i;
            }
            if(--str[s.charAt(i)-'a'] == 0) break;
        }

        return s.length()==0 ? "" : s.charAt(pos) + removeDuplicateLetters(s.substring(pos+1).replaceAll(s.charAt(pos)+"", ""));//replace the same charcter as current pos
    }
}
