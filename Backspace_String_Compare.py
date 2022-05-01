'''
Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.

Example 1:

Input: S = "ab#c", T = "ad#c"
Output: true
Explanation: Both S and T become "ac".
Example 2:

Input: S = "ab##", T = "c#d#"
Output: true
Explanation: Both S and T become "".
Example 3:

Input: S = "a##c", T = "#a#c"
Output: true
Explanation: Both S and T become "c".
Example 4:

Input: S = "a#c", T = "b"
Output: false
Explanation: S becomes "c" while T becomes "b".
Note:

1 <= S.length <= 200
1 <= T.length <= 200
S and T only contain lowercase letters and '#' characters.
Follow up:

Can you solve it in O(N) time and O(1) space?
'''

'''
Solution 2:
Iterate through the string in reverse. If we see a backspace character, the next non-backspace character is skipped. If a character isn't skipped, it is part of the final answer.

Time Complexity: O(M + N), where M, NM,N are the lengths of S and T respectively.
Space Complexity: O(1).
'''
class Solution:
    def backspaceCompare(self, s: str, t: str) -> bool:
        si = len(s) - 1
        ti = len(t) - 1

        skips = 0
        skipt = 0

        def getIndexAndSkip(string: str, index: int, skip: int):
            while index >= 0:
                if string[index] == '#':
                    index -= 1
                    skip += 1
                elif skip > 0:
                    index -= 1
                    skip -= 1
                else:
                    return index, skip
            return index, skip

        while si >= 0 or ti >= 0:
            si, skips = getIndexAndSkip(s, si, skips)
            ti, skipt = getIndexAndSkip(t, ti, skipt)
            if si >= 0 and ti >= 0 and s[si] == t[ti]:
                si -= 1
                ti -= 1
            elif si < 0 and ti < 0:
                return True
            else:
                return False

        return True