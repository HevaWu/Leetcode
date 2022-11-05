'''
Given a 2D board and a list of words from the dictionary, find all words in the board.

Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.



Example:

Input:
board = [
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]
words = ["oath","pea","eat","rain"]

Output: ["eat","oath"]


Note:

All inputs are consist of lowercase letters a-z.
The values of words are distinct.
'''

'''
Solution 1:
Trie to store words
then backtrack check the board to find all possible words

Time complexity: O(M(4⋅3 L−1)), where M is the number of cells in the board and L is the maximum length of words.
Space Complexity: O(N), where N is the total number of letters in the dictionary.
'''
class Solution:
    def findWords(self, board: List[List[str]], words: List[str]) -> List[str]:
        trie = Trie(words)
        return trie.find(board)

class TrieNode:
    def __init__(self):
        self.children = {}
        self.word = ""

class Trie:
    def __init__(self, words: List[str]):
        self.root = TrieNode()
        for word in words:
            self.insert(word)

    def insert(self, word: str):
        cur = self.root
        for c in word:
            if c not in cur.children:
                cur.children[c] = TrieNode()
            cur = cur.children[c]
        cur.word = word

    def find(self, board: List[List[str]]) -> List[str]:
        m = len(board)
        n = len(board[0])
        finded = []
        dlist = [0, 1, 0, -1, 0]
        # backtracking to find all words
        def check(i: int, j: int, node: TrieNode):
            nonlocal finded, board, m, n, dlist
            c = board[i][j]
            if (c not in node.children) or (c == "#"):
                return

            nextNode = node.children[c]
            # check finded words
            if nextNode.word != "":
                finded.append(nextNode.word)
                nextNode.word = ""

            board[i][j] = "#"
            for d in range(4):
                nr = i + dlist[d]
                nc = j + dlist[d+1]
                if nr >= 0 and nr < m and nc >= 0 and nc < n:
                    check(nr, nc, nextNode)
            board[i][j] = c

        for i in range(m):
            for j in range(n):
                check(i, j, self.root)

        return finded
