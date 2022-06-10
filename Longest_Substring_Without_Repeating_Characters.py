'''
Given a string, find the length of the longest substring without repeating characters.

Example 1:

Input: "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
Example 2:

Input: "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
Example 3:

Input: "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
             Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
'''

'''
Solution 3:
Optimize to only need n steps, we could define a mapping of the characters to its index. Then we can skip the characters immediately when we found a repeated character.
We could skip all elements in the range [i, j1] and let i = jto just skip
//
Time complexity : O(n). Index j will iterate nn times.
Space complexity (HashMap) : O(min(m, n)). Same as the previous approach.
'''
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        l = 0
        r = 0
        dic = {}
        longest = 0
        while r < len(s):
            if s[r] in dic:
                index = dic[s[r]]
                l = max(l, index)
            longest = max(longest, r-l+1)
            dic[s[r]] = r+1
            r += 1

        return longest

