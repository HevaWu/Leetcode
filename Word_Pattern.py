'''
Given a pattern and a string s, find if s follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.



Example 1:

Input: pattern = "abba", s = "dog cat cat dog"
Output: true
Example 2:

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
Example 3:

Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false


Constraints:

1 <= pattern.length <= 300
pattern contains only lower-case English letters.
1 <= s.length <= 3000
s contains only lowercase English letters and spaces ' '.
s does not contain any leading or trailing spaces.
All the words in s are separated by a single space.
'''

'''
Solution 1
2 maps

wordToLetter
letterToWord

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        words = s.split(' ')
        if len(pattern) != len(words):
            return False

        wordToLetter = {}
        letterToWord = {}
        for i in range(len(pattern)):
            letter = pattern[i]
            word = words[i]
            if word in wordToLetter and wordToLetter[word] != letter:
                return False
            if letter in letterToWord and letterToWord[letter] != word:
                return False
            wordToLetter[word] = letter
            letterToWord[letter] = word

        return True

