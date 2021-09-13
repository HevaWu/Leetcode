/*
Given a string text, you want to use the characters of text to form as many instances of the word "balloon" as possible.

You can use each character in text at most once. Return the maximum number of instances that can be formed.



Example 1:



Input: text = "nlaebolko"
Output: 1
Example 2:



Input: text = "loonbalxballpoon"
Output: 2
Example 3:

Input: text = "leetcode"
Output: 0


Constraints:

1 <= text.length <= 104
text consists of lower case English letters only.
*/

/*
Solution 1:
Find the letter than can make the minimum number of instances of the word "balloon".

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public int maxNumberOfBalloons(String text) {
        // balloon
        int b = 0;
        int a = 0;
        int l = 0;
        int o = 0;
        int n = 0;

        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (c == 'b') {
                b += 1;
            } else if (c == 'a') {
                a += 1;
            } else if (c == 'l') {
                l += 1;
            } else if (c == 'o') {
                o += 1;
            } else if (c == 'n') {
                n += 1;
            }
        }

        l = l/2;
        o = o/2;

        return Math.min(
            Math.min(b, a),
            Math.min(l, Math.min(o, n))
        );
    }
}