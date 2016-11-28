/*151. Reverse Words in a String   QuestionEditorial Solution  My Submissions
Total Accepted: 129391
Total Submissions: 823642
Difficulty: Medium
Contributors: Admin
Given an input string, reverse the string word by word.

For example,
Given s = "the sky is blue",
return "blue is sky the".

Update (2015-02-12):
For C programmers: Try to solve it in-place in O(1) space.

click to show clarification.

Clarification:
What constitutes a word?
A sequence of non-space characters constitutes a word.
Could the input string contain leading or trailing spaces?
Yes. However, your reversed string should not contain leading or trailing spaces.
How about multiple spaces between two words?
Reduce them to a single space in the reversed string.
Subscribe to see which companies asked this question

Hide Tags String
Hide Similar Problems (M) Reverse Words in a String II
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*1. split the string
2. insert from the end of the string[]*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String reverseWords(String s) {
        String[] str = s.trim().split("\\s+"); //split by multiple whitespace
        String ret = ""; //the return string
        for(int i = str.length-1; i > 0; i--){
            ret += str[i] + " "; //use space to split the diff word
        }
        return ret + str[0];
    }
}
