/*10. Regular Expression Matching  QuestionEditorial Solution  My Submissions
Total Accepted: 101002 Total Submissions: 438570 Difficulty: Hard
Implement regular expression matching with support for '.' and '*'.

'.' Matches any single character.
'*' Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

The function prototype should be:
bool isMatch(const char *s, const char *p)

Some examples:
isMatch("aa","a") → false
isMatch("aa","aa") → true
isMatch("aaa","aa") → false
isMatch("aa", "a*") → true
isMatch("aa", ".*") → true
isMatch("ab", ".*") → true
isMatch("aab", "c*a*b") → true
Hide Company Tags Google Uber Airbnb Facebook Twitter
Hide Tags Dynamic Programming Backtracking String
Hide Similar Problems (H) Wildcard Matching
*/



/*DP dynamic programming
use dp[i][j] to check if two string is match the pattern
first initialize false, except dp[0][0]=true
dp[i][j]=true, if s[0...i-1] matches p[0...j-1]
i is control s, j is control p
P[i][j] = P[i - 1][j - 1], if p[j - 1] != '*' && (s[i - 1] == p[j - 1] || p[j - 1] == '.');
P[i][j] = P[i][j - 2], if p[j - 1] == '*' and the pattern repeats for 0 times;
P[i][j] = P[i - 1][j] && (s[i - 1] == p[j - 2] || p[j - 2] == '.'), if p[j - 1] == '*' and the pattern repeats for at least 1 times.

if p[j - 1] != '*'
   f[i][j] = f[i - 1][j - 1] && s[i - 1] == p[j - 1]
if p[j - 1] == '*', denote p[j - 2] with x
   f[i][j] is true iff any of the following is true
   1) "x*" repeats 0 time and matches empty: f[i][j - 2]
   2) "x*" repeats >= 1 times and matches "x*x": s[i - 1] == x && f[i - 1][j]
'.' matches any single character
return dp[m][n]*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
	bool isMatch(string s, string p) {
		int m = s.size();
		int n = p.size();
		vector<vector<bool>> dp(m + 1, vector<bool>(n + 1, false));
		dp[0][0] = true;
		for (int i = 0; i <= m; ++i) {
			for (int j = 1; j <= n; ++j) {
				if (p[j - 1] == '*') {
					dp[i][j] = dp[i][j - 2] || (i > 0 && dp[i - 1][j] && (s[i - 1] == p[j - 2] || p[j - 2] == '.') );
				} else {
					dp[i][j] = i > 0 && dp[i - 1][j - 1] && (s[i - 1] == p[j - 1] || p[j - 1] == '.');
				}
			}
		}
		return dp[m][n];
	}
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
	public boolean isMatch(String s, String p) {
		int m = s.length();
		int n = p.length();
		boolean[][] dp = new boolean[m + 1][n + 1];
		dp[0][0] = true; // If s and p are "", isMathch() returns true;
		for (int i = 0; i <= m; ++i) {
			for (int j = 1; j <= n; ++j) {//start  from 1
				if (p.charAt(j - 1) == '*') {
					// Two situations:
					// (1) dp[i][j-2] is true, and there is 0 preceding element of '*';
					// (2) The last character of s should match the preceding element of '*';
					//     And, dp[i-1][j] should be true;
					dp[i][j] = dp[i][j - 2]
					           || (i > 0 && dp[i - 1][j]
					               && (s.charAt(i - 1) == p.charAt(j - 2) || p.charAt(j - 2) == '.'));
				} else {
					// The last character of s and p should match;
					// And, dp[i-1][j-1] is true;
					dp[i][j] = i > 0 && dp[i - 1][j - 1] &&
					           (s.charAt(i - 1) == p.charAt(j - 1) || p.charAt(j - 1) == '.');
				}
			}
		}
		return dp[m][n];
	}
}
