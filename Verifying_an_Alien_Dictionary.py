'''
In an alien language, surprisingly they also use english lowercase letters, but possibly in a different order. The order of the alphabet is some permutation of lowercase letters.

Given a sequence of words written in the alien language, and the order of the alphabet, return true if and only if the given words are sorted lexicographicaly in this alien language.



Example 1:

Input: words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
Output: true
Explanation: As 'h' comes before 'l' in this language, then the sequence is sorted.
Example 2:

Input: words = ["word","world","row"], order = "worldabcefghijkmnpqstuvxyz"
Output: false
Explanation: As 'd' comes after 'l' in this language, then words[0] > words[1], hence the sequence is unsorted.
Example 3:

Input: words = ["apple","app"], order = "abcdefghijklmnopqrstuvwxyz"
Output: false
Explanation: The first three characters "app" match, and the second string is shorter (in size.) According to lexicographical rules "apple" > "app", because 'l' > '∅', where '∅' is defined as the blank character which is less than any other character (More info).


Constraints:

1 <= words.length <= 100
1 <= words[i].length <= 20
order.length == 26
All characters in words[i] and order are English lowercase letters.
'''

'''
Solution 3:
optimize solution 2
use function to help checking if two string is in order

Time Complexity: O(mn)
- n is words.count
- m is words[i].count
Space Complexity: O(1)
'''
class Solution:
    def isAlienSorted(self, words: List[str], order: str) -> bool:
        charIndex = [0 for _ in range(26)]
        i = 0
        for c in order:
            charIndex[ord(c)-ord('a')] = i
            i += 1

        def isInOrder(cur: str, next: str) -> bool:
            nonlocal charIndex
            i1 = 0
            i2 = 0
            n1 = len(cur)
            n2 = len(next)
            while i1 < n1 and i2 < n2:
                c1 = cur[i1]
                c2 = next[i2]
                if c1 != c2:
                    if charIndex[ord(c1)-ord('a')] > charIndex[ord(c2)-ord('a')]:
                        return False
                    elif charIndex[ord(c1)-ord('a')] < charIndex[ord(c2)-ord('a')]:
                        return True
                i1 += 1
                i2 += 1

            if i2 == n2 and i1 < n1:
                # ex: world, worl
                return False
            return True

        n = len(words)
        for i in range(n-1):
            if not isInOrder(words[i], words[i+1]):
                return False
        return True
