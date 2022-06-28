'''
A string s is called good if there are no two different characters in s that have the same frequency.

Given a string s, return the minimum number of characters you need to delete to make s good.

The frequency of a character in a string is the number of times it appears in the string. For example, in the string "aab", the frequency of 'a' is 2, while the frequency of 'b' is 1.



Example 1:

Input: s = "aab"
Output: 0
Explanation: s is already good.
Example 2:

Input: s = "aaabbbcc"
Output: 2
Explanation: You can delete two 'b's resulting in the good string "aaabcc".
Another way it to delete one 'b' and one 'c' resulting in the good string "aaabbc".
Example 3:

Input: s = "ceabaacb"
Output: 2
Explanation: You can delete both 'c's resulting in the good string "eabaab".
Note that we only care about characters that are still in the string at the end (i.e. frequency of 0 is ignored).


Constraints:

1 <= s.length <= 105
s contains only lowercase English letters.
'''

'''
Solution 1:
get character frequency array
for each character, check if its frequency is duplicated with previous checked one or not, if duplicated, while loop to remove one char each time until no duplication there

Time Complexity: O(n)
- n is input string length
Space Complexity: O(n)
'''
class Solution:
    def minDeletions(self, s: str) -> int:
        freq = [0 for i in range(26)]
        for c in s:
            freq[ord(c)-ord('a')] += 1

        remove = 0
        visited = set()
        for i in range(26):
            if freq[i] != 0:
                if freq[i] in visited:
                    temp = freq[i]
                    while temp > 0 and temp in visited:
                        temp -= 1
                    remove += freq[i] - temp
                    visited.add(temp)
                else:
                    visited.add(freq[i])
        return remove

