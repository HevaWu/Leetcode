'''
Given a string array words, return the maximum value of length(word[i]) * length(word[j]) where the two words do not share common letters. If no such two words exist, return 0.



Example 1:

Input: words = ["abcw","baz","foo","bar","xtfn","abcdef"]
Output: 16
Explanation: The two words can be "abcw", "xtfn".
Example 2:

Input: words = ["a","ab","abc","d","cd","bcd","abcd"]
Output: 4
Explanation: The two words can be "ab", "cd".
Example 3:

Input: words = ["a","aa","aaa","aaaa"]
Output: 0
Explanation: No such pair of words.


Constraints:

2 <= words.length <= 1000
1 <= words[i].length <= 1000
words[i] consists only of lowercase English letters.
'''

'''
Solution 1:
- sort words by descending size
- record which char appears by using occur[i] |= 1 << Int(c.asciiValue! - ascii_a)
- iterate words, check if we can extend res

Time Complexity: O(nlogn + nm + n*n)
Space Complexity: O(n+26)
'''
class Solution:
    def maxProduct(self, words: List[str]) -> int:
        # decreasing words length
        def compare(w1, w2) -> bool:
            return len(w2) - len(w1)
        words.sort(key=cmp_to_key(compare))

        n = len(words)
        occur = [0 for i in range(n)]
        for i in range(n):
            for c in words[i]:
                occur[i] |= 1<<(ord(c)-ord('a'))

        # print(occur, words)
        product = 0
        for i in range(n-1):
            if len(words[i] * len(words[i])) <= product:
                break

            for j in range(i+1, n):
                if occur[i] & occur[j] == 0:
                    product = max(product, len(words[i]) * len(words[j]))
                    break

        return product
