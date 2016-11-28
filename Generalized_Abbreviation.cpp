/*320. Generalized Abbreviation   QuestionEditorial Solution  My Submissions
Total Accepted: 12274 Total Submissions: 29236 Difficulty: Medium Contributors: Admin
Write a function to generate the generalized abbreviations of a word.

Example:
Given word = "word", return the following list (order does not matter):
["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2", "2r1", "3d", "w3", "4"]
Hide Company Tags Google
Hide Tags Backtracking Bit Manipulation
Hide Similar Problems (M) Subsets (E) Unique Word Abbreviation (H) Minimum Unique Word Abbreviation
*/



/* O(2^n) time --- each char has 2 choices
backtracking DFS
first search down to the bottem return the end situation, like word -- 4, push 4 into return list
the search is check each char c, abbreviate if or not
abbreviate: count num of abbreviate char, but not append yet
not abbreviate: append former num and cur char
in the end, appedn remain num
use stringbuilder to decrease time*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> generateAbbreviations(string word) {
        vector<string> ret;
        string str = "";
        DFSBackTrack(ret, str, word, 0, 0);
        return ret;
    }
    
    void DFSBackTrack(vector<string>& ret, string str, string word, int pos, int num){
        if(pos == word.size()){
            if(num!=0) str += to_string(num);
            ret.push_back(str);
        } else {
            DFSBackTrack(ret, str, word, pos+1, num+1);
            
            if(num!=0) str += to_string(num);
            DFSBackTrack(ret, str+=word[pos], word, pos+1, 0);
        }
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> generateAbbreviations(String word) {
        List<String> ret = new ArrayList<>();
        DFSBackTrack(ret, new StringBuilder(), word.toCharArray(), 0, 0);
        return ret;
    }
    
    public void DFSBackTrack(List<String> ret, StringBuilder str, char[] cword, int pos, int num ){
        int len = str.length();
        
        //pos is the index which we walked
        //num is how many abbreviate chars we hold
        if(pos == cword.length){
            if(num!=0) str.append(num); //first append current num we hold
            ret.add(str.toString()); //then push cur string into ret list
        } else {
            DFSBackTrack(ret, str, cword, pos+1, num+1); //hold cur char as abbreviate char
            
            if(num!=0) str.append(num); //not hold cur char, push it into str
            DFSBackTrack(ret, str.append(cword[pos]), cword, pos+1, 0);
        }
        
        str.setLength(len); //for provide append other values
    }
}
