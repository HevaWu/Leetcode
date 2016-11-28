/*242. Valid Anagram  QuestionEditorial Solution  My Submissions
Total Accepted: 107559
Total Submissions: 246357
Difficulty: Easy
Given two strings s and t, write a function to determine if t is an anagram of s.

For example,
s = "anagram", t = "nagaram", return true.
s = "rat", t = "car", return false.

Note:
You may assume the string contains only lowercase alphabets.

Follow up:
What if the inputs contain unicode characters? How would you adapt your solution to such case?

Subscribe to see which companies asked this question*/



/*use an extra array to store the count of each alphabet in string s and string t
one insert, one delete, if there are some count of element is not 0, return false
else return true*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool isAnagram(string s, string t) {
        if(s.length() != t.length()) return false;
        vector<int> snum(26,0);
        for(int i = 0; i < s.length(); i++)
        {
            snum[s[i]-'a']++;
            snum[t[i]-'a']--;
        }
        for(int i = 0; i < snum.size(); i++)
        {
            if(snum[i]) return false;
        }
        return true;
    }
};






/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isAnagram(String s, String t) {
        int[] temp = new int[26];
        if(s.length() != t.length()) return false;
        
        for(int i = 0; i < s.length(); ++i){
            temp[s.charAt(i)-'a']++;  //use charAt to get the char
            temp[t.charAt(i)-'a']--;
        }
        
        for(int i:temp){
            if(i!=0) return false;
        }
        
        return true;
    }
}