/*186. Reverse Words in a String II Add to List
Description  Submission  Solutions
Total Accepted: 22853
Total Submissions: 81778
Difficulty: Medium
Contributors: Admin
Given an input string, reverse the string word by word. A word is defined as a sequence of non-space characters.

The input string does not contain leading or trailing spaces and the words are always separated by a single space.

For example,
Given s = "the sky is blue",
return "blue is sky the".

Could you do it in-place without allocating extra space?

Related problem: Rotate Array

Hide Company Tags Amazon Microsoft Uber
Hide Tags String
Hide Similar Problems (M) Reverse Words in a String (E) Rotate Array
 */






/*
1. reverse the order
2. reverse the word
3. trim whitespace char
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public void reverseWords(char[] s) {
        if(s.length == 0) return;
        int len = s.length;
        //reverse the order in the array
        reverseOrder(s, 0, len-1);

        //reverse each word
        for(int i = 0; i < len; ++i){
            if(s[i] == ' ') continue;
            int start = i;
            while(i < len && s[i]!=' ') i++;
            reverseOrder(s, start, i-1);
        }
    }

    public void reverseOrder(char[] s, int start, int end){
        while(start < end){
            char temp = s[start];
            s[start++] = s[end];
            s[end--] = temp;
        }
    }
}
