/*224. Basic Calculator   QuestionEditorial Solution  My Submissions
Total Accepted: 36977 Total Submissions: 151114 Difficulty: Hard Contributors:
Admin Implement a basic calculator to evaluate a simple expression string.

The expression string may contain open ( and closing parentheses ), the plus +
or minus sign -, non-negative integers and empty spaces .

You may assume that the given expression is always valid.

Some examples:
"1 + 1" = 2
" 2-1 + 2 " = 3
"(1+(4+5+2)-3)+(6+8)" = 23
Note: Do not use the eval built-in library function.

Hide Company Tags Google
Hide Tags Stack Math
Hide Similar Problems (M) Evaluate Reverse Polish Notation (M) Basic Calculator
II (M) Different Ways to Add Parentheses (H) Expression Add Operators
*/

/*
iterative, stack
input is valid, parentheses are always paired and in order
( --- push the previous ret and sign into the stack, set the ret to 0, just
calculate the new ret within the parentheses ) --- pop out the two numbers from
stack, first one is the sign before this pair of parentheses, second is the
temporary ret before this pair of parenthesis, add together*/
class Solution {
 public:
  int calculate(string s) {
    stack<int> S;
    int ret = 0;
    int sign = 1;
    int num = 0;
    for (int i = 0; i < s.size(); ++i) {
      if (isdigit(s[i])) {
        num = num * 10 + s[i] - '0';
      } else if (s[i] == '+') {
        ret += num * sign;
        num = 0;
        sign = 1;
      } else if (s[i] == '-') {
        ret += num * sign;
        num = 0;
        sign = -1;
      } else if (s[i] == '(') {
        S.push(ret);
        S.push(sign);
        sign = 1;
        ret = 0;
      } else if (s[i] == ')') {
        ret += sign * num;
        num = 0;
        ret = ret * S.top();
        S.pop();
        ret += S.top();
        S.pop();
      }
    }
    if (num != 0) ret += sign * num;
    return ret;
  }
};
