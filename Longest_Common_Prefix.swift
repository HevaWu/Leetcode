/*
Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string "".

 

Example 1:

Input: strs = ["flower","flow","flight"]
Output: "fl"
Example 2:

Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
 

Constraints:

0 <= strs.length <= 200
0 <= strs[i].length <= 200
strs[i] consists of only lower-case English letters.
*/

/*
Solution 2:
find prefix

pick str[0] as init prefix
then found if later string has this prefix 

Time Complexity: O(s)
Space Complexity: O(1)
*/
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard !strs.isEmpty else { return "" }
        var prefix = strs[0]
        
        if prefix == "" { return "" }
        
        for i in 1..<strs.count {
            while !strs[i].hasPrefix(prefix) {
                prefix = String(prefix.dropLast())
            }
        }
        
        return prefix
    }
}

/*
Solution 1
prefix trie

Time Complexity: O(s) s is number of all char in array
Space Complexity: O(s) use additional s space 
*/
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard !strs.isEmpty else { return "" }
        let trie = Trie(strs)
        return trie.getCommonPrefix()
    }
}

class Trie {
    var root: TrieNode = TrieNode("#")
    init(_ strs: [String]) {
        for str in strs {
            insert(str)
        }
    }
    
    func insert(_ str: String) {
        var cur = root
        if str.isEmpty {
            cur.child[Character("*")] = TrieNode(Character("*"))
            return
        }
        
        for c in str {
            if !cur.child.keys.contains(c) {
                cur.child[c] = TrieNode(c)
            }
            
            cur = cur.child[c]!
        }
        cur.isWord = true
    }
    
    func getCommonPrefix() -> String {
        var cur = root
        var res = String()
        
        while cur.child.keys.count == 1 {
            let nextKey = cur.child.keys.first!
            if nextKey == "*" { break }
            
            cur = cur.child[nextKey]!
            res.append(nextKey)
            
            // stop if we've finded a whole word
            if cur.isWord { break }
        }
        
        return res
    }
}

class TrieNode {
    var val: Character
    var isWord: Bool = false
    var child = [Character: TrieNode]()
    init(_ val: Character) {
        self.val = val
    }
}