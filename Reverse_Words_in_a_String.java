/*151. Reverse Words in a String Add to List
Description  Submission  Solutions
Total Accepted: 144940
Total Submissions: 921627
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
Hide Company Tags Microsoft Snapchat Apple Bloomberg Yelp
Hide Tags String
Hide Similar Problems (M) Reverse Words in a String II
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 3 faster than Solution 2 faster than Solution 1

Solution 1: split and trim, for
1. split the string
2. insert from the end of the string[]

Solution 2: split, trim, collections.reverse
use Collections.reverse(Arrays.asList(str));
then join String.join(" ", str);

Solution 3: Stringbuilder
use while loop to check if current substring is a word
i is the start of the word
end is the end of the word
at the end str.toString().trim()
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1: split and trim, for
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


//Solution 2: collections.reverse, string.join
public class Solution {
    public String reverseWords(String s) {
        if(s.length()==0) return s;
        String[] str = s.trim().split("\\s+");
        Collections.reverse(Arrays.asList(str));
        return String.join(" ", str);
    }
}



//Solution 3: stringbuilder
public class Solution {
    public String reverseWords(String s) {
        if(s.length() == 0) return s;
        StringBuilder str = new StringBuilder();

        int len = s.length();
        int end = len-1;
        //i is the start of the substring
        for(int i = len-1; i >= 0; --i){
            if(s.charAt(i) == ' '){
                continue;
            }
            end = i;
            while(i>=0 && s.charAt(i)!=' '){
                i--;
            }
            str.append(s.substring(i+1, end+1)).append(" ");
        }
        return str.toString().trim(); //rememeber trim()
    }
}
