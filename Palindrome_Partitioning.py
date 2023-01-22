'''
Given a string s, partition s such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of s.

A palindrome string is a string that reads the same backward as forward.



Example 1:

Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]
Example 2:

Input: s = "a"
Output: [["a"]]


Constraints:

1 <= s.length <= 16
s contains only lowercase English letters.
'''

'''
Solution 2: DP
use cache to store if i,j is palindrome

dp[n] is [[String]]() type object
dp[i+1]:
- if left,i is palindrome, for loop dp[left], append s[left...i] to dp[i+1]

Time Complexity:
O(n* 2^n)

Space Complexity:
O(n^2)
'''
class Solution:
    def partition(self, s: str) -> List[List[str]]:
        n = len(s)
        dp = [[] for _ in range(n+1)]
        # cache[i][j] = true if ispalindrome
        cache = [[False for _ in range(n)] for _ in range(n)]
        for i in range(n):
            for l in range(i+1):
                if s[l] == s[i] and (i-l<=1 or cache[l+1][i-1] == True):
                    cache[l][i] = True
                    sub = s[l:i+1:]
                    if len(dp[l]) == 0:
                        dp[i+1].append([sub])
                        continue
                    for pre in dp[l]:
                        temp = pre.copy() # copy to avoid reference miss
                        temp.append(sub)
                        dp[i+1].append(temp)

        return dp[n]
