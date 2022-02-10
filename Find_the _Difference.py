'''
You are given two strings s and t.

String t is generated by random shuffling string s and then add one more letter at a random position.

Return the letter that was added to t.



Example 1:

Input: s = "abcd", t = "abcde"
Output: "e"
Explanation: 'e' is the letter that was added.
Example 2:

Input: s = "", t = "y"
Output: "y"


Constraints:

0 <= s.length <= 1000
t.length == s.length + 1
s and t consist of lowercase English letters
'''

'''
Solution 1:
use int array to store appearance in s,
then go through t, check if we could remove this appeared

Time Complexity: O(n)
- n is s.count
Space Complexity: O(1)
'''
class Solution:
    def findTheDifference(self, s: str, t: str) -> str:
        sarr = [0 for i in range(26)]
        for c in s:
            sarr[ord(c) - ord('a')] += 1
        for c in t:
            index = ord(c) - ord('a')
            if sarr[index] == 0:
                return c
            sarr[index] -= 1
        return '*'