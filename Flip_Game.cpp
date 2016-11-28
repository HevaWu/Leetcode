/*293. Flip Game   QuestionEditorial Solution  My Submissions
Total Accepted: 14798 Total Submissions: 28130 Difficulty: Easy Contributors: Admin
You are playing the following Flip Game with your friend: Given a string that contains only these two characters: + and -, you and your friend take turns to flip two consecutive "++" into "--". The game ends when a person can no longer make a move and therefore the other person will be the winner.

Write a function to compute all possible states of the string after one valid move.

For example, given s = "++++", after one move, it may become one of the following states:

[
  "--++",
  "+--+",
  "++--"
]
If there is no valid move, return an empty list [].

Hide Company Tags Google
Hide Tags String
Hide Similar Problems (M) Flip Game II
*/



/*
Once we find an ajacent "++", we replace it with "--" 
and push it into return list */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> generatePossibleNextMoves(string s) {
        vector<string> ret;
        if(s.size()<2) return ret;
        for(int i = 0; i <= s.size()-2; ++i){
            if(s[i]=='+' && s[i+1]=='+'){
                s[i]='-';
                s[i+1] = '-';
                ret.push_back(s);
                s[i] = '+';
                s[i+1] = '+';
            }
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> generatePossibleNextMoves(String s) {
        List<String> ret = new ArrayList<>();
        if(s.length() < 2) return ret;
        
        /*
        for(int i = 0; i <= s.length()-2; ++i){
            if(s.charAt(i)=='+' && s.charAt(i+1)=='+'){
                ret.add(s.substring(0,i) + "--" + s.substring(i+2));
            }
        }*/
        
        for(int i = -1; (i=s.indexOf("++",i+1)) >= 0; ){
            ret.add(s.substring(0,i) + "--" + s.substring(i+2));
        }
        return ret;
    }
}
