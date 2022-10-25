/*
Given two string arrays word1 and word2, return true if the two arrays represent
the same string, and false otherwise.

A string is represented by an array if the array elements concatenated in order
forms the string.



Example 1:

Input: word1 = ["ab", "c"], word2 = ["a", "bc"]
Output: true
Explanation:
word1 represents string "ab" + "c" -> "abc"
word2 represents string "a" + "bc" -> "abc"
The strings are the same, so return true.
Example 2:

Input: word1 = ["a", "cb"], word2 = ["ab", "c"]
Output: false
Example 3:

Input: word1  = ["abc", "d", "defg"], word2 = ["abcddefg"]
Output: true


Constraints:

1 <= word1.length, word2.length <= 103
1 <= word1[i].length, word2[i].length <= 103
1 <= sum(word1[i].length), sum(word2[i].length) <= 103
word1[i] and word2[i] consist of lowercase letters.

Hint1:
Concatenate all strings in the first array into a single string in the given
order, the same for the second array.

Hint2:
Both arrays represent the same string if and only if the generated strings are
the same.
*/

/*
Solution 1:
gen str1 for word1
gen str2 for word2
compare str1 == str2

Time Complexity: O(2n)
Space Complexity: O(1)
*/
class Solution {
 public:
  bool arrayStringsAreEqual(vector<string>& word1, vector<string>& word2) {
    return concat(word1) == concat(word2);
  }

  string concat(vector<string>& words) {
    string newStr = "";
    for (int i = 0; i < words.size(); i++) {
      newStr += words[i];
    }
    return newStr;
  }
};
