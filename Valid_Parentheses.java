/*
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:

 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 Note that an empty string is also considered valid.

 Example 1:

 Input: "()"
 Output: true
 Example 2:

 Input: "()[]{}"
 Output: true
 Example 3:

 Input: "(]"
 Output: false
 Example 4:

 Input: "([)]"
 Output: false
 Example 5:

 Input: "{[]}"
 Output: true

 Hint
 An interesting property about a valid parenthesis expression is that a sub-expression of a valid expression should also be a valid expression. (Not every sub-expression) e.g.
 { { } [ ] [ [ [ ] ] ] } is VALID expression
           [ [ [ ] ] ]    is VALID sub-expression
   { } [ ]                is VALID sub-expression
 Can we exploit this recursive structure somehow?

 What if whenever we encounter a matching pair of parenthesis in the expression, we simply remove it from the expression? This would keep on shortening the expression. e.g.
 { { ( { } ) } }
       |_|
 { { (      ) } }
     |______|
 { {          } }
   |__________|
 {                }
 |________________|
 VALID EXPRESSION!

 The stack data structure can come in handy here in representing this recursive structure of the problem. We can't really process this from the inside out because we don't have an idea about the overall structure. But, the stack can help us process this recursively i.e. from outside to inwards.
*/

/*
Solution 2:
stack
optimize solution 1

Time Complexity: O(n)
Space Complexity: O(n) - all char are left or right
*/
class Solution {
    public boolean isValid(String s) {
        if (s.length() == 0) {
            return true;
        }

        Map<Character, Character> dic = new HashMap<>();
        dic.put('}', '{');
        dic.put(']', '[');
        dic.put(')', '(');

        Stack<Character> leftStack = new Stack<>();
        for(int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (dic.containsKey(c)) {
                // c is right bracket
                char leftKey = dic.get(c);
                if (leftStack.size() > 0 && leftKey == leftStack.peek()) {
                    leftStack.pop();
                } else {
                    return false;
                }
            } else {
                // c is left bracket
                leftStack.push(c);
            }
        }
        return leftStack.size() == 0;
    }
}