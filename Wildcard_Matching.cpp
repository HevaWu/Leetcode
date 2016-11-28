/*44. Wildcard Matching  QuestionEditorial Solution  My Submissions
Total Accepted: 71003 Total Submissions: 383621 Difficulty: Hard
Implement wildcard pattern matching with support for '?' and '*'.

'?' Matches any single character.
'*' Matches any sequence of characters (including the empty sequence).

The matching should cover the entire input string (not partial).

The function prototype should be:
bool isMatch(const char *s, const char *p)

Some examples:
isMatch("aa","a") → false
isMatch("aa","aa") → true
isMatch("aaa","aa") → false
isMatch("aa", "*") → true
isMatch("aa", "a*") → true
isMatch("ab", "?*") → true
isMatch("aab", "c*a*b") → false
Hide Company Tags Google Snapchat Facebook
Hide Tags Dynamic Programming Backtracking Greedy String
Hide Similar Problems (H) Regular Expression Matching
*/



/*linear time    constant space
use two index, i1 for str, i2 for pattern
index for *
match for * at s postion
start checking string
	if p[i2]=='?' or s[i1]==p[i2], increase i1, i2
	else if p[i2]=='*', mark this position as index, match=i1
	else if index!=-1, means exist *, i2=index+1, match++, i1=match
	else return false, character does not match
start checking remaing char in pattern
	while (p < pattern.length() && pattern.charAt(p) == '*') p++;
return p == pattern.length();
	*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool isMatch(string s, string p) {
        int i1 = 0; //point to s
        int i2 = 0; //point to p
        int match = 0;
        int index = -1; 
        while(i1 < s.size()){
            if(i2<p.size() && 
                (p[i2]=='?' || s[i1]==p[i2])){
                    i1++;
                    i2++;
            } else if(i2<p.size() && p[i2]=='*'){
                index = i2;
                match = i1;
                i2++;
            } else if(index!=-1){
                i2 = index+1;
                match++;
                i1 = match;
            } else {
                return false;
            }
        }
        
        while(i2<p.size() && p[i2]=='*'){
            i2++;
        }
        
        return i2==p.size();
        
    }
};



/*DP
O(mn) time and O(mn) space
initialize dp[0][j], j = [1, n]. In this case, s has nothing, to get dp[0][j] = true, p must be '*', '*', '**',etc. Once p.charAt(j-1) != '*', all the dp[0][j] afterwards will be false.

Then start the typical DP loop.
if p[j-1]!='*', dp[i][j] = dp[i-1][j-1] && 
							(s.charAt(i-1)==p.charAt(j-1) || p.charAt(j-1)=='?');
else dp[i][j] = dp[i-1][j] || dp[i][j-1];

Improvement: 
1) optimize 2d dp to 1d dp, this will save space, reduce space complexity to O(N). 
2) use iterative 2-pointer. 2 index*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isMatch(String s, String p) {
        int m = s.length();
        int n = p.length();
        boolean[][] ret = new boolean[m+1][n+1];
        ret[0][0] = true;
        
        for(int i = 1; i <= m; ++i){
            ret[i][0] = false;
        }
        
        for(int j = 1; j <= n; ++j){
            if(p.charAt(j-1)=='*'){
                ret[0][j] = true;
            } else {
                break;
            }
        }
        
        //start DP
        for(int i = 1; i <= m; ++i){
            for(int j = 1; j <= n; ++j){
                if(p.charAt(j-1)!='*'){
                    ret[i][j] = ret[i-1][j-1] && 
                        (s.charAt(i-1)==p.charAt(j-1) || p.charAt(j-1)=='?');
                } else {
                    ret[i][j] = ret[i-1][j] || ret[i][j-1];
                }
            }
        }
        
        return ret[m][n];
    }
}



public class Solution {
    public boolean isMatch(String s, String p) {
        int i1 = 0; //index for s
        int i2 = 0; //index for p
        int match = 0; //mark if match at s
        int index = -1; //mark * position at p
        while(i1 < s.length()){
            if(i2<p.length() && 
                (p.charAt(i2)=='?' || s.charAt(i1)==p.charAt(i2))){
                    i1++;
                    i2++;
            } else if(i2<p.length() && p.charAt(i2)=='*'){
                index = i2;
                match = i1;
                i2++;
            } else if(index != -1){
                //there is a *
                i2 = index+1;
                match++;
                i1 = match;
            } else {
                return false;
            }
        }
        
        while(i2<p.length() && p.charAt(i2)=='*'){
            i2++;
        }
        
        return i2==p.length();
    }
}
