/*
Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.

Example 1:

Input: S = "ab#c", T = "ad#c"
Output: true
Explanation: Both S and T become "ac".
Example 2:

Input: S = "ab##", T = "c#d#"
Output: true
Explanation: Both S and T become "".
Example 3:

Input: S = "a##c", T = "#a#c"
Output: true
Explanation: Both S and T become "c".
Example 4:

Input: S = "a#c", T = "b"
Output: false
Explanation: S becomes "c" while T becomes "b".
Note:

1 <= S.length <= 200
1 <= T.length <= 200
S and T only contain lowercase letters and '#' characters.
Follow up:

Can you solve it in O(N) time and O(1) space?
*/

/*
Solution 2:
Iterate through the string in reverse. If we see a backspace character, the next non-backspace character is skipped. If a character isn't skipped, it is part of the final answer.

Time Complexity: O(M + N), where M, NM,N are the lengths of S and T respectively.
Space Complexity: O(1).
*/
class Solution {
    public boolean backspaceCompare(String s, String t) {
        int skips = 0;
        int skipt = 0;

        int si = s.length() - 1;
        int ti = t.length() - 1;
        while (si >= 0 || ti >= 0) {
            while (si >= 0) {
                if (s.charAt(si) == '#') {
                    skips += 1;
                    si -= 1;
                } else if (skips > 0) {
                    skips -= 1;
                    si -= 1;
                } else {
                    break;
                }
            }

            while (ti >= 0) {
                if (t.charAt(ti) == '#') {
                    skipt += 1;
                    ti -= 1;
                } else if (skipt > 0) {
                    skipt -= 1;
                    ti -= 1;
                } else {
                    break;
                }
            }

            if (si >= 0 && ti >= 0
                && s.charAt(si) == t.charAt(ti)) {
                si -= 1;
                ti -= 1;
            } else if (si < 0 && ti < 0) {
                return true;
            } else {
                return false;
            }
        }

        return true;
    }
}