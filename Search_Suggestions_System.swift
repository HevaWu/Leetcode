/*
Given an array of strings products and a string searchWord. We want to design a system that suggests at most three product names from products after each character of searchWord is typed. Suggested products should have common prefix with the searchWord. If there are more than three products with a common prefix return the three lexicographically minimums products.

Return list of lists of the suggested products after each character of searchWord is typed.



Example 1:

Input: products = ["mobile","mouse","moneypot","monitor","mousepad"], searchWord = "mouse"
Output: [
["mobile","moneypot","monitor"],
["mobile","moneypot","monitor"],
["mouse","mousepad"],
["mouse","mousepad"],
["mouse","mousepad"]
]
Explanation: products sorted lexicographically = ["mobile","moneypot","monitor","mouse","mousepad"]
After typing m and mo all products match and we show user ["mobile","moneypot","monitor"]
After typing mou, mous and mouse the system suggests ["mouse","mousepad"]
Example 2:

Input: products = ["havana"], searchWord = "havana"
Output: [["havana"],["havana"],["havana"],["havana"],["havana"],["havana"]]
Example 3:

Input: products = ["bags","baggage","banner","box","cloths"], searchWord = "bags"
Output: [["baggage","bags","banner"],["baggage","bags","banner"],["baggage","bags"],["bags"]]
Example 4:

Input: products = ["havana"], searchWord = "tatiana"
Output: [[],[],[],[],[],[],[]]


Constraints:

1 <= products.length <= 1000
There are no repeated elements in products.
1 <= Σ products[i].length <= 2 * 10^4
All characters of products[i] are lower-case English letters.
1 <= searchWord.length <= 1000
All characters of searchWord are lower-case English letters.
*/

/*
Solution 1:
Trie

sort products first to make sure res also in lexicographical order

Time Complexity: O(nlogn + nm + k)
- n is products.count
- m is each product.count
- k is searchWord.count

Space Complexity: O(26n)
*/
class Solution {
    func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
        // init by products sorted,
        // this will make sure trie.words alwasy sort in lexicographical order
        return Trie(products.sorted()).search(searchWord)
    }
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
        for c in word {
            if node.child[c] == nil {
                node.child[c] = TrieNode()
            }
            node.child[c]!.wordList.append(word)
            node = node.child[c]!
        }
    }

    func search(_ word: String) -> [[String]] {
        var node = root
        let n = word.count

        var res: [[String]] = Array(repeating: [], count: n)
        for (i,c) in word.enumerated() {
            guard let next = node.child[c] else { return res }
            let list = next.wordList
            res[i] = list.count <= 3 ? list : Array(list[0..<3])

            node = next
        }

        return res
    }
}

class TrieNode {
    var child = [Character: TrieNode]()
    var wordList = [String]()
}