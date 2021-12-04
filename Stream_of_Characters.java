/*
Design an algorithm that accepts a stream of characters and checks if a suffix of these characters is a string of a given array of strings words.

For example, if words = ["abc", "xyz"] and the stream added the four characters (one by one) 'a', 'x', 'y', and 'z', your algorithm should detect that the suffix "xyz" of the characters "axyz" matches "xyz" from words.

Implement the StreamChecker class:

StreamChecker(String[] words) Initializes the object with the strings array words.
boolean query(char letter) Accepts a new character from the stream and returns true if any non-empty suffix from the stream forms a word that is in words.


Example 1:

Input
["StreamChecker", "query", "query", "query", "query", "query", "query", "query", "query", "query", "query", "query", "query"]
[[["cd", "f", "kl"]], ["a"], ["b"], ["c"], ["d"], ["e"], ["f"], ["g"], ["h"], ["i"], ["j"], ["k"], ["l"]]
Output
[null, false, false, false, true, false, true, false, false, false, false, false, true]

Explanation
StreamChecker streamChecker = new StreamChecker(["cd", "f", "kl"]);
streamChecker.query("a"); // return False
streamChecker.query("b"); // return False
streamChecker.query("c"); // return False
streamChecker.query("d"); // return True, because 'cd' is in the wordlist
streamChecker.query("e"); // return False
streamChecker.query("f"); // return True, because 'f' is in the wordlist
streamChecker.query("g"); // return False
streamChecker.query("h"); // return False
streamChecker.query("i"); // return False
streamChecker.query("j"); // return False
streamChecker.query("k"); // return False
streamChecker.query("l"); // return True, because 'kl' is in the wordlist


Constraints:

1 <= words.length <= 2000
1 <= words[i].length <= 2000
words[i] consists of lowercase English letters.
letter is a lowercase English letter.
At most 4 * 104 calls will be made to query.
 */

 /*
Solution 1: Trie

Time complexity:
init() <- trie insert, O(mn) m is words[i] length, n is words length
query() <- trie search, O(k) k is current input length
Space complexity: O(mn) for build the trie
*/
class StreamChecker {
    Trie trie;
    StringBuilder input;

    public StreamChecker(String[] words) {
        this.trie = new Trie(words);
        this.input = new StringBuilder();
    }

    public boolean query(char letter) {
        this.input.insert(0, letter);
        return trie.search(this.input);
    }
}

class Trie {
    class TrieNode {
        public Map<Character, TrieNode> child;
        public boolean isWord;

        public TrieNode() {
            this.child = new HashMap<>();
            this.isWord = false;
        }
    }

    public TrieNode root;

    public Trie(String[] words) {
        this.root = new TrieNode();
        for (int i = 0; i < words.length; i++) {
            insert(words[i]);
        }
    }

    public void insert(String word) {
        TrieNode cur = this.root;

        StringBuilder sb = new StringBuilder(word);
        sb.reverse();
        for(int i = 0; i < sb.length(); i++) {
            if(cur.child.get(sb.charAt(i)) == null) {
                cur.child.put(sb.charAt(i), new TrieNode());
            }
            cur = cur.child.get(sb.charAt(i));
        }
        cur.isWord = true;
    }

    public boolean search(StringBuilder input) {
        TrieNode cur = this.root;

        for(int i = 0; i < input.length(); i++) {
            if(cur.child.get(input.charAt(i)) == null) {
                return false;
            }
            cur = cur.child.get(input.charAt(i));
            if (cur.isWord) {
                return true;
            }
        }
        return false;
    }
}

/**
 * Your StreamChecker object will be instantiated and called as such:
 * StreamChecker obj = new StreamChecker(words);
 * boolean param_1 = obj.query(letter);
 */