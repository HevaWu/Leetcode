/*
212. Word Search II  QuestionEditorial Solution  My Submissions
Total Accepted: 24287
Total Submissions: 118222
Difficulty: Hard
Given a 2D board and a list of words from the dictionary, find all words in the board.

Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

For example,
Given words = ["oath","pea","eat","rain"] and board =

[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]
Return ["eat","oath"].
Note:
You may assume that all inputs are consist of lowercase letters a-z.

click to show hint.

You would need to optimize your backtracking to pass the larger test. Could you stop backtracking earlier?

If the current candidate does not exist in all words' prefix, you could stop backtracking immediately. What kind of data structure could answer such query efficiently? Does a hash table work? Why or why not? How about a Trie? If you would like to learn how to implement a basic trie, please work on this problem: Implement Trie (Prefix Tree) first.

Hide Company Tags Microsoft Google Airbnb
Hide Tags Backtracking Trie
Hide Similar Problems (M) Word Search
*/




/*use trie
dfs(board, i, j, TrieNode p, List<String> ret) --- 
    i,j is the board position which we search start
    ret is the list we need to return at the end
TrieNode --- next[], word(the end char of wordsTrie, store the words itself)
buildTrie(String[] string) --- 
    build the word trie according to given string array of words
findWords --- build the word trie \
        DFS searching the board
*/

//C++
///////////////////////////////////////////////////////////////////////////////////////////////class Solution {
    class TrieNode{
    public:
        vector<TrieNode*> next;
        string word;
        TrieNode(){
            this->next = vector<TrieNode*>(26, nullptr);
            this->word = "";
        }
    };
    
    public: 
    TrieNode* buildTrie(vector<string> &words){
        TrieNode *root = new TrieNode();
        for(string w:words){
            TrieNode *p = root;
            for(int i = 0; i < w.size(); i++){
                int c = w[i]-'a';
                if(p->next[c]==nullptr){
                    p->next[c] = new TrieNode();
                }
                p = p->next[c];
            }
            p->word = w;
        }
        return root;
    }
    
    public:
    void dfs(vector<vector<char> > &board, int i, int j, TrieNode *p, vector<string> &ret){
        char c = board[i][j];
        if(c=='#' || p->next[c-'a']==nullptr){
            return;
        }
        
        p = p->next[c-'a'];
        if(p->word != ""){
            ret.push_back(p->word);
            p->word = "";
        }
        
        board[i][j] = '#';
        if(i > 0)
            dfs(board, i-1, j, p, ret);
        if(j > 0)
            dfs(board, i, j-1, p, ret);
        if(i < board.size()-1)
            dfs(board, i+1, j, p, ret);
        if(j < board[0].size()-1)
            dfs(board, i, j+1, p, ret);
        
        board[i][j] = c;
    }
    
public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {
        vector<string> ret;
        TrieNode *root = buildTrie(words);
        
        for(int i = 0; i < board.size(); i++){
            for(int j = 0; j < board[0].size(); j++){
                dfs(board, i, j, root, ret);
            }
        }
        return ret;
    }
};








//java
////////////////////////////////////////////////////////////////////////////////////////////////
public class Solution {
    class TrieNode{
        TrieNode[] next = new TrieNode[26];
        String word;
    }
    
    public TrieNode buildTrie(String[] words){
        TrieNode root = new TrieNode();
        for(String w:words){
            TrieNode p = root;
            for(char c:w.toCharArray()){
                int i = c-'a';
                if(p.next[i] == null){
                    p.next[i] = new TrieNode();
                }
                p = p.next[i];
            }
            p.word = w;
        }
        
        return root;
    }
    
    public void dfs(char[][] board, int i, int j, TrieNode p, List<String> ret){
        char c = board[i][j];
        if(c=='#' || p.next[c-'a']==null) // this cell has already been searched
            return;
            
        p = p.next[c-'a'];
        if(p.word!=null){
            //once find a word, add it into list, and change it to null to avoid count it again
            ret.add(p.word);
            p.word = null;
        }
        
        board[i][j] = '#'; //mark this cell has already been searched
        if(i > 0) 
            dfs(board, i-1, j, p, ret);
        if(j > 0)
            dfs(board, i, j-1, p, ret);
        if(i < board.length - 1)
            dfs(board, i+1, j, p, ret);
        if(j < board[0].length - 1)
            dfs(board, i, j+1, p, ret);
        
        board[i][j] = c; //recover this node
    }
    
    public List<String> findWords(char[][] board, String[] words) {
        List<String> ret = new ArrayList<>();
        if(board.length==0 || board[0].length==0) return ret;
        TrieNode root = buildTrie(words);
        
        for(int i = 0; i < board.length; i++){
            for(int j = 0; j < board[0].length; j++){
                dfs(board, i, j, root, ret);
            }
        }
        return ret;
    }
}