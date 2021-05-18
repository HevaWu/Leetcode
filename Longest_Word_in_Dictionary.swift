/*
Given an array of strings words representing an English Dictionary, return the longest word in words that can be built one character at a time by other words in words.

If there is more than one possible answer, return the longest word with the smallest lexicographical order. If there is no answer, return the empty string.



Example 1:

Input: words = ["w","wo","wor","worl","world"]
Output: "world"
Explanation: The word "world" can be built one character at a time by "w", "wo", "wor", and "worl".
Example 2:

Input: words = ["a","banana","app","appl","ap","apply","apple"]
Output: "apple"
Explanation: Both "apply" and "apple" can be built from other words in the dictionary. However, "apple" is lexicographically smaller than "apply".


Constraints:

1 <= words.length <= 1000
1 <= words[i].length <= 30
words[i] consists of lowercase English letters.
*/

/*
Solution 1:
Trie + DFS

Put every word in a trie, then depth-first-search from the start of the trie, only searching nodes that ended a word. Every node found (except the root, which is a special case) then represents a word with all it's prefixes present. We take the best such word.

Time Complexity: O(∑w i), where w_i is the length of words[i]. This is the complexity to build the trie and to search it.
If we used a BFS instead of a DFS, and ordered the children in an array, we could drop the need to check whether the candidate word at each node is better than the answer, by forcing that the last node visited will be the best answer.
Space Complexity: O(∑w i), the space used by our trie
*/
class Solution {
    func longestWord(_ words: [String]) -> String {
        let t = Trie(words)
        return t.dfs()
    }
}

class Trie {
    var root: TrieNode
    var words: [String]
    init(_ words: [String]) {
        root = TrieNode()
        self.words = words

        var i = 0
        for word in words {
            insert(word, i)
            i += 1
        }
    }

    func insert(_ word: String, _ i: Int) {
        var node = root
        for c in word {
            if node.child[c] == nil {
                node.child[c] = TrieNode()
            }
            node = node.child[c]!
        }
        node.index = i
    }

    func dfs() -> String {
        var res = String()
        var stack = [TrieNode]()
        stack.append(root)
        while !stack.isEmpty {
            let cur = stack.removeLast()
            if cur === root || cur.index >= 0 {
                if cur !== root {
                    var word = words[cur.index]
                    if word.count > res.count
                    || (word.count == res.count && word < res) {
                        res = word
                    }
                }

                for next in cur.child.values {
                    stack.append(next)
                }
            }
        }
        return res
    }
}

class TrieNode {
    var child = [Character: TrieNode]()
    var index = -1
}