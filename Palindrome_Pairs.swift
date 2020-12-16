/*
Given a list of unique words, return all the pairs of the distinct indices (i, j) in the given list, so that the concatenation of the two words words[i] + words[j] is a palindrome.

 

Example 1:

Input: words = ["abcd","dcba","lls","s","sssll"]
Output: [[0,1],[1,0],[3,2],[2,4]]
Explanation: The palindromes are ["dcbaabcd","abcddcba","slls","llssssll"]
Example 2:

Input: words = ["bat","tab","cat"]
Output: [[0,1],[1,0]]
Explanation: The palindromes are ["battab","tabbat"]
Example 3:

Input: words = ["a",""]
Output: [[0,1],[1,0]]
 

Constraints:

1 <= words.length <= 5000
0 <= words[i].length <= 300
words[i] consists of lower-case English letters.
*/

/*
Solution 1: Trie

TrieNode
- child: children node
- index: current word index in words
- list: index list, if current word 0...this node isPalindrome, add current word index into list

insert:
- add the word from word.count-1 to 0, and check isPalindrome(word, 0, i)

// i is word index in words
search(i, word, &res):
- check word from 0..word.count-1, 
- if find cur.index >= 0 && cur.index != i && word[j...n-1] isPalindrome, res.append([i, cur.index])
- if cur.list is not empty, res.append([i, cur.list[value]])

Time Complexity:
- insert: O(n* k^2)
- search: O(n* k^2)
with n the total number of words in the words array and k the average length of each word
*/
class Solution {
    func palindromePairs(_ words: [String]) -> [[Int]] {
        let t = Trie(words)
        var res = [[Int]]()
        for i in 0..<words.count {
            t.search(i, words[i], &res)
        }
        return res
    }
}

class Trie {
    class TrieNode {
        var child: [Character: TrieNode] = [:]
        var index = -1
        
        // store index of words array, if current word[0...this node] is palindrome
        var list: [Int] = []
    }

    var root: TrieNode
    init(_ words: [String]) {
        root = TrieNode()
        for (index, value) in words.enumerated() {
            insert(index, value)
        }
    }
    
    func insert(_ index: Int, _ word: String) {
        var cur = root
        var word = Array(word)
        for i in stride(from: word.count-1, through: 0, by: -1) {
            if cur.child[word[i]] == nil {
               cur.child[word[i]] = TrieNode() 
            }
            
            if isPalindrome(word, 0, i) {
                cur.list.append(index)
            }
            
            cur = cur.child[word[i]]!
        }
        
        cur.index = index
        cur.list.append(index)
    }
    
    func search(_ i: Int, _ word: String, _ res: inout [[Int]]) {
        var word = Array(word)
        var cur = root
        let n = word.count
        
        for j in 0..<n {
            if cur.index >= 0, cur.index != i, isPalindrome(word, j, n-1) {
                res.append([i, cur.index])
            }
            
            if cur.child[word[j]] == nil {
                return
            }
            
            cur = cur.child[word[j]]!
        }
        
        for j in cur.list {
            if i == j { continue }
            res.append([i, j])
        }
    }
    
    func isPalindrome(_ word: [Character], _ left: Int, _ right: Int) -> Bool {
        var left = left
        var right = right
        while left < right {
            if word[left] != word[right] {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
}

