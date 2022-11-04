'''
Given a string s, reverse only all the vowels in the string and return it.

The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.



Example 1:

Input: s = "hello"
Output: "holle"
Example 2:

Input: s = "leetcode"
Output: "leotcede"


Constraints:

1 <= s.length <= 3 * 105
s consist of printable ASCII characters.
'''


'''
Solution 1:
2 pointer

Time Complexity: O(n)
Space Complexity: O(1)
'''
class Solution:
    def reverseVowels(self, s: str) -> str:
        i = 0
        j = len(s)-1
        vowelSet = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'}
        slist = list(s)
        while i < j:
            while i < j and slist[i] not in vowelSet: i += 1
            while i < j and slist[j] not in vowelSet: j -= 1
            slist[i], slist[j] = slist[j], slist[i]
            i += 1
            j -= 1
        return ''.join(slist)
