/*214. Shortest Palindrome   QuestionEditorial Solution  My Submissions
Total Accepted: 28317 Total Submissions: 128605 Difficulty: Hard Contributors: Admin
Given a string S, you are allowed to convert it to a palindrome by adding characters in front of it. Find and return the shortest palindrome you can find by performing this transformation.

For example:

Given "aacecaaa", return "aaacecaaa".

Given "abcd", return "dcbabcd".

Credits:
Special thanks to @ifanchu for adding this problem and creating all test cases. Thanks to @Freezen for additional test cases.

Hide Company Tags Pocket Gems Google
Hide Tags String
Hide Similar Problems (M) Longest Palindromic Substring (E) Implement strStr() (H) Palindrome Pairs
*/



/*
KMP algorithm (Knuth-Morris-Pratt 字符串查找算法) 可在一個主「文本字符串」S內查找一個「詞」W的出現位置。此算法通過運用對這個詞在不匹配時本身就包含足夠的信息來確定下一個匹配將在哪裡開始的發現，從而避免重新檢查先前匹配的字符

use a match[] to find 
the largest suffix of the reversed string which matches 
the prefix of the original string
return the rvs.substring(0,prefix)+s

We are only interested in the last value because it shows us the largest suffix of the reversed string that matches the prefix of the original string. So basically all we left to do is to add the first k characters of the reversed string to the original string, where k is a difference between original string size and the prefix function for the last character of a constructed string.
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    string shortestPalindrome(string s) {
        string rvs = s;
        reverse(rvs.begin(), rvs.end());
        string l = s + "#"+rvs;
        vector<int> match(l.size(),0);
        for(int i = 1; i < l.size(); ++i){
            int j = match[i-1];
            while(j>0 && l[i]!=l[j]){
                j = match[j-1];
            }
            match[i] = (j += l[i]==l[j]);
        }
        return rvs.substr(0,s.size()-match[l.size()-1]) + s;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String shortestPalindrome(String s) {
        //get the reverse string
        String rvs = new StringBuilder(s).reverse().toString();
        String l = s + "#" + rvs; //combine together
        
        //help check from each index is equal to the original string
        int[] match = new int[l.length()];
        for(int i = 1; i < l.length(); ++i){
            int j = match[i-1];
            while(j>0 && l.charAt(i)!=l.charAt(j)){
                j = match[j-1]; //check from the former char
            }
            //in java, add ? : to determine add 1 or not add
            match[i] = (j += (l.charAt(i)==l.charAt(j) ? 1 : 0));
        }
        
        //match[l.length()-1] number of chars are equal
        //s.length()-match[l.length()-1] number of chars are not equal
        //add from the start of s
        return rvs.substring(0, s.length()-match[l.length()-1]) + s;
    }
}
