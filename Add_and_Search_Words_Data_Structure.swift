/*
Design a data structure that supports adding new words and finding if a string matches any previously added string.

Implement the WordDictionary class:

WordDictionary() Initializes the object.
void addWord(word) Adds word to the data structure, it can be matched later.
bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.


Example:

Input
["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
[[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
Output
[null,null,null,null,false,true,true,true]

Explanation
WordDictionary wordDictionary = new WordDictionary();
wordDictionary.addWord("bad");
wordDictionary.addWord("dad");
wordDictionary.addWord("mad");
wordDictionary.search("pad"); // return False
wordDictionary.search("bad"); // return True
wordDictionary.search(".ad"); // return True
wordDictionary.search("b.."); // return True


Constraints:

1 <= word.length <= 500
word in addWord consists lower-case English letters.
word in search consist of  '.' or lower-case English letters.
At most 50000 calls will be made to addWord and search.
*/

/*
Solution2:
Similar to Solution 1,
another recursive style

Time Complexity:
- add: O(n)
  - n = word.count
- search: O(nW)
  - H is width or the Trie Tree
*/
class WordDictionary {
    class TrieNode {
        var child = [Character: TrieNode]()
        var isWord = false
    }

    let root = TrieNode()

    init() {

    }

    func addWord(_ word: String) {
        var cur = root
        for c in word {
            if cur.child[c] == nil {
                cur.child[c] = TrieNode()
            }
            cur = cur.child[c]!
        }
        cur.isWord = true
    }

    func search(_ word: String) -> Bool {
        return check(Array(word), 0, word.count, root)
    }

    // search if word[index...] is the subtree under node
    func check(_ word: [Character], _ index: Int, _ n: Int, _ node: TrieNode) -> Bool {
        if index == n {
            return node.isWord
        }

        let c = word[index]
        if c == Character(".") {
            for nextChar in node.child.keys {
                if let next = node.child[nextChar], check(word, index+1, n, next) {
                    return true
                }
            }
        } else {
            if let next = node.child[c], check(word, index+1, n, next) {
                return true
            }
        }
        return false
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */

/*
Solution 1:
Trie

It takes time on searching part.
when there is a . character, we recursively check if ther is matching word in Trie
*/
class WordDictionary {
    class TrieNode {
        var isWord = false
        var child = [Character: TrieNode]()
    }

    var root: TrieNode

    /** Initialize your data structure here. */
    init() {
        root = TrieNode()
    }

    /** Adds a word into the data structure. */
    func addWord(_ word: String) {
        var cur = root
        for c in word {
            if cur.child[c] == nil {
                cur.child[c] = TrieNode()
            }
            cur = cur.child[c]!
        }
        cur.isWord = true
    }

    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    func search(_ word: String) -> Bool {
        return _search(Array(word), node: root)
    }

    func _search(_ sub: [Character], node: TrieNode) -> Bool {
        if sub.isEmpty, node.isWord { return true }
        var cur = node
        for i in 0..<sub.count {
            let c = sub[i]
            if c == "." {
                for _node in cur.child.keys {
                    if _search(Array(sub[(i+1)...]), node: cur.child[_node]!) {
                         return true
                    }
                }
                return false
            } else {
                if cur.child[c] == nil {
                     return false
                }
                cur = cur.child[c]!
            }
        }
        return cur.isWord
    }
}

/**
 * Your WordDictionary object will be instantiated and called as such:
 * let obj = WordDictionary()
 * obj.addWord(word)
 * let ret_2: Bool = obj.search(word)
 */

 /*
 Solution 2:
 use dictionary to map it

 // key: word.count
 // value: existing stored words
 var dict: [Int:[String]] = [:]
 */
