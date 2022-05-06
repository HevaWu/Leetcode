/*
Given a string s, a k duplicate removal consists of choosing k adjacent and equal letters from s and removing them causing the left and the right side of the deleted substring to concatenate together.

We repeatedly make k duplicate removals on s until we no longer can.

Return the final string after all such duplicate removals have been made.

It is guaranteed that the answer is unique.



Example 1:

Input: s = "abcd", k = 2
Output: "abcd"
Explanation: There's nothing to delete.
Example 2:

Input: s = "deeedbbcccbdaa", k = 3
Output: "aa"
Explanation:
First delete "eee" and "ccc", get "ddbbbdaa"
Then delete "bbb", get "dddaa"
Finally delete "ddd", get "aa"
Example 3:

Input: s = "pbbcggttciiippooaais", k = 2
Output: "ps"


Constraints:

1 <= s.length <= 10^5
2 <= k <= 10^4
s only contains lower case English letters.
*/

/*
Solution 2:
shorten code by using stack only

But it cost longer time than Solution 1, because we add redundant push into stack operation

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public String removeDuplicates(String s, int k) {
        Stack<Character> cstack = new Stack<>();
        Stack<Integer> count = new Stack<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (cstack.size() != 0 && cstack.peek() == c) {
                int lastCount = count.pop();
                lastCount += 1;
                if (lastCount == k) {
                    cstack.pop();
                    continue;
                } else {
                    count.push(lastCount);
                }
            } else {
                cstack.push(c);
                count.push(1);
            }
        }

        // System.out.println(cstack.size());
        // System.out.println(count.size());

        StringBuilder sb = new StringBuilder();
        while (cstack.size() > 0) {
            char c = cstack.pop();
            int num = count.pop();

            // System.out.println(c);
            // System.out.println(num);

            for(int i = 0; i < num; i++) {
                sb.insert(0, c);
            }
        }
        return sb.toString();
    }
}