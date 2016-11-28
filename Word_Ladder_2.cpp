/*126. Word Ladder II  QuestionEditorial Solution  My Submissions
Total Accepted: 49838
Total Submissions: 362598
Difficulty: Hard
Given two words (beginWord and endWord), and a dictionary's word list, find all shortest transformation sequence(s) from beginWord to endWord, such that:

Only one letter can be changed at a time
Each intermediate word must exist in the word list
For example,

Given:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log"]
Return
  [
    ["hit","hot","dot","dog","cog"],
    ["hit","hot","lot","log","cog"]
  ]
Note:
All words have the same length.
All words contain only lowercase alphabetic characters.
Subscribe to see which companies asked this question*/



/*Treat each word as a node of a tree. There are two trees. One tree's root node is "beginWord", and the other tree's root node is "endWord".

The root node can yield all his children node, and they are the second layer of the tree. The second layer can yield all their children, then we get the third layer of the tree, ... , and so on.

When one tree yield a new child, we search it in the last layer of the other tree. If we find an identical node in that tree, then we get some ladders connect two roots("beginWord" -> ... -> "endWord").

Another thing should be considered is: two(or more) different nodes may yield an identical child. That means the child may have two(or more) parents. For example, "hit" and "hot" can both yield "hat", means "hat" has two parents.

So, the data struct of tree-node is:

class Node {
public: 
    string word;
    vectror<Node*> parents;
    Node(string w) : word(w) {}
}
Note: we don't need a children field for Node class, because we won't use it.

Two nodes are considered equal when their word field are equal. So we introduce an compare function:

bool nodecmp(Node* pa, Node* pb)
{
    return pa->word < pb->word;
}
Then we use nodecmp as the compare function to build a node set.

typedef bool (*NodeCmper) (Node*, Node*);
typedef set<Node*, NodeCmper> NodeSet;
NodeSet layer(nodecmp);
Then we can store/search pointers of nodes in node set layer. For example:

Node node1("hit"), node2("hot"), node3("hat");    
layer.insert(&node1);
layer.insert(&node2);
layer.insert(&node3);
auto itr = layer.find(new Node("hot"));
cout << (*itr)->word; // output: hot
Using these data structures, we can solve this problem with bi-direction BFS algorithm. Below is the AC code, and it is very very fast.*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
    class Node;
    
    typedef vector<string> Ladder;
    typedef unordered_set<string> StringSet;
    typedef bool (*NodeCmper) (Node*, Node*);
    typedef set<Node*, NodeCmper> NodeSet;
    
    class Node{
    public:
        string word;
        vector<Node*> parents;
        Node(string w): word(w) {}
        
        void addparent(Node* parent){
            parents.push_back(parent);
        }
        
        void yieldChildren(NodeSet& nextlayer, StringSet& wordlist, NodeSet& targetlayer,
                            vector<Ladder>& ladders, bool forward){
        //if the child is found in $targetlayer, which means we found ladders that connect
        //  BEGIN-WORD and END-WORD, then we get all paths through this node to its ROOT node
        //  and all paths through the target child node to its ROOT node, and combine the two
        //  group of paths to a group of ladders, and append these ladders to $ladders
        //else if the $ladders is empty,
        //  if the child is found in $nextlayer, then get that child, and add this node to its parents 
        //  else, add the child to nextlayer, and add this node to its parents
        //else, do nothing
            string nextword = word;
            for(int i = 0, n = nextword.length(); i < n; i++){
                char oldchar = nextword[i];
                for(nextword[i] = 'a'; nextword[i] <= 'z'; nextword[i]++){
                    if(wordlist.count(nextword)){ //found a valid child-word, yield this child
                    	//unordered_set---count---count elements with a specific key
                        Node *child = new Node(nextword);
                        yield(child, nextlayer, targetlayer, ladders, forward);
                    }
                }
                nextword[i] = oldchar;
            }
        }
        
        //yield one child
        void yield(Node* child, NodeSet& nextlayer, NodeSet& targetlayer, 
                    vector<Ladder>& ladders, bool forward){
            auto it = targetlayer.find(child);
            if(it != targetlayer.end()){
                for(Ladder p1: this->getpaths()){
                    for(Ladder p2: (*it)->getpaths()){
                        if(forward){
                            ladders.push_back(p1);
                            ladders.back().insert(ladders.back().end(), p2.rbegin(), p2.rend());
                        } else {
                            ladders.push_back(p2);
                            ladders.back().insert(ladders.back().end(), p1.rbegin(), p1.rend());
                        }
                    }
                }
            } else if(ladders.empty()){
                auto it = nextlayer.find(child);
                if(it != nextlayer.end()){
                    (*it)->addparent(this);
                } else {
                    child->addparent(this);
                    nextlayer.insert(child);
                }
            }
        }
        
        vector<Ladder> getpaths(){
            vector<Ladder> ladders;
            if(parents.empty()){
                ladders.push_back(Ladder(1,word));
            } else {
                for(Node *p: parents){
                    for(Ladder lad : p->getpaths()){
                        ladders.push_back(lad);
                        ladders.back().push_back(word);
                    }
                }
            }
            return ladders;
        }
    };
    
    bool nodecmp(Node* na, Node* nb){
        return na->word < nb->word;
    }

class Solution {
public:
    vector<vector<string>> findLadders(string beginWord, string endWord, unordered_set<string> &wordList) {
        vector<Ladder> ladders;
        Node headroot(beginWord), tailroot(endWord);
        NodeSet frontlayer(nodecmp), backlayer(nodecmp);
        NodeSet *p_layerA = &frontlayer, *p_layerB = &backlayer;
        bool forward = true;
        
        if(beginWord == endWord){
            ladders.push_back(Ladder(1,beginWord));
            return ladders;
        }
        
        frontlayer.insert(&headroot);
        backlayer.insert(&tailroot);
        wordList.insert(endWord);
        while(!p_layerA->empty() && !p_layerB->empty() && ladders.empty()){
            NodeSet nextlayer(nodecmp);
            if(p_layerA->size() > p_layerB->size()){
                swap(p_layerA, p_layerB);
                forward = !forward;
            }
            
            for(Node* node : *p_layerA){
                wordList.erase(node->word);
            }
            
            for(Node *node : *p_layerA){
                node->yieldChildren(nextlayer, wordList, *p_layerB, ladders, forward);
            }
            
            swap(*p_layerA, nextlayer);
        }
        
        return ladders;
    }
};






/*The solution contains two steps 1 Use BFS to construct a graph. 2. Use DFS to construct the paths from end to start.Both solutions got AC within 1s.

The first step BFS is quite important. I summarized three tricks

Using a MAP to store the min ladder of each word, or use a SET to store the words visited in current ladder, when the current ladder was completed, delete the visited words from unvisited. That's why I have two similar solutions.
Use Character iteration to find all possible paths. Do not compare one word to all the other words and check if they only differ by one character.
One word is allowed to be inserted into the queue only ONCE.*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    private Map<String, List<String> > mymap;
    private List<List<String> > ret;
    
    public List<List<String>> findLadders(String beginWord, String endWord, Set<String> wordList) {
        ret = new ArrayList<List<String>>();
        if(wordList.size() == 0){
            return ret;
        }
        
        int min = Integer.MAX_VALUE;
        
        Queue<String> q = new ArrayDeque<String>();
        q.add(beginWord);
        
        mymap = new HashMap<String, List<String>>();
        
        Map<String, Integer> ladder = new HashMap<String, Integer>();
        for(String w:wordList){
            ladder.put(w, Integer.MAX_VALUE);
        }
        ladder.put(beginWord, 0);
        
        wordList.add(endWord);
        while(!q.isEmpty()){//BFS:Dijisktra search
            String word = q.poll();
            int step = ladder.get(word) + 1;//step indicates how many steps are needed to travel to one word
            if(step>min) break;
            
            for(int i = 0; i < word.length(); i++){
                StringBuilder sb = new StringBuilder(word);
                for(char ch = 'a'; ch <= 'z'; ch++){
                    sb.setCharAt(i, ch);
                    String newWord = sb.toString();
                    if(ladder.containsKey(newWord)){
                        if(step>ladder.get(newWord)){
                            continue;
                        } else if(step<ladder.get(newWord)) {
                            q.add(newWord);
                            ladder.put(newWord, step);
                        } else; //If one word already appeared in one ladder
                        //do not insert the same word inside the queue twice, otherwise it gets TLE
                        
                        if(mymap.containsKey(newWord)){
                            mymap.get(newWord).add(word);
                        } else {
                            List<String> newList = new LinkedList<String>();
                            newList.add(word);
                            mymap.put(newWord, newList);
                            //mymap.put(newWord, new LinkedList<String>(Arrays.asList(new String[]{word})));
                        }
                        
                        if(newWord.equals(endWord)){
                            min = step;
                        }
                    }// end if wordList contains newWord
                }//end if iteration from 'a' to 'z'
            }//end if iteration from the first to the last
        }
        
        LinkedList<String> res = new LinkedList<String>();
        backTrace(endWord, beginWord, res);
        
        return ret;
    }
    
    private void backTrace(String word, String start, List<String> list){
        if(word.equals(start)){
            list.add(0,start);
            ret.add(new ArrayList<String>(list));
            list.remove(0);
            return;
        }
        list.add(0, word);
        if(mymap.get(word) != null){
            for(String s:mymap.get(word)){
                backTrace(s, start, list);
            }
        }
        list.remove(0);
    }
}