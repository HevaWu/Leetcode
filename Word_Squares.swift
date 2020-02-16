// Given a set of words (without duplicates), find all word squares you can build from them.

// A sequence of words forms a valid word square if the kth row and column read the exact same string, where 0 ≤ k < max(numRows, numColumns).

// For example, the word sequence ["ball","area","lead","lady"] forms a word square because each word reads the same both horizontally and vertically.

// b a l l
// a r e a
// l e a d
// l a d y
// Note:
// There are at least 1 and at most 1000 words.
// All words will have the exact same length.
// Word length is at least 1 and at most 5.
// Each word contains only lowercase English alphabet a-z.
// Example 1:

// Input:
// ["area","lead","wall","lady","ball"]

// Output:
// [
//   [ "wall",
//     "area",
//     "lead",
//     "lady"
//   ],
//   [ "ball",
//     "area",
//     "lead",
//     "lady"
//   ]
// ]

// Explanation:
// The output consists of two word squares. The order of output does not matter (just the order of words in each word square matters).
// Example 2:

// Input:
// ["abat","baba","atan","atal"]

// Output:
// [
//   [ "baba",
//     "abat",
//     "baba",
//     "atan"
//   ],
//   [ "baba",
//     "abat",
//     "baba",
//     "atal"
//   ]
// ]

// Explanation:
// The output consists of two word squares. The order of output does not matter (just the order of words in each word square matters).

// Solution 1: backtrace 
// for each word, try to find if there is a mathcing wordSqure
// 
// Time complexity: O(n^2)
// Space complexity: O(nm) m would be the result
class Solution {   
    var n = 0
    var squares = [[String]]()
    var words = [String]()
    
    func wordSquares(_ words: [String]) -> [[String]] {
        n = words[0].count
        self.words = words
        
        for word in words {
            var temp = [word]
            check(1, &temp)
        }
        return squares
    }
    
    private func check(_ step: Int, _ temp: inout [String]) {
        guard step < n else { 
            squares.append(temp) 
            return
        }
        
        // find next prefix
        var prefix = String()
        for str in temp {
            prefix.append(str[str.index(str.startIndex, offsetBy: step)])
        }
        
        // check remain words which has this prefix
        var list = words.filter {
            $0.hasPrefix(prefix)
        }
        
        for l in list {
            temp.append(l)
            check(step+1, &temp)
            temp.removeLast()
        }
    }
}

// Solution 2: optimize prefix part
// One of the ideas to optimize the getWordsWithPrefix() function would be to process the words beforehand and to build a data structure that could speed up the lookup procedure later.
// - We build upon the backtracking algorithm that we listed above, and tweak two parts.
// - In the first part, we add a new function buildPrefixHashTable(words) to build a hashtable out of the input words.
// - Then in the second part, in the function getWordsWithPrefix() we simply query the hashtable to retrieve all the words that possess the given prefix.
// 
// Time complexity: \mathcal{O}(N\cdot26^{L}), where NN is the number of input words and LL is the length of a single word. It is tricky to calculate the exact number of operations in the backtracking algorithm. We know that the trace of the backtrack would form a n-ary tree. Therefore, the upper bound of the operations would be the total number of nodes in a full-blossom n-ary tree. In our case, at any node of the trace, at maximum it could have 26 branches (i.e. 26 alphabet letters). Therefore, the maximum number of nodes in a 26-ary tree would be approximately 26^LIn the loop around the backtracking function, we enumerate the possibility of having each word as the starting word in the word square. As a result, in total the overall time complexity of the algorithm should be \mathcal{O}(N\cdot26^{L})As large as the time complexity might appear, in reality, the actual trace of the backtracking is much smaller than its upper bound, thanks to the constraint checking (symmetric of word square) which greatly prunes the trace of the backtracking.
// Space Complexity:O(N⋅L+N⋅ 2L)=O(N⋅L) where NN is the number of words and LL is the length of a single word. The first half of the space complexity (i.e. N\cdot{L}N⋅L) is the values in the hashtable, where we store LL times all words in the hashtable. The second half of the space complexity (i.e. N\cdot\frac{L}{2}N⋅ 2L) is the space took by the keys of the hashtable, which include all prefixes of all words. In total, we could say that the overall space of the algorithm is proportional to the total words times the length of a single word.

// Solution 3: prefix tree
// The Trie data structure provides a compact and yet still fast way to retrieve words with a given prefix.
// It takes \mathcal{O}(L)O(L) to retrieve a word, where LL is the length of the word, which is much faster than the brute-force enumeration.
// 
// We build upon the backtracking algorithm that we listed above, and tweak two parts.
// In the first part, we add a new function buildTrie(words) to build a Trie out of the input words.
// Then in the second part, in the function getWordsWithPrefix(prefix) we simply query the Trie to retrieve all the words that possess the given prefix.
// Here are some sample implementations. Note that, we tweak the Trie data structure a bit, in order to further optimize the time and space complexity.
// Instead of labeling the word at the leaf node of the Trie, we label the word at each node so that we don't need to perform a further traversal once we reach the last node in the prefix. This trick could help us with the time complexity.
// Instead of storing the actual words in the Trie, we keep only the index of the word, which could greatly save the space.
// 
// Time complexity: \mathcal{O}(N\cdot26^{L}\cdot{L})O(N⋅26 L⋅L), where NN is the number of input words and LL is the length of a single word.
// Basically, the time complexity is same with the Approach #1 (\mathcal{O}(N\cdot26^{L})O(N⋅26 L)), except that instead of the constant-time access for the function getWordsWithPrefix(prefix), we now need \mathcal{O}(L)O(L).
// Space Complexity: \mathcal{O}(N\cdot{L} + N\cdot\frac{L}{2}) = \mathcal{O}(N\cdot{L})O(N⋅L+N⋅ 2L)=O(N⋅L) where NN is the number of words and LL is the length of a single word.
// The first half of the space complexity (i.e. N\cdot{L}N⋅L) is the word indice that we store in the Trie, where we store LL times the index for each word.
// The second half of the space complexity (i.e. N\cdot\frac{L}{2}N⋅ 2L) is the space took by the prefixes of all words. In the worst case, we have no overlapping among the prefixes.
// Overall, this approach has the same space complexity as the previous approach. Yet, in running time, it would consume less memory thanks to all the optimization that we have done.
class Solution {
    func wordSquares(_ words: [String]) -> [[String]] {
        var words = words
        var n = words[0].count
        var trie = Trie(words)
        
        var squares = [[String]]()
        var temp = [String]()
        
        for word in words {
            temp = [word]
            check(trie, n, &temp, &squares)
        }
        return squares
    }
    
    private func check(_ trie: Trie, _ n: Int, _ temp: inout [String], _ squares: inout [[String]]) {
        guard temp.count < n else {
            squares.append(temp)
            return
        }
        
        let index = temp.count

        var prefix = String()
        for t in temp {
            prefix.append(t[t.index(t.startIndex, offsetBy: index)])
        }
        
        var list = trie.search(prefix)

        for l in list {
            temp.append(l)
            check(trie, n, &temp, &squares)
            temp.removeLast()
        }
    }
}

class TrieNode {
    var words = [String]()
    var children = [Character: TrieNode]()
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
            if node.children[w] == nil {
                node.children[w] = TrieNode()
            }
            node.children[w]!.words.append(word)
            node = node.children[w]!
        }
    }
    
    func search(_ prefix: String) -> [String] {
        var node = root
        for c in prefix {
            if !node.children.keys.contains(c) {
                return [String]()
            }
            node = node.children[c]!
        }
        return node.words
    }
}