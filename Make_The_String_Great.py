'''
Given a string s of lower and upper case English letters.

A good string is a string which doesn't have two adjacent characters s[i] and s[i + 1] where:

0 <= i <= s.length - 2
s[i] is a lower-case letter and s[i + 1] is the same letter but in upper-case or vice-versa.
To make the string good, you can choose two adjacent characters that make the string bad and remove them. You can keep doing this until the string becomes good.

Return the string after making it good. The answer is guaranteed to be unique under the given constraints.

Notice that an empty string is also good.



Example 1:

Input: s = "leEeetcode"
Output: "leetcode"
Explanation: In the first step, either you choose i = 1 or i = 2, both will result "leEeetcode" to be reduced to "leetcode".
Example 2:

Input: s = "abBAcC"
Output: ""
Explanation: We have many possible scenarios, and all lead to the same answer. For example:
"abBAcC" --> "aAcC" --> "cC" --> ""
"abBAcC" --> "abBA" --> "aA" --> ""
Example 3:

Input: s = "s"
Output: "s"


Constraints:

1 <= s.length <= 100
s contains only lower and upper case English letters.
'''

'''
Solution 1:
iterate string
check i-1, i is bad or not and remove
check i, i+1 is bad or not and remove

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def makeGood(self, s: str) -> str:
        stack = []

        def isBad(c1: str, c2: str) -> bool:
            if c1.islower() != c2.islower():
                return c1.lower() == c2.lower()
            return False

        for c in s:
            if stack and isBad(stack[-1], c):
                stack.pop(-1)
            else:
                stack.append(c)

        good = ""
        for c in stack:
            good += c
        return good
