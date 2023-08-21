/*
Given a string s, check if it can be constructed by taking a substring of it and appending multiple copies of the substring together.

 

Example 1:

Input: s = "abab"
Output: true
Explanation: It is the substring "ab" twice.
Example 2:

Input: s = "aba"
Output: false
Example 3:

Input: s = "abcabcabcabc"
Output: true
Explanation: It is the substring "abc" four times or the substring "abcabc" twice.
 

Constraints:

1 <= s.length <= 104
s consists of lowercase English letters.
*/

/*
Solution 1:
Iterate the string, once found the s[i]==s[j], dp[i]=j
at the end, check if 
- dp[n] != 0 -> this means there is some patterns chars founded
- dp[n]%(n-dp[n]) -> this means the remaining chars could be repeated completely by (n-dp[n]) sub arrays

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
public:
    bool repeatedSubstringPattern(string s) {
        int i = 1;
        int j = 0;
        int n = s.size();
        // dp[i] the characters in [0..<i] that could be repeated by s[0..<n-dp[i])
        vector<int> dp(n+1, 0);
        while (i < n) {
            if (s[i] == s[j]) {
                i += 1;
                j += 1;
                dp[i] = j;
            } else if (j == 0) {
                i += 1;
            } else {
                j = dp[j];
            }
        }
        return (dp[n] != 0) && (dp[n]%(n-dp[n]) == 0);
    }
};