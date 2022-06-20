'''
A valid encoding of an array of words is any reference string s and array of indices indices such that:

words.length == indices.length
The reference string s ends with the '#' character.
For each index indices[i], the substring of s starting from indices[i] and up to (but not including) the next '#' character is equal to words[i].
Given an array of words, return the length of the shortest reference string s possible of any valid encoding of words.



Example 1:

Input: words = ["time", "me", "bell"]
Output: 10
Explanation: A valid encoding would be s = "time#bell#" and indices = [0, 2, 5].
words[0] = "time", the substring of s starting from indices[0] = 0 to the next '#' is underlined in "time#bell#"
words[1] = "me", the substring of s starting from indices[1] = 2 to the next '#' is underlined in "time#bell#"
words[2] = "bell", the substring of s starting from indices[2] = 5 to the next '#' is underlined in "time#bell#"
Example 2:

Input: words = ["t"]
Output: 2
Explanation: A valid encoding would be s = "t#" and indices = [0].



Constraints:

1 <= words.length <= 2000
1 <= words[i].length <= 7
words[i] consists of only lowercase letters.
'''

'''
Solution 2:
make words set
remove suffix substring to be sure remove duplicate suffix string there

Time Complexity: O(n * 7)
- n is length of words
Space Complexity: O(n)
'''
class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        # new remain variable to help avoid directly remove words
        # need to be sure removing will not change words's length
        remain = set(words)
        for word in words:
            for i in range(1, len(word)):
                remain.discard(word[i::])

        minLen = 0
        for word in remain:
            minLen += len(word) + 1

        return minLen


'''
Solution 1:
trie

If 2 words can merge into same encoding part,
they must have same suffix

insert word into Trie from endIndex to startIndex
for get length part, check each childNode would be enough

Time Complexity: O(nm) n is word.count, m is maximum word[i].count
Space Complexity: O(nm)
'''
class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        trie = Trie(words)
        return trie.getEncodingLength()

class Trie:
    def __init__(self, words: List[str]):
        self.root = TrieNode()
        for word in words:
            self.insert(word)

    def insert(self, word: str):
        node = self.root
        for i in range(len(word)-1, -1, -1):
            index = ord(word[i]) - ord('a')
            if not node.children[index]:
                node.children[index] = TrieNode()
            node = node.children[index]
        node.wordLen = len(word)

    def getEncodingLength(self) -> int:
        total = 0
        def check(node: TrieNode):
            nonlocal total

            hasChildren = False
            for i in range(26):
                if node.children[i]:
                    check(node.children[i])
                    hasChildren = True

            if hasChildren == False:
                total += node.wordLen + 1

        check(self.root)
        return total

class TrieNode:
    def __init__(self):
        self.children = [None for i in range(26)]
        self.wordLen = 0