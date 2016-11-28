/*20. Valid Parentheses  QuestionEditorial Solution  My Submissions
Total Accepted: 136605 Total Submissions: 439636 Difficulty: Easy
Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.

Hide Company Tags Google Airbnb Facebook Twitter Zenefits Amazon Microsoft Bloomberg
Hide Tags Stack String
Hide Similar Problems (M) Generate Parentheses (H) Longest Valid Parentheses (H) Remove Invalid Parentheses
*/




/*use stack to store parentheses
if it is  ( [ {  push them in
else pop them, and check*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool isValid(string s) {
        stack<char> s1;
        
        for(char c:s){
            if(c=='(' || c=='{' || c=='[') s1.push(c);
            else if(c==')' && !s1.empty() && s1.top()=='(') s1.pop();
            else if(c=='}' && !s1.empty() && s1.top()=='{') s1.pop();
            else if(c==']' && !s1.empty() && s1.top()=='[') s1.pop();
            else  return false;
        }
        
        return s1.empty();
    }
};

class Solution {
public:
    bool isValid(string s) {
        stack<char> s1;
        for(char &c : s){
            switch(c){
                case '(': //s1.push(c); break;
                case '{': //s1.push(c); break;
                case '[': s1.push(c); break;
                case ')': if(s1.empty() || s1.top()!='(') return false; else s1.pop(); break;
                case '}': if(s1.empty() || s1.top()!='{') return false; else s1.pop(); break;
                case ']': if(s1.empty() || s1.top()!='[') return false; else s1.pop(); break;
                default: ;
            }
        }
        return s1.empty();
    }
};






/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isValid(String s) {
        Stack<Character> s1 = new Stack<>();
        for(char c:s.toCharArray()){
            if(c=='(' || c=='{' || c=='[' ) s1.push(c);
            else if(c==')' && !s1.empty() && s1.peek()=='(') s1.pop(); //remember !empty
            else if(c=='}' && !s1.empty() && s1.peek()=='{') s1.pop();
            else if(c==']' && !s1.empty() && s1.peek()=='[') s1.pop();
            else return false; //need to return false like []} situation
        }
        
        return s1.empty();
    }
}