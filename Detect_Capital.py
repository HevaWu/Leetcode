'''
We define the usage of capitals in a word to be right when one of the following cases holds:

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
'''

'''
Solution 1:
check all of uppercase count in the string

Time Complexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def detectCapitalUse(self, word: str) -> bool:
        isUpper = 0
        for c in word:
            if c.isupper():
                isUpper += 1
        return isUpper == 0 or isUpper == len(word) or (isUpper == 1 and word[0].isupper())