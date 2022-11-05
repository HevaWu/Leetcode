/*
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
*/

/*
Solution 3:
another coding style for Solution 1

Time complexity: O(M(4⋅3 L−1)), where M is the number of cells in the board and L is the maximum length of words.
Space Complexity: O(N), where N is the total number of letters in the dictionary.
*/
class Solution {
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let trie = Trie(words)
        return trie.find(from: board)
    }
}

class TrieNode {
    var children = [Character: TrieNode]()
    var word = ""
}

class Trie {
    let root = TrieNode()
    init(_ words: [String]) {
        for word in words {
            insert(word)
        }
    }

    func insert(_ word: String) {
        var cur = root
        for c in word {
            if cur.children[c] == nil {
                cur.children[c] = TrieNode()
            }
            cur = cur.children[c]!
        }
        cur.word = word
    }

    // return finded words from board
    func find(from board: [[Character]]) -> [String] {
        let m = board.count
        let n = board[0].count

        // if board[i][j] = # means this cell is visited
        var board = board
        var finded = [String]()
        let dir = [0, 1, 0, -1, 0]
        for i in 0..<m {
            for j in 0..<n {
                check(i, j, m, n, root, dir, &board, &finded)
            }
        }
        return finded
    }

    func check(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
    _ node: TrieNode, _ dir: [Int],
    _ board: inout [[Character]], _ finded: inout [String]) {
        let c = board[i][j]

        // check if this is valid check
        guard let nextNode = node.children[c],
        c != Character("#") else {
            return
        }

        if nextNode.word != "" {
            finded.append(nextNode.word)
            nextNode.word = ""
        }

        board[i][j] = Character("#")

        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n {
                check(r, c, m, n, nextNode, dir, &board, &finded)
            }
        }

        board[i][j] = c
    }
}

/*
Solution 1: BackTracking with Trie
We build a Trie out of the words in the dictionary, which would be used for the matching process later.
Starting from each cell, we start the backtracking exploration (i.e. backtracking(cell)), if there exists any word in the dictionary that starts with the letter in the cell.
During the recursive function call backtracking(cell), we explore the neighbor cells (i.e. neighborCell) around the current cell for the next recursive call backtracking(neighborCell). At each call, we check if the sequence of letters that we traverse so far matches any word in the dictionary, with the help of the Trie data structure that we built at the beginning.

Gradually prune the nodes in Trie during the backtracking.

Time complexity: O(M(4⋅3 L−1)), where MM is the number of cells in the board and LL is the maximum length of words.
Space Complexity: \mathcal{O}(N)O(N), where NN is the total number of letters in the dictionary.
*/
class Solution {
    var board = [[Character]]()
    var m = 0
    var n = 0
    var finded = [String]()

    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        guard !board.isEmpty, !words.isEmpty else { return [String]() }

        var trie = Trie(words)

        m = board.count
        n = board[0].count

        self.board = board

        for i in 0..<m {
            for j in 0..<n {
                dfs(i, j, trie.root)
            }
        }
        return finded
    }

    private func dfs(_ i: Int, _ j: Int, _ node: TrieNode) {
        let c = board[i][j]
        if c == "#" || !node.children.keys.contains(c) {
            // this cell already being searched
            return
        }

        var node = node
        node = node.children[c]!
        if node.word != "" {
            // find a word && reset
            finded.append(node.word)
            node.word = ""
        }

        board[i][j] = "#"

        if i>0 { dfs(i-1, j, node) }
        if i<m-1 { dfs(i+1, j, node) }
        if j>0 { dfs(i, j-1, node) }
        if j<n-1 { dfs(i, j+1, node) }

        // recover
        board[i][j] = c
    }
}

class TrieNode {
    var children = [Character: TrieNode]()
    var word = String()
}

class Trie {
    var root = TrieNode()
    init(_ words: [String]) {
        for word in words {
            insert(word)
        }
    }

    func insert(_ word: String) {
        var node = root
        for w in word {
            if !node.children.keys.contains(w) {
                node.children[w] = TrieNode()
            }
            node = node.children[w]!
        }
        node.word = word
    }
}

/*
Solution 2:
backtracking
TLE

Time Complexity: O(wordLen * 2^(mn))
Space Complexity: O(mn)
*/
class Solution {
    func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
        let m = board.count
        let n = board[0].count
        return words.filter { canFind($0, in: board, m, n) }
    }

    func canFind(_ word: String, in board: [[Character]],
    _ m: Int, _ n: Int) -> Bool {
        var word = Array(word)
        let wordLen = word.count
        var visited = Array(
            repeating: Array(repeating: false, count: n),
            count: m
        )
        for i in 0..<m {
            for j in 0..<n {
                if board[i][j] == word[0] {
                    visited[i][j] = true
                    if canFindWithPoint(word, in: board, m, n, i, j, 0, wordLen, &visited) {
                        return true
                    }
                    visited[i][j] = false
                }
            }
        }
        return false
    }

    // backtrack to check if can find whole word with
    // i, j, word index
    let dir = [0, 1, 0, -1, 0]
    func canFindWithPoint(_ word: [Character],
    in board: [[Character]], _ m: Int, _ n: Int,
    _ i: Int, _ j: Int, _ index: Int, _ wordLen: Int,
    _ visited: inout [[Bool]]) -> Bool {
        if index+1 == wordLen { return true }

        // check if it is possible to find next word character
        // in 4 direction
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n,
            board[r][c] == word[index+1],
            !visited[r][c] {
                visited[r][c] = true
                if canFindWithPoint(word, in: board, m, n, r, c, index+1, wordLen, &visited) {
                    return true
                }
                visited[r][c] = false
            }
        }

        return false
    }
}
