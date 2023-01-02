/*
We define the usage of capitals in a word to be right when one of the following
cases holds:

All letters in this word are capitals, like "USA".
All letters in this word are not capitals, like "leetcode".
Only the first letter in this word is capital, like "Google".
Given a string word, return true if the usage of capitals in it is right.



Example 1:

Input: word = "USA"
Output: true
Example 2:

Input: word = "FlaG"
Output: false


Constraints:

1 <= word.length <= 100
word consists of lowercase and uppercase English letters.
*/

/*
Solution 2:
check all of uppercase count in the string

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
 public:
  bool detectCapitalUse(string word) {
    int n = word.size();
    int capital = 0;
    for (char c : word) {
      if (isupper(c)) {
        capital += 1;
      }
    }
    return capital == n || capital == 0 || (capital == 1 && isupper(word[0]));
  }
};
