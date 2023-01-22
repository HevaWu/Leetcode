/*
Given a string s, partition s such that every substring of the partition is a
palindrome. Return all possible palindrome partitioning of s.

A palindrome string is a string that reads the same backward as forward.



Example 1:

Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]
Example 2:

Input: s = "a"
Output: [["a"]]


Constraints:

1 <= s.length <= 16
s contains only lowercase English letters.
*/

/*
Solution 2: DP
use cache to store if i,j is palindrome

dp[n] is [[String]]() type object
dp[i+1]:
- if left,i is palindrome, for loop dp[left], append s[left...i] to dp[i+1]

Time Complexity:
O(n* 2^n)

Space Complexity:
O(n^2)
*/
class Solution {
 public:
  vector<vector<string>> partition(string s) {
    if (s.size() <= 0) return vector<vector<string>>();

    int n = s.size();
    vector<vector<vector<string>>> res(n + 1);
    res[0] = vector<vector<string>>();
    vector<vector<bool>> cache(n, vector<bool>(n, false));
    for (int i = 0; i < n; ++i) {
      res[i + 1] = vector<vector<string>>();
      for (int left = 0; left <= i; ++left) {
        if (s[left] == s[i] &&
            (i - left <= 1 || cache[left + 1][i - 1] == true)) {
          cache[left][i] = true;
          string str = s.substr(left, i - left + 1);
          if (res[left].size() == 0) {
            vector<string> temp;
            temp.push_back(str);
            res[i + 1].push_back(temp);
            continue;
          }
          for (vector<string> r : res[left]) {
            vector<string> temp = r;
            temp.push_back(str);
            res[i + 1].push_back(temp);
          }
        }
      }
    }

    return res[n];
  }
};
