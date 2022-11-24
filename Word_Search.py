'''
Given an m x n board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where "adjacent" cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.



Example 1:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true
Example 2:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true
Example 3:


Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false


Constraints:

m == board.length
n = board[i].length
1 <= m, n <= 200
1 <= word.length <= 103
board and word consists only of lowercase and uppercase English letters.
'''

'''
Solution 2:
optimize solution 1
change board directly to mark visited status

Time Complexity: O(mn * 4^k)
Space Complexity: O(mn)
'''
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        m = len(board)
        n = len(board[0])
        nw = len(word)
        directions = [0, 1, 0, -1, 0]

        def canFind(i, j, index) -> bool:
            nonlocal m, n, nw, board, word, directions
            if index == nw-1: return True
            temp = board[i][j]
            board[i][j] = "."
            for d in range(4):
                r = i + directions[d]
                c = j + directions[d+1]
                if r >= 0 and r < m and c >= 0 and c < n and board[r][c] == word[index+1]:
                    if canFind(r, c, index+1):
                        return True
            board[i][j] = temp
            return False

        for i in range(m):
            for j in range(n):
                if word[0] == board[i][j] and canFind(i, j, 0):
                    return True

        return False
