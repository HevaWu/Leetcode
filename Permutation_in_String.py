'''
Given two strings s1 and s2, return true if s2 contains a permutation of s1, or false otherwise.

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
'''

'''
Solution 2:
Optimize solution 1
when track s2, keep window
then check if window is same as freq

Time Complexity: O(n1 + n2)
Space Complexity: O(26)
'''
class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        freq1 = [0 for _ in range(26)]
        n1 = len(s1)
        for c in s1:
            freq1[ord(c) - ord("a")] += 1

        freq2 = [0 for _ in range(26)]
        for i in range(len(s2)):
            freq2[ord(s2[i]) - ord("a")] += 1
            start = i-n1
            if start >= 0:
                freq2[ord(s2[start]) - ord("a")] -= 1
            if freq1 == freq2:
                return True
        return False
