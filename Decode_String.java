/*
Given an encoded string, return its decoded string.

The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.

You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.

Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].

Examples:

s = "3[a]2[bc]", return "aaabcbc".
s = "3[a2[c]]", return "accaccacc".
s = "2[abc]3[cd]ef", return "abcabccdcdcdef".
*/

/*
Solution 2:
iterate string

DFS stack

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public String decodeString(String s) {
        Stack<String> pendStr = new Stack<>();
        Stack<Integer> pendRepeat = new Stack<>();

        StringBuilder sb = new StringBuilder();
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                count = count * 10 + (s.charAt(i)-'0');
            } else if (s.charAt(i) == '[') {
                pendRepeat.push(count > 0 ? count : 1);
                count = 0;
                pendStr.push(sb.toString());
                sb = new StringBuilder();
            } else if (s.charAt(i) == ']') {
                int shouldRepeat = pendRepeat.pop();
                StringBuilder newsb = new StringBuilder();
                String repeatStr = pendStr.pop();
                newsb.append(repeatStr);
                while (shouldRepeat > 0) {
                    newsb.append(sb);
                    shouldRepeat -= 1;
                }
                sb = newsb;
            } else {
                sb.append(s.charAt(i));
            }
        }

        return sb.toString();
    }
}