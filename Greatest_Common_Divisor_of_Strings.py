'''
For two strings s and t, we say "t divides s" if and only if s = t + ... + t (i.e., t is concatenated with itself one or more times).

Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.



Example 1:

Input: str1 = "ABCABC", str2 = "ABC"
Output: "ABC"
Example 2:

Input: str1 = "ABABAB", str2 = "ABAB"
Output: "AB"
Example 3:

Input: str1 = "LEET", str2 = "CODE"
Output: ""


Constraints:

1 <= str1.length, str2.length <= 1000
str1 and str2 consist of English uppercase letters.
'''

'''
Solution 1:
gcd integer

if there is an divisor exist,
str1 + str2 == str2 + str1

for get gcd strings,
We focus on the substring gcdBase whose length equals the greatest common divisor of the lengths of str1 and str2 (take the above picture as an example, the lengths of str1 and str2 are 9 and 6, so we focus on the substring of length 3, which is gcdBase = ABC). We will show that if there exists divisible strings, then the gcdBase must be the GCD string.

Time Complexity: O(m+n)
- m is str1.count
- n is str2.count
Space Complexity: O(m+n)
'''
class Solution:
    def gcdOfStrings(self, str1: str, str2: str) -> str:
        if str1+str2 != str2+str1:
            return ""
        def gcd(m: int, n: int) -> int:
            if n == 0: return m
            return gcd(n, m%n)
        strLen = gcd(len(str1), len(str2))
        return str1[:strLen:]
