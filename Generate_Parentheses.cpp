/*22. Generate Parentheses  QuestionEditorial Solution  My Submissions
Total Accepted: 110143 Total Submissions: 273900 Difficulty: Medium
Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

For example, given n = 3, a solution set is:

[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]
Hide Company Tags Google Uber Zenefits
Hide Tags Backtracking String
Hide Similar Problems (M) Letter Combinations of a Phone Number (E) Valid Parentheses
*/



/*use two int to count the remainning left parenthesis(left) and right parenthesis(right)
each step, if left>0, add a left parenthesis
if right >0, add a right parenthesis
append the resulf if left==0 and right==0
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> generateParenthesis(int n) {
        vector<string> ret;
        addParenthesis(ret, "", n, 0);
        return ret;
    }
    
    void addParenthesis(vector<string> &ret, string str, int left, int right){
        if(left==0 && right==0){
            ret.push_back(str);
            return;
        }
        if(left>0){
            addParenthesis(ret, str+"(", left-1, right+1);
        }
        if(right > 0){
            addParenthesis(ret, str+")", left, right-1);
        }
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> generateParenthesis(int n) {
        List<String> ret = new ArrayList<>();
        addParenthesis(ret, "", n, 0); //just pass string not StringBuilder
        return ret;
    }
    
    public void addParenthesis(List<String> ret, String str, int left, int right){
        if(left==0 && right==0) {
            ret.add(str.toString());
            return;
        }
        if(left>0){
            addParenthesis(ret, str+"(", left-1, right+1);
        }
        if(right>0){
            addParenthesis(ret, str+")", left, right-1);
        }
    }
}
