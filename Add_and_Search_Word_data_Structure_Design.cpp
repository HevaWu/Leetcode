/*
Design a data structure that supports the following two operations:

void addWord(word)
bool search(word)
search(word) can search a literal word or a regular expression string containing only letters a-z or .. A . means it can represent any one letter.

For example:

addWord("bad")
addWord("dad")
addWord("mad")
search("pad") -> false
search("bad") -> true
search(".ad") -> true
search("b..") -> true
Note:
You may assume that all words are consist of lowercase letters a-z.

click to show hint.

You should be familiar with how a Trie works. If not, please work on this problem: Implement Trie (Prefix Tree) first.
*/


//C++
///////////////////////////////////////////////////////////////////////////////////////////////
class WordDictionary {
public:
    struct TrieNode{   //create a TrieNode struct
        vector<TrieNode*> nextNode;
        bool isword;
        TrieNode():
            nextNode(vector<TrieNode*>(26,NULL)),
            isword(false){}
    };  //do not forget ";"
    
    TrieNode *root;
    WordDictionary():root(new TrieNode){}

    // Adds a word into the data structure.
    void addWord(string word) {
        TrieNode *r = root;
        for(int i = 0; i < word.size(); i++){
            if(!r->nextNode[word[i]-'a'])
                r->nextNode[word[i]-'a'] = new TrieNode;
            r = r->nextNode[word[i]-'a'];
        }
        r->isword = true;
    }

    // Returns if the word is in the data structure. A word could
    // contain the dot character '.' to represent any one letter.
    bool search(string word) {
        return searchWord(word.c_str(), root);
    }
    
    bool searchWord(const char *ch, TrieNode *r){ //const char *ch contains all value in word
        if(!r) return false;
        if(*ch == '\0') return r->isword;   //check if it is end of the word
        if(*ch == '.'){
            for(int i = 0; i < 26; i++){  //find each of the character
                if(searchWord(ch+1, r->nextNode[i])) return true;  //this should check each of them
            }
            return false;
        }
        else
            return searchWord(ch+1, r->nextNode[*ch-'a']);
        
    }
};

// Your WordDictionary object will be instantiated and called as such:
// WordDictionary wordDictionary;
// wordDictionary.addWord("word");
// wordDictionary.search("pattern");




//Java
///////////////////////////////////////////////////////////////////////////////////////////////
public class WordDictionary {
    public class TrieNode{
        public TrieNode[] next = new TrieNode[26];
        public String Tword = "";
    }
    
    public TrieNode root = new TrieNode();

    // Adds a word into the data structure.
    public void addWord(String word) {
        TrieNode r = root;
        for(char w:word.toCharArray()){ //remember "toCharArray"
            int c = w - 'a';
            if(r.next[c] == null){
                r.next[c] = new TrieNode();
            }
            r = r.next[c];
        }
        r.Tword = word;
    }

    // Returns if the word is in the data structure. A word could
    // contain the dot character '.' to represent any one letter.
    public boolean search(String word) {
        return searchWord(word.toCharArray(), 0, root);
    }
    
    public boolean searchWord(char[] ch, int k, TrieNode r){
        if(r == null){
            return false;
        }
        
        if(k == ch.length){
            return !r.Tword.equals("");
        }
        
        if(ch[k] == '.'){
            for(int i = 0; i < 26; i++){
                if(searchWord(ch, k+1, r.next[i])){
                    return true;
                }
            }
            return false;
        }else{
            return searchWord(ch, k+1, r.next[ch[k]-'a']);
        }
    }
}

// Your WordDictionary object will be instantiated and called as such:
// WordDictionary wordDictionary = new WordDictionary();
// wordDictionary.addWord("word");
// wordDictionary.search("pattern");
