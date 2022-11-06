'''
You are given a string s and an integer k. You can choose one of the first k letters of s and append it at the end of the string..

Return the lexicographically smallest string you could have after applying the mentioned step any number of moves.



Example 1:

Input: s = "cba", k = 1
Output: "acb"
Explanation:
In the first move, we move the 1st character 'c' to the end, obtaining the string "bac".
In the second move, we move the 1st character 'b' to the end, obtaining the final result "acb".
Example 2:

Input: s = "baaca", k = 3
Output: "aaabc"
Explanation:
In the first move, we move the 1st character 'b' to the end, obtaining the string "aacab".
In the second move, we move the 3rd character 'c' to the end, obtaining the final result "aaabc".


Constraints:

1 <= k <= s.length <= 1000
s consist of lowercase English letters.
'''

'''
Solution 2:
optimize solution 1
use smallestIndex to help quick find smallest begin char

Time Complexity: O(n * n)
Space Complexity: O(n)
'''
class Solution:
    def orderlyQueue(self, s: str, k: int) -> str:
        if k == 1:
            smallestIndex = 0
            smallest = s
            for i in range(len(s)):
                if s[i] < s[smallestIndex]:
                    smallestIndex = i
                    smallest = s[i::] + s[:i:]
                elif s[i] == s[smallestIndex]:
                    temp = s[i::] + s[:i:]
                    if temp < smallest:
                        smallestIndex = i
                        smallest = temp
            return smallest
        else:
            return ''.join(sorted(s))
