// Implement the StreamChecker class as follows:

// StreamChecker(words): Constructor, init the data structure with the given words.
// query(letter): returns true if and only if for some k >= 1, the last k characters queried (in order from oldest to newest, including this letter just queried) spell one of the words in the given list.
 

// Example:

// StreamChecker streamChecker = new StreamChecker(["cd","f","kl"]); // init the dictionary.
// streamChecker.query('a');          // return false
// streamChecker.query('b');          // return false
// streamChecker.query('c');          // return false
// streamChecker.query('d');          // return true, because 'cd' is in the wordlist
// streamChecker.query('e');          // return false
// streamChecker.query('f');          // return true, because 'f' is in the wordlist
// streamChecker.query('g');          // return false
// streamChecker.query('h');          // return false
// streamChecker.query('i');          // return false
// streamChecker.query('j');          // return false
// streamChecker.query('k');          // return false
// streamChecker.query('l');          // return true, because 'kl' is in the wordlist
 

// Note:

// 1 <= words.length <= 2000
// 1 <= words[i].length <= 2000
// Words will only consist of lowercase English letters.
// Queries will only consist of lowercase English letters.
// The number of queries is at most 40000.

// Solution 1: Trie
// 
// Time complexity:
// init() <- trie insert, O(mn) m is words[i] length, n is words length
// query() <- trie search, O(k) k is current input length
// Space complexity: O(mn) for build the trie
class StreamChecker {
    var input = [Character]()
    var trie = Trie()

    init(_ words: [String]) {
        for word in words {
            trie.insert(word)
        }
    }
    
    func query(_ letter: Character) -> Bool {
        input.insert(letter, at: 0)
        return trie.search(input)
    }
}

class TrieNode {
    var isFinish = false
    var children = [Character: TrieNode]()
}

class Trie {
    var root = TrieNode()
    
    func insert(_ word: String) {
        var node = root
        // save in the reverse order
        for i in word.indices.reversed() {
            if !node.children.keys.contains(word[i]) {
                node.children[word[i]] = TrieNode()
            }
            node = node.children[word[i]]!
        }
        node.isFinish = true
    }
    
    func search(_ arr: [Character]) -> Bool {
        var node = root
        for i in 0..<arr.count {
            // check if this node is an ending word, if it is, return true
            if node.isFinish { return true }
            
            // go to next char
            guard let next = node.children[arr[i]] else { return false }
            node = node.children[arr[i]]!
        }
        // check final node, whole arr might also equal to one word
        return node.isFinish
    }
}

/**
 * Your StreamChecker object will be instantiated and called as such:
 * let obj = StreamChecker(words)
 * let ret_1: Bool = obj.query(letter)
 */