'''
A string S of lowercase English letters is given. We want to partition this string into as many parts as possible so that each letter appears in at most one part, and return a list of integers representing the size of these parts.



Example 1:

Input: S = "ababcbacadefegdehijhklij"
Output: [9,7,8]
Explanation:
The partition is "ababcbaca", "defegde", "hijhklij".
This is a partition so that each letter appears in at most one part.
A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits S into less parts.


Note:

S will have length in range [1, 500].
S will consist of lowercase English letters ('a' to 'z') only.
'''

'''
Solution 2:
greedy

- use last to store lastIndex of character c
- Iterate s, updated end, if end == i, we found one partition, append it into result

Time Complexity: O(n)
Space Complexity: O(1) - 26 characters
'''
class Solution:
    def partitionLabels(self, s: str) -> List[int]:
        last = [0 for i in range(26)]
        n = len(s)
        for i in range(n):
            last[ord(s[i]) - ord('a')] = i

        start = 0
        end = 0
        partition = []
        for i in range(n):
            end = max(end, last[ord(s[i]) - ord('a')])
            if end == i:
                partition.append(end-start+1)
                start = end+1

        return partition