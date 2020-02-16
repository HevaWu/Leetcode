// Given a 2D board and a list of words from the dictionary, find all words in the board.

// Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

 

// Example:

// Input: 
// board = [
//   ['o','a','a','n'],
//   ['e','t','a','e'],
//   ['i','h','k','r'],
//   ['i','f','l','v']
// ]
// words = ["oath","pea","eat","rain"]

// Output: ["eat","oath"]
 

// Note:

// All inputs are consist of lowercase letters a-z.
// The values of words are distinct.

// Solution 1: BackTracking with Trie
// We build a Trie out of the words in the dictionary, which would be used for the matching process later.
// Starting from each cell, we start the backtracking exploration (i.e. backtracking(cell)), if there exists any word in the dictionary that starts with the letter in the cell.
// During the recursive function call backtracking(cell), we explore the neighbor cells (i.e. neighborCell) around the current cell for the next recursive call backtracking(neighborCell). At each call, we check if the sequence of letters that we traverse so far matches any word in the dictionary, with the help of the Trie data structure that we built at the beginning.
// 
// Gradually prune the nodes in Trie during the backtracking.
// 
// Time complexity: O(M(4⋅3 L−1)), where MM is the number of cells in the board and LL is the maximum length of words.
// Space Complexity: \mathcal{O}(N)O(N), where NN is the total number of letters in the dictionary.
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