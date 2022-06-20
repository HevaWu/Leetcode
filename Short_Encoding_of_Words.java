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
Solution 2:
make words set
remove suffix substring to be sure remove duplicate suffix string there

Time Complexity: O(n * 7)
- n is length of words
Space Complexity: O(n)
*/
class Solution {
    public int minimumLengthEncoding(String[] words) {
        Set<String> remain = new HashSet(Arrays.asList(words));
        for (String word: words) {
            for (int k = 1; k < word.length(); ++k)
                remain.remove(word.substring(k));
        }

        int len = 0;
        for (String word: remain) {
            len += word.length() + 1;
        }
        return len;
    }
}


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
    public int minimumLengthEncoding(String[] words) {
        Trie trie = new Trie(words);
        return trie.getEncodingLength();
    }
}

class Trie {
    TrieNode root;
    public Trie(String[] words) {
        this.root = new TrieNode();
        for(String word: words) {
            insert(word);
        }
    }

    public void insert(String word) {
        TrieNode node = root;
        for(int i = word.length()-1; i >= 0; i--) {
            int index = word.charAt(i) - 'a';
            if (node.children[index] == null) {
                node.children[index] = new TrieNode();
            }
            node = node.children[index];
        }
        node.wordLen = word.length();
    }

    public int getEncodingLength() {
        return check(root);
    }

    public int check(TrieNode node) {
        int len = 0;
        for (int i = 0; i < 26; i++) {
            if (node.children[i] != null) {
                len += check(node.children[i]);
            }
        }

        if (len == 0) {
            return node.wordLen + 1;
        } else {
            return len;
        }
    }
}

class TrieNode {
    TrieNode[] children = new TrieNode[26];
    int wordLen = 0;
}