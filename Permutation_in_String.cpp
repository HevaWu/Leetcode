
/*
Given two strings s1 and s2, return true if s2 contains a permutation of s1, or
false otherwise.

In other words, return true if one of s1's permutations is the substring of s2.



Example 1:

Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").
Example 2:

Input: s1 = "ab", s2 = "eidboaoo"
Output: false


Constraints:

1 <= s1.length, s2.length <= 104
s1 and s2 consist of lowercase English letters.
*/

/*
Solution 2:
Optimize solution 1
when track s2, keep window
then check if window is same as freq

Time Complexity: O(n1 + n2)
Space Complexity: O(26)
*/
class Solution {
 public:
  bool checkInclusion(string s1, string s2) {
    vector<int> freq1(26, 0);
    for (char c : s1) {
      freq1[c - 'a'] += 1;
    }

    vector<int> freq2(26, 0);
    int size = s1.size();
    for (int i = 0; i < s2.size(); i++) {
      freq2[s2[i] - 'a'] += 1;
      int start = i - size;
      if (start >= 0) {
        freq2[s2[start] - 'a'] -= 1;
      }
      if (freq1 == freq2) {
        return true;
      }
    }
    return false;
  }
};
