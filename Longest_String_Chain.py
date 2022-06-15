'''
Given a list of words, each word consists of English lowercase letters.

Let's say word1 is a predecessor of word2 if and only if we can add exactly one letter anywhere in word1 to make it equal to word2.  For example, "abc" is a predecessor of "abac".

A word chain is a sequence of words [word_1, word_2, ..., word_k] with k >= 1, where word_1 is a predecessor of word_2, word_2 is a predecessor of word_3, and so on.

Return the longest possible length of a word chain with words chosen from the given list of words.



Example 1:

Input: ["a","b","ba","bca","bda","bdca"]
Output: 4
Explanation: one of the longest word chain is "a","ba","bda","bdca".


Note:

1 <= words.length <= 1000
1 <= words[i].length <= 16
words[i] only consists of English lowercase letters.

hint
For each word in order of length, for each word2 which is word with one character removed, length[word2] = max(length[word2], length[word] + 1).
'''

'''
Solution 1: DP
Sort the words by word's length. (also can apply bucket sort)
For each word, loop on all possible previous word with 1 letter missing.
If we have seen this previous word, update the longest chain for the current word.
Finally return the longest word chain.

Time complexity: O(nlogn + n*word.len)
Space complexity: O(n)
'''
class Solution:
    def longestStrChain(self, words: List[str]) -> int:
        def compare(w1, w2) -> bool:
            return len(w1) - len(w2)
        words.sort(key=cmp_to_key(compare))

        # dp[word] is longest str chain length with end of word
        dp = {}
        longest = 0
        for word in words:
            temp = 0
            for i in range(len(word)):
                substr = word[0:i:] + word[i+1::]
                temp = max(temp, dp.get(substr, 0) + 1)
            dp[word] = temp
            longest = max(longest, temp)
        return longest
