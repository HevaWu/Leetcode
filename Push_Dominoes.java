/*
There are N dominoes in a line, and we place each domino vertically upright.

In the beginning, we simultaneously push some of the dominoes either to the left or to the right.



After each second, each domino that is falling to the left pushes the adjacent domino on the left.

Similarly, the dominoes falling to the right push their adjacent dominoes standing on the right.

When a vertical domino has dominoes falling on it from both sides, it stays still due to the balance of the forces.

For the purposes of this question, we will consider that a falling domino expends no additional force to a falling or already fallen domino.

Given a string "S" representing the initial state. S[i] = 'L', if the i-th domino has been pushed to the left; S[i] = 'R', if the i-th domino has been pushed to the right; S[i] = '.', if the i-th domino has not been pushed.

Return a string representing the final state.

Example 1:

Input: ".L.R...LR..L.."
Output: "LL.RR.LLRRLL.."
Example 2:

Input: "RR.L"
Output: "RR.L"
Explanation: The first domino expends no additional force on the second domino.
Note:

0 <= N <= 10^5
String dominoes contains only 'L', 'R' and '.'
*/

/*
Solution 2:
2 loop

Scanning from left to right, our force decays by 1 every iteration, and resets to N if we meet an 'R', so that force[i] is higher (than force[j]) if and only if dominoes[i] is closer (looking leftward) to 'R' (than dominoes[j]).

Similarly, scanning from right to left, we can find the force going rightward (closeness to 'L').

For some domino answer[i], if the forces are equal, then the answer is '.'. Otherwise, the answer is implied by whichever force is stronger.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public String pushDominoes(String dominoes) {
        int n = dominoes.length();
        int[] d = new int[n];

        int level = 0;
        for (int i = 0; i < n; i++) {
            // from left to right
            if (dominoes.charAt(i) == 'R') {
                level = n;
            } else if (dominoes.charAt(i) == 'L') {
                level = 0;
            } else {
                level = Math.max(level - 1, 0);
            }
            d[i] += level;
        }

        level = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (dominoes.charAt(i) == 'L') {
                level = n;
            } else if (dominoes.charAt(i) == 'R') {
                level = 0;
            } else {
                level = Math.max(level - 1, 0);
            }
            d[i] -= level;
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append(d[i] > 0 ? 'R' : (d[i] == 0 ? '.' : 'L'));
        }
        return sb.toString();
    }
}
