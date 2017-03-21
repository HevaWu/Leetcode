/*344. Reverse String Add to List
Description  Submission  Solutions
Total Accepted: 136348
Total Submissions: 235221
Difficulty: Easy
Contributors: Admin
Write a function that takes a string as input and returns the string reversed.

Example:
Given s = "hello", return "olleh".

Hide Tags Two Pointers String
Hide Similar Problems (E) Reverse Vowels of a String
 */






/*
two pointer
at the end, use String.valueOf(c) or new String(c) to transfer char[] to String
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String reverseString(String s) {
        if(s==null || s.length()==0) return s;

        char[] c = s.toCharArray();
        int start = 0;
        int end = s.length()-1;
        while(start < end){
            char temp = c[start];
            c[start++] = c[end];
            c[end--] = temp;
        }
        //use valueOf() to transfer char[] to String
        return String.valueOf(c);
    }
}
