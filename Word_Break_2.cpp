/*140. Word Break II  QuestionEditorial Solution  My Submissions
Total Accepted: 68499 Total Submissions: 321317 Difficulty: Hard
Given a string s and a dictionary of words dict, add spaces in s to construct a sentence where each word is a valid dictionary word.

Return all such possible sentences.

For example, given
s = "catsanddog",
dict = ["cat", "cats", "and", "sand", "dog"].

A solution is ["cats and dog", "cat sand dog"].

Hide Company Tags Dropbox Google Uber Snapchat Twitter
Hide Tags Dynamic Programming Backtracking
*/



/* O(len(wordDict) ^ len(s / minWordLenInDict)), because there're len(wordDict) possibilities for each cut
use a hashmap to store the previous results, to avoid duplicates
for each word in wordDict, find its own list, and add it to ret
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
    private:
    unordered_map<string, vector<string>> mymap;
    
public:
    vector<string> wordBreak(string s, unordered_set<string>& wordDict) {
        if(mymap.count(s)) return mymap[s];
        
        vector<string> ret;
        if(wordDict.count(s)){
            ret.push_back(s);
        }
        
        for(int i = 1; i < s.size(); ++i){
        	//backtracking
            string word = s.substr(i);
            if(wordDict.count(word)){
                string rem = s.substr(0, i);
                vector<string> pre = combine(word, wordBreak(rem, wordDict));
                ret.insert(ret.end(), pre.begin(), pre.end());
            }
        }
        
        mymap[s] = ret;
        return ret;
    }
    
    vector<string> combine(string word, vector<string> pre){
        for(int i = 0; i < pre.size(); ++i){
            pre[i] += " " + word;
        }
        return pre;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    HashMap<String, List<String>> mymap = new HashMap<>(); 
    //store previous results, remember init it
    
    public List<String> wordBreak(String s, Set<String> wordDict) {
        if(mymap.containsKey(s)) 
            return mymap.get(s);
        
        List<String> ret = new LinkedList<>();
        if(s.length()==0){
            ret.add("");
            return ret;
        }
        
        for(String w:wordDict){
            if(s.startsWith(w)){ // s is a string start with w
                List<String> sublist = wordBreak(s.substring(w.length()), wordDict);
                for(String sub:sublist){
                    ret.add(w + (sub.isEmpty()?"":" ") + sub);
                }
            }
        }
        
        mymap.put(s, ret);
        return ret;
    }
}
