/*345. Reverse Vowels of a String  QuestionEditorial Solution  My Submissions
Total Accepted: 46467 Total Submissions: 127032 Difficulty: Easy
Write a function that takes a string as input and reverse only the vowels of a
string.

Example 1:
Given s = "hello", return "holle".

Example 2:
Given s = "leetcode", return "leotcede".

Note:
The vowels does not include the letter "y".

Hide Company Tags Google
Hide Tags Two Pointers String
Hide Similar Problems (E) Reverse String
*/

/*use two pointers, one point start, one point end
once find vowels at start and end, swap them*/

class Solution {
 public:
  string reverseVowels(string s) {
    auto start = s.begin(), end = s.end() - 1;
    string vowels = "aeiouAEIOU";
    while (start < end) {
      // string::npos ------until the end of the string"
      while (vowels.find(*start) == string::npos && start < end) start++;
      while (vowels.find(*end) == string::npos && start < end) end--;
      if (start < end) swap(*start, *end);
      start++;
      end--;
    }

    return s;
  }
};
