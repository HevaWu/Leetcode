/*
Implement a trie with insert, search, and startsWith methods.

Example:

Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");   
trie.search("app");     // returns true
Note:

You may assume that all inputs are consist of lowercase letters a-z.
All inputs are guaranteed to be non-empty strings.
*/

/*
Time Complexity:
insert: O(n)
search: O(n)
prefix: O(n)
*/
class Trie {
    class TrieNode {
        var isWord: Bool = false
        var child: [Character: TrieNode] = [:]
    }
    
    var root: TrieNode

    /** Initialize your data structure here. */
    init() {
        root = TrieNode()
    }
    
    /** Inserts a word into the trie. */
    func insert(_ word: String) {
        var cur = root
        for c in word {
			// Note: 
			// not use `cur = cur.child[c, default: TrieNode()]`
			// need to assign new TrieNode to child at here
            if cur.child[c] == nil {
                cur.child[c] = TrieNode()
            }
            cur = cur.child[c]!
        }
        cur.isWord = true
    }
    
    /** Returns if the word is in the trie. */
    func search(_ word: String) -> Bool {
        var cur = root
        for c in word {
            if cur.child[c] != nil {
                cur = cur.child[c]!
            } else {
                return false
            }
        }
        return cur.isWord
    }
    
    /** Returns if there is any word in the trie that starts with the given prefix. */
    func startsWith(_ prefix: String) -> Bool {
        var cur = root
        for c in prefix {
            if cur.child[c] != nil {
                cur = cur.child[c]!
            } else {
                return false
            }
        }
        return true
    }
}

/**
 * Your Trie object will be instantiated and called as such:
 * let obj = Trie()
 * obj.insert(word)
 * let ret_2: Bool = obj.search(word)
 * let ret_3: Bool = obj.startsWith(prefix)
 */
