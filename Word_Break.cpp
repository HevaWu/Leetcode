/*139. Word Break  QuestionEditorial Solution  My Submissions
Total Accepted: 107015 Total Submissions: 395296 Difficulty: Medium
Given a string s and a dictionary of words dict, determine if s can be segmented into a space-separated sequence of one or more dictionary words.

For example, given
s = "leetcode",
dict = ["leet", "code"].

Return true because "leetcode" can be segmented as "leet code".

Hide Company Tags Google Uber Facebook Amazon Yahoo Bloomberg Pocket Gems
*/



/*DP dynamic programming
use a boolean[] to store if this substring can be find in wordic,
if it is, turn it into true, if not, into false
at the last, check boolean[s.length]
check each substring of s, */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool wordBreak(string s, unordered_set<string>& wordDict) {
        vector<bool> ret(s.size()+1,false);
        ret[0]=true;
        for(int i = 1; i <= s.size(); ++i){//start from 1 to the end of string
            for(int j = 0; j < i; ++j){
                if(ret[j] && wordDict.find(s.substr(j,i-j))!=wordDict.end()){
                    // cout << i << " " << j << endl;
                    ret[i] = true;
                    break;
                }
            }
        }
        return ret[s.size()];
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean wordBreak(String s, Set<String> wordDict) {
        boolean[] ret = new boolean[s.length()+1]; //initialize s.length
        ret[0] = true;
        for(int i = 1; i <= s.length(); ++i){//start from 1 to the end of string
            for(int j = 0; j < i; ++j){
                if(ret[j] && wordDict.contains(s.substring(j,i))){
                    ret[i] = true;
                    break;
                }
            }
        }
        return ret[s.length()];
    }
}
