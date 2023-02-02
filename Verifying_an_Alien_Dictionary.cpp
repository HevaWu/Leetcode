/*
In an alien language, surprisingly they also use english lowercase letters, but
possibly in a different order. The order of the alphabet is some permutation of
lowercase letters.

Given a sequence of words written in the alien language, and the order of the
alphabet, return true if and only if the given words are sorted lexicographicaly
in this alien language.



Example 1:

Input: words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
Output: true
Explanation: As 'h' comes before 'l' in this language, then the sequence is
sorted. Example 2:

Input: words = ["word","world","row"], order = "worldabcefghijkmnpqstuvxyz"
Output: false
Explanation: As 'd' comes after 'l' in this language, then words[0] > words[1],
hence the sequence is unsorted. Example 3:

Input: words = ["apple","app"], order = "abcdefghijklmnopqrstuvwxyz"
Output: false
Explanation: The first three characters "app" match, and the second string is
shorter (in size.) According to lexicographical rules "apple" > "app", because
'l' > '∅', where '∅' is defined as the blank character which is less than any
other character (More info).


Constraints:

1 <= words.length <= 100
1 <= words[i].length <= 20
order.length == 26
All characters in words[i] and order are English lowercase letters.
*/

/*
Solution 3:
optimize solution 2
use function to help checking if two string is in order

Time Complexity: O(mn)
- n is words.count
- m is words[i].count
Space Complexity: O(1)
*/
class Solution {
 public:
  bool isAlienSorted(vector<string>& words, string order) {
    int charIndex[26];
    int i = 0;
    for (char c : order) {
      charIndex[c - 'a'] = i;
      i += 1;
    }

    int n = words.size();
    for (int i = 0; i < n - 1; i++) {
      string cur = words[i];
      string next = words[i + 1];
      if (!isInOrder(cur, next, charIndex)) {
        return false;
      }
    }
    return true;
  }

  bool isInOrder(string cur, string next, int charIndex[]) {
    int i1 = 0;
    int i2 = 0;
    int n1 = cur.size();
    int n2 = next.size();
    while (i1 < n1 && i2 < n2) {
      char c1 = cur[i1];
      char c2 = next[i2];
      if (c1 != c2) {
        if (charIndex[c1 - 'a'] > charIndex[c2 - 'a']) {
          return false;
        } else if (charIndex[c1 - 'a'] < charIndex[c2 - 'a']) {
          return true;
        }
      }
      i1 += 1;
      i2 += 1;
    }

    if (i2 == n2 && i1 < n1) {
      // ex: world, worl
      return false;
    }
    return true;
  }
};
