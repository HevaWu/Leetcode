/*
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
*/

/*
Solution 2:
optimize solution 1
change board directly to mark visited status

Time Complexity: O(mn * 4^k)
Space Complexity: O(mn)
*/
class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        var word = Array(word)
        let m = board.count
        let n = board[0].count
        let nw = word.count
        var board = board

        for i in 0..<m {
            for j in 0..<n {
                if word[0] == board[i][j],
                canFind(i, j, m, n, &board, 0, nw, word) {
                    return true
                }
            }
        }
        return false
    }

    let dir = [0, 1, 0, -1, 0]
    // back track
    func canFind(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
    _ board: inout [[Character]],
    _ index: Int, _ nw: Int, _ word: [Character]) -> Bool {
        if index == nw-1 { return true }

        // board[i][j] is letter, means unvisited
        // board[i][j] is '.' means visited
        let c = board[i][j]

        // mark visited
        board[i][j] = "."

        // check 4 directions
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n,
            board[r][c] == word[index+1] {
                if canFind(r, c, m, n, &board, index+1, nw, word) {
                    return true
                }
            }
        }

        // backtrack put back
        board[i][j] = c

        return false
    }
}

/*
Solution 1
backTrack

1. find board[i][j] = word[0], then start from (i,j), use canFind check if we can find a word
2. canFind, use visited and dir to check if there exist next element

Time Complexity: O(mn * 4^k)
Space Complexity: O(mn)
*/
class Solution {
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        let m = board.count
        let n = board[0].count

        var word = Array(word)
        for i in 0..<m {
            for j in 0..<n {
                if board[i][j] == word[0] {
                    var visited = Array(repeating: Array(repeating: false, count: n),
                                        count: m)
                    visited[i][j] = true
                    if canFind(board, i, j, m, n, 1, word, &visited) {
                        return true
                    }
                }
            }
        }
        return false
    }

    var dir = [0, -1, 0, 1, 0]
    func canFind(_ board: [[Character]],
                 _ r: Int, _ c: Int,
                 _ m: Int, _ n: Int,
                 _ index: Int, _ word: [Character],
                 _ visited: inout [[Bool]]) -> Bool {

        if index == word.count { return true }

        for d in 0..<4 {
            let nr = r + dir[d]
            let nc = c + dir[d+1]

            if nr >= 0, nr < m, nc >= 0, nc < n,
            !visited[nr][nc], board[nr][nc] == word[index] {
                visited[nr][nc] = true
                // print(nr, nc)
                if canFind(board, nr, nc, m, n, index+1, word, &visited) {
                    return true
                }
                visited[nr][nc] = false
            }
        }
        return false
    }
}
