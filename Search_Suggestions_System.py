'''
Given an array of strings products and a string searchWord. We want to design a system that suggests at most three product names from products after each character of searchWord is typed. Suggested products should have common prefix with the searchWord. If there are more than three products with a common prefix return the three lexicographically minimums products.

Return list of lists of the suggested products after each character of searchWord is typed.



Example 1:

Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
Output: [
["mobile","moneypot","monitor"],
["mobile","moneypot","monitor"],
["mouse","mousepad"],
["mouse","mousepad"],
["mouse","mousepad"]
]
Explanation: products sorted lexicographically = ["mobile","moneypot","monitor","mouse","mousepad"]
After typing m and mo all products match and we show user ["mobile","moneypot","monitor"]
After typing mou, mous and mouse the system suggests ["mouse","mousepad"]
Example 2:

Input: products = ["havana"], searchWord = "havana"
Output: [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]]
Example 3:

Input: products = ["bags","baggage","banner","box","cloths"], searchWord = "bags"
Output: [["baggage","bags","banner"],["baggage","bags","banner"],["baggage","bags"],["bags"]]
Example 4:

Input: products = ["havana"], searchWord = "tatiana"
Output: [[],[],[],[],[],[],[]]


Constraints:

1 <= products.length <= 1000
There are no repeated elements in products.
1 <= Σ products[i].length <= 2 * 10^4
All characters of products[i] are lower-case English letters.
1 <= searchWord.length <= 1000
All characters of searchWord are lower-case English letters.
'''

'''
Solution 1:
Trie

sort products first to make sure res also in lexicographical order

Time Complexity: O(nlogn + nm + k)
- n is products.count
- m is each product.count
- k is searchWord.count

Space Complexity: O(26n)
'''
class Solution:
    def suggestedProducts(self, products: List[str], searchWord: str) -> List[List[str]]:
        products.sort()
        trie = Trie(products)
        return trie.search(searchWord)

class Trie:
    def __init__(self, words: List[str]):
        self.root = TrieNode()
        for word in words:
            self.insert(word)

    def insert(self, word: str):
        node = self.root
        for c in word:
            index = ord(c) - ord('a')
            if not node.children[index]:
                node.children[index] = TrieNode()
            node.children[index].wordList.append(word)
            node = node.children[index]

    def search(self, pre: str) -> List[List[str]]:
        node = self.root
        res = []
        for c in pre:
            index = ord(c) - ord('a')
            if node and node.children[index]:
                wordList = node.children[index].wordList
                res.append(wordList if len(wordList) <= 3 else wordList[:3:])
                node = node.children[index]
            else:
                res.append([])
                node = None
        return res

class TrieNode:
    def __init__(self):
        # TrieNode[26]
        self.children = [None for i in range(26)]
        # String list
        self.wordList = []
