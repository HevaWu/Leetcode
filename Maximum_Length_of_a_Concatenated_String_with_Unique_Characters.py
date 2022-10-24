'''
You are given an array of strings arr. A string s is formed by the concatenation of a subsequence of arr that has unique characters.

Return the maximum possible length of s.

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.



Example 1:

Input: arr = ["un","iq","ue"]
Output: 4
Explanation: All the valid concatenations are:
- ""
- "un"
- "iq"
- "ue"
- "uniq" ("un" + "iq")
- "ique" ("iq" + "ue")
Maximum length is 4.
Example 2:

Input: arr = ["cha","r","act","ers"]
Output: 6
Explanation: Possible longest valid concatenations are "chaers" ("cha" + "ers") and "acters" ("act" + "ers").
Example 3:

Input: arr = ["abcdefghijklmnopqrstuvwxyz"]
Output: 26
Explanation: The only string in arr has all 26 characters.


Constraints:

1 <= arr.length <= 16
1 <= arr[i].length <= 26
arr[i] contains only lowercase English letters.
'''

'''
Solution 1:
bit to store each unique char in string
then backtrack to see if this string can be cancat

when map str to bit integer, if current str contains duplicate chars, return -1

Time Complexity: O(26n + 2^n)
Space Complexity: O(n)
'''
class Solution:
    def maxLength(self, arr: List[str]) -> int:
        n = len(arr)
        bitArr = [self.convertToInt(arr[i]) for i in range(n)]
        maxLen = 0

        def check(index: int, curVal: int, curLen: int):
            nonlocal maxLen, n, bitArr, arr
            if index == n:
                maxLen = max(maxLen, curLen)
                return

            # concat
            if bitArr[index] != -1 and ((curVal & bitArr[index]) == 0):
                check(index+1, curVal | bitArr[index], curLen + len(arr[index]))

            # not concat
            check(index+1, curVal, curLen)

        check(0, 0, 0)
        return maxLen


    def convertToInt(self, word: str) -> int:
        bitVal = 0
        for c in word:
            val = 1 << (ord(c) - ord('a'))
            if (bitVal & val) != 0: return -1
            bitVal |= val
        return bitVal
