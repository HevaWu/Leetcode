/*
A valid encoding of an array of words is any reference string s and array of indices indices such that:

words.length == indices.length
The reference string s ends with the '#' character.
For each index indices[i], the substring of s starting from indices[i] and up to (but not including) the next '#' character is equal to words[i].
Given an array of words, return the length of the shortest reference string s possible of any valid encoding of words.

 

Example 1:

Input: words = ["time", "me", "bell"]
Output: 10
Explanation: A valid encoding would be s = "time#bell#" and indices = [0, 2, 5].
words[0] = "time", the substring of s starting from indices[0] = 0 to the next '#' is underlined in "time#bell#"
words[1] = "me", the substring of s starting from indices[1] = 2 to the next '#' is underlined in "time#bell#"
words[2] = "bell", the substring of s starting from indices[2] = 5 to the next '#' is underlined in "time#bell#"
Example 2:

Input: words = ["t"]
Output: 2
Explanation: A valid encoding would be s = "t#" and indices = [0].

 

Constraints:

1 <= words.length <= 2000
1 <= words[i].length <= 7
words[i] consists of only lowercase letters.
*/

/*
Solution 1:
trie

If 2 words can merge into same encoding part,
they must have same suffix

insert word into Trie from endIndex to startIndex
for get length part, check each childNode would be enough

Time Complexity: O(nm) n is word.count, m is maximum word[i].count
Space Complexity: O(nm)
*/
class Solution {
    func minimumLengthEncoding(_ words: [String]) -> Int {
        if words.count == 1 { return words[0].count+1 }
        return Trie(words).getEncodingLength()
    }
}

class TrieNode {
    var child = [Character: TrieNode]()
    var wordLen: Int = 0
}

class Trie {
    var root = TrieNode()
    init(_ words: [String]) {
        for word in words {
            insert(word)
        }
    }
    
    // insert word from endIndex to startIndex
    func insert(_ word: String) {
        var word = Array(word)
        let n = word.count
        
        var node = root
        for i in stride(from: n-1, through: 0, by: -1) {
            if node.child[word[i]] == nil {
                node.child[word[i]] = TrieNode()
            }
            node = node.child[word[i]]!
        }
        node.wordLen = n
    }
    
    func getEncodingLength() -> Int {
        var len = 0
        _countLength(root, &len)
        return len
    }
    
    func _countLength(_ node: TrieNode, _ len: inout Int) {
        if node.child.keys.isEmpty {
            len += (node.wordLen + 1)
            return
        }
        
        for next in node.child.keys {
            _countLength(node.child[next]!, &len)
        }
    }
}