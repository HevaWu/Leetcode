/*
208. Implement Trie (Prefix Tree)   QuestionEditorial Solution  My Submissions
Total Accepted: 51246 Total Submissions: 200397 Difficulty: Medium Contributors:
Admin Implement a trie with insert, search, and startsWith methods.

Note:
You may assume that all inputs are consist of lowercase letters a-z.

Hide Company Tags Google Uber Facebook Twitter Microsoft Bloomberg
Hide Tags Design Trie
Hide Similar Problems (M) Add and Search Word - Data structure design
*/

/*
use TrieNode to store the node in the trie
    next[26] ---  array store 26 lower case letters
    boolean isword --- judge the end of the word

insert(String word) --- for each char in the word,
    build a TrieNode and use next[] to combine them, the end char.isword = true
search(String word) --- build a function
    "TrieNode searchWord(String word)" to help finish this, if the return
node.isword = true, means we can find this word in Trie startsWith(String word)
--- through "TrieNode searchWord(word)" function to search this prefix, if the
return node is not null, means there is a word starts with given prefix
*/
class TrieNode {
 public:
  // Initialize your data structure here.
  // TrieNode *nextNode[26];
  vector<TrieNode *> nextNode;
  bool isword;

  TrieNode()
      : nextNode(vector<TrieNode *>(
            26, NULL)),  // use this to initialze the nextNode
        isword(false) {}
};

class Trie {
 public:
  Trie() { root = new TrieNode(); }

  // Inserts a word into the trie.
  void insert(string word) {
    TrieNode *r = root;
    for (int i = 0; i < word.size(); i++) {
      if (r->nextNode[word[i] - 'a'] == NULL)
        r->nextNode[word[i] - 'a'] = new TrieNode;  // new TrieNode
      r = r->nextNode[word[i] - 'a'];
    }
    r->isword = true;
  }

  // Returns if the word is in the trie.
  bool search(string word) {
    TrieNode *s = findWord(word);
    return s != NULL && s->isword == true;
  }

  // Returns if there is any word in the trie
  // that starts with the given prefix.
  bool startsWith(string prefix) {
    TrieNode *s = findWord(prefix);
    return s != NULL;
  }

 private:
  TrieNode *root;

  TrieNode *findWord(string word) {  // return TrieNode item
    TrieNode *r = root;
    for (int i = 0; i < word.size() && r != NULL; i++) {
      r = r->nextNode[word[i] - 'a'];
    }
    return r;
  }
};

// Your Trie object will be instantiated and called as such:
// Trie trie;
// trie.insert("somestring");
// trie.search("key");
