'''
Given two binary strings a and b, return their sum as a binary string.



Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"


Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.
'''

'''
Solution 3:
from end to start, check each char

Time Complexity: O(max(na, nb))
Space Complexity: O(max(na, nb))
'''
class Solution:
    def addBinary(self, a: str, b: str) -> str:
        res = ""
        i = len(a) - 1
        j = len(b) - 1
        current = 0
        while i >= 0 or j >= 0:
            current += (ord(a[i])-ord('0') if i >= 0 else 0) + (ord(b[j])-ord('0') if j >= 0 else 0)
            res =  chr((int)(current % 2) + ord('0')) + res
            current = current // 2
            if i >= 0:
                i -= 1
            if j >= 0:
                j -= 1
        if current > 0:
            res = '1' + res
        return res
