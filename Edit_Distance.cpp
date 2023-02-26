/*
Given two strings word1 and word2, return the minimum number of operations
required to convert word1 to word2.

You have the following three operations permitted on a word:

Insert a character
Delete a character
Replace a character


Example 1:

Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation:
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')
Example 2:

Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation:
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')


Constraints:

0 <= word1.length, word2.length <= 500
word1 and word2 consist of lowercase English letters.
*/

/*
Solution 3:
DP optimize solution 1 by using 1 array

Time Complexity: O(m*n)
Space Complexity: O(n)
*/
class Solution {
 public:
  int minDistance(string word1, string word2) {
    if (word1.empty()) {
      return word2.size();
    }
    if (word2.empty()) {
      return word1.size();
    }

    int m = word1.size();
    int n = word2.size();

    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
      dp[i] = i;
    }

    for (int i = 1; i <= m; i++) {
      int pre = dp[0];
      dp[0] = i;
      for (int j = 1; j <= n; j++) {
        int temp = dp[j];
        if (word1[i - 1] == word2[j - 1]) {
          dp[j] = pre;
        } else {
          dp[j] = min(pre, min(dp[j - 1], dp[j])) + 1;
        }
        pre = temp;
      }
    }

    return dp[n];
  }
};
