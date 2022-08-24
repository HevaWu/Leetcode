/*
You are given an m x n matrix board, representing the current state of a crossword puzzle. The crossword contains lowercase English letters (from solved words), ' ' to represent any empty cells, and '#' to represent any blocked cells.

A word can be placed horizontally (left to right or right to left) or vertically (top to bottom or bottom to top) in the board if:

It does not occupy a cell containing the character '#'.
The cell each letter is placed in must either be ' ' (empty) or match the letter already on the board.
There must not be any empty cells ' ' or other lowercase letters directly left or right of the word if the word was placed horizontally.
There must not be any empty cells ' ' or other lowercase letters directly above or below the word if the word was placed vertically.
Given a string word, return true if word can be placed in board, or false otherwise.



Example 1:


Input: board = [["#", " ", "#"], [" ", " ", "#"], ["#", "c", " "]], word = "abc"
Output: true
Explanation: The word "abc" can be placed as shown above (top to bottom).
Example 2:


Input: board = [[" ", "#", "a"], [" ", "#", "c"], [" ", "#", "a"]], word = "ac"
Output: false
Explanation: It is impossible to place the word because there will always be a space/letter above or below it.
Example 3:


Input: board = [["#", " ", "#"], [" ", " ", "#"], ["#", " ", "c"]], word = "ca"
Output: true
Explanation: The word "ca" can be placed as shown above (right to left).


Constraints:

m == board.length
n == board[i].length
1 <= m * n <= 2 * 105
board[i][j] will be ' ', '#', or a lowercase English letter.
1 <= word.length <= max(m, n)
word will contain only lowercase English letters.
*/

/*
Solution 1:
DFS

for each possible to place the initial word character
check if we could put word in that place properly

Time Complexity: O(mn * k)
Space Complexity: O(k)
*/
class Solution {
    func placeWordInCrossword(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count
        let n = board[0].count

        var word = Array(word)
        for i in 0..<m {
            for j in 0..<n {
                if (board[i][j] == " " || board[i][j] == word[0]) {
                    // try to find the put direction
                    // vertical
                    if i == 0 || board[i-1][j] == "#" {
                        // check if we could
                        // put word from top to bottom in col j
                        if canPut(i, j, m, n, board, word, [1, 0]) {
                            return true
                        }
                    }
                    if i == m-1 || board[i+1][j] == "#" {
                        // check if we could
                        // put word from bottom to top in col j
                        if canPut(i, j, m, n, board, word, [-1, 0]) {
                            return true
                        }
                    }

                    // horizontal
                    if j == 0 || board[i][j-1] == "#" {
                        // check if we could
                        // put word from left to right in row i
                        if canPut(i, j, m, n, board, word, [0, 1]) {
                            return true
                        }
                    }
                    if j == n-1 || board[i][j+1] == "#" {
                        // check if we could
                        // put word from right to left in row i
                        if canPut(i, j, m, n, board, word, [0, -1]) {
                            return true
                        }
                    }

                }
            }
        }

        return false
    }

    // check if we could put word
    // with put word's first character at i,j
    func canPut(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
                _ board: [[Character]],
                _ word: [Character], _ dir: [Int]) -> Bool {
        var i = i
        var j = j
        // print(i, j)

        // use to go through word
        var index = 0
        let k = word.count
        while i >= 0, j >= 0, i < m, j < n, index < k {
            if board[i][j] == " " || board[i][j] == word[index] {
                i += dir[0]
                j += dir[1]
                index += 1
            } else {
                return false
            }
        }

        // print(i, j, dir, index)
        if index == k {
            if dir == [1, 0]
            && (i == m
                || (i >= 0 && j >= 0
                    && i < m && j < n
                    && board[i][j] == "#")) {
                // from top to bottom
                return true

            } else if dir == [-1, 0]
            && (i == -1
                || (i >= 0 && j >= 0
                    && i < m && j < n
                    && board[i][j] == "#")) {
                // from bottom to top
                return true

            } else if dir == [0, 1]
            && (j == n
                || (i >= 0 && j >= 0
                    && i < m && j < n
                    && board[i][j] == "#")) {
                // from left to right
                return true

            } else if dir == [0, -1]
            && (j == -1
                || (i >= 0 && j >= 0
                    && i < m && j < n
                    && board[i][j] == "#")) {
                // from bottom to top
                return true
            }

        }
        return false
    }
}