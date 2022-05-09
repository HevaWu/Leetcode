/*17. Letter Combinations of a Phone Number  QuestionEditorial Solution  My Submissions
Total Accepted: 103830 Total Submissions: 333425 Difficulty: Medium
Given a digit string, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below.



Input:Digit string "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
Note:
Although the above answer is in lexicographical order, your answer could be in any order you want.

Hide Company Tags Amazon Dropbox Google Uber Facebook
Hide Tags Backtracking String
Hide Similar Problems (M) Generate Parentheses (M) Combination Sum (E) Binary Watch
*/



/* FIFO queue
use a string array to store the chars in correspond number
by comparing current.length == i, we push each char into array list
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> letterCombinations(string digits) {
        vector<string> ret;
        if(digits.size()<1) return ret;

        vector<string> num = {"0", "1", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        queue<string> Q;  //implement FIFO
        Q.push("");
        for(int i = 0; i < digits.size(); ++i){
            int x = digits[i]-'0';
            while(Q.front().size() == i){
                string temp = Q.front();
                Q.pop();
                for(char c: num[x]){
                    Q.push(temp+c);
                }
            }
        }

        //copy from queue to string
        while(Q.size()){
            ret.push_back(Q.front());
            Q.pop();
        }
        return ret;
    }
};
