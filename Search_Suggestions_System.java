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
    public List<List<String>> suggestedProducts(String[] products, String searchWord) {
        Arrays.sort(products);
        Trie trie = new Trie(products);
        return trie.search(searchWord);
    }
}

class Trie {
    TrieNode root;
    public Trie(String[] words) {
        root = new TrieNode();
        for(String word: words) {
            insert(word);
        }
    }

    public void insert(String word) {
        TrieNode node = root;
        for (char c: word.toCharArray()) {
            int index = c - 'a';
            if (node.children[index] == null) {
                node.children[index] = new TrieNode();
            }
            node.children[index].wordList.add(word);
            node = node.children[index];
        }
    }

    public List<List<String>> search(String pre) {
        TrieNode node = root;
        List<List<String>> res = new ArrayList<>();
        for(int i = 0; i < pre.length(); i++) {
            int index = pre.charAt(i) - 'a';
            if (node != null && node.children[index] != null) {
                TrieNode next = node.children[index];
                List<String> list = next.wordList;
                res.add(list.size() <= 3 ? list : list.subList(0, 3));
                node = next;
            } else {
                res.add(new ArrayList<>());
                // update node to null, because next child is not exist
                node = null;
            }
        }
        return res;
    }
}

class TrieNode {
    TrieNode[] children = new TrieNode[26];
    List<String> wordList = new ArrayList<>();
    public TrieNode() {}
}