/*
In English, we have a concept called root, which can be followed by some other word to form another longer word - let's call this word successor. For example, when the root "an" is followed by the successor word "other", we can form a new word "another".

Given a dictionary consisting of many roots and a sentence consisting of words separated by spaces, replace all the successors in the sentence with the root forming it. If a successor can be replaced by more than one root, replace it with the root that has the shortest length.

Return the sentence after the replacement.

 

Example 1:

Input: dictionary = ["cat","bat","rat"], sentence = "the cattle was rattled by the battery"
Output: "the cat was rat by the bat"
Example 2:

Input: dictionary = ["a","b","c"], sentence = "aadsfasf absbs bbab cadsfafs"
Output: "a a b c"
Example 3:

Input: dictionary = ["a", "aa", "aaa", "aaaa"], sentence = "a aa a aaaa aaa aaa aaa aaaaaa bbb baba ababa"
Output: "a a a a a a a a bbb baba a"
Example 4:

Input: dictionary = ["catt","cat","bat","rat"], sentence = "the cattle was rattled by the battery"
Output: "the cat was rat by the bat"
Example 5:

Input: dictionary = ["ac","ab"], sentence = "it is abnormal that this solution is accepted"
Output: "it is ab that this solution is ac"
 

Constraints:

1 <= dictionary.length <= 1000
1 <= dictionary[i].length <= 100
dictionary[i] consists of only lower-case letters.
1 <= sentence.length <= 10^6
sentence consists of only lower-case letters and spaces.
The number of words in sentence is in the range [1, 1000]
The length of each word in sentence is in the range [1, 1000]
Each two consecutive words in sentence will be separated by exactly one space.
sentence does not have leading or trailing spaces.
*/

/*
Solution 1: Trie
*/
class Solution {
    class TrieNode {
        var isWord = false
        var child = [Character: TrieNode]()
    }
    
    var root = TrieNode()
    
    func insert(_ str: String) {
        var cur = root
        for c in str {
            if cur.child[c] == nil {
                cur.child[c] = TrieNode()
            }
            cur = cur.child[c]!
        }
        cur.isWord = true
    }
    
    func findShortestSuccessor(_ str: String) -> String? {
        var cur = root
        var word = String()
        for c in str {
            if cur.child[c] == nil {
                 return nil
            }
            
            cur = cur.child[c]!
            
            // append word and check if we find a successort after updating cur
            word.append(c)
            if cur.isWord {
                return word
            }
        }
        
        return nil
    }
    
    func replaceWords(_ dictionary: [String], _ sentence: String) -> String {
        dictionary.forEach { insert($0) }
        var sub = sentence.split(separator: " ").map { String($0) }
        for i in 0..<sub.count {            
            // search if there is any replacing words for sub[i]
            if let word = findShortestSuccessor(sub[i]) {
                sub[i] = word
            }
        }
        return sub.joined(separator: " ")
    }
}

/*
Solution 2:
Trie
Improve by adding `word` in the TrieNode
*/
class Solution {
    class TrieNode {
        var word = String()
        var isWord = false
        var child = [Character: TrieNode]()
    }
    
    var root = TrieNode()
    
    func insert(_ str: String) {
        var cur = root
        for c in str {
            if cur.child[c] == nil {
                cur.child[c] = TrieNode()
            }
            cur = cur.child[c]!
        }
        cur.isWord = true
        cur.word = str
    }
    
    func findShortestSuccessor(_ str: String) -> String? {
        var cur = root
        for c in str {
            if cur.child[c] == nil {
                 return nil
            }
            
            cur = cur.child[c]!
            
            // append word and check if we find a successort after updating cur
            if cur.isWord {
                return cur.word
            }
        }
        
        return nil
    }
    
    func replaceWords(_ dictionary: [String], _ sentence: String) -> String {
        dictionary.forEach { insert($0) }
        var sub = sentence.split(separator: " ").map { String($0) }
        for i in 0..<sub.count {            
            // search if there is any replacing words for sub[i]
            if let word = findShortestSuccessor(sub[i]) {
                sub[i] = word
            }
        }
        return sub.joined(separator: " ")
    }
}