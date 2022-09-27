'''
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
'''

'''
Solution 2:
2 loop

Scanning from left to right, our force decays by 1 every iteration, and resets to N if we meet an 'R', so that force[i] is higher (than force[j]) if and only if dominoes[i] is closer (looking leftward) to 'R' (than dominoes[j]).

Similarly, scanning from right to left, we can find the force going rightward (closeness to 'L').

For some domino answer[i], if the forces are equal, then the answer is '.'. Otherwise, the answer is implied by whichever force is stronger.

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def pushDominoes(self, dominoes: str) -> str:
        n = len(dominoes)
        d = [0 for i in range(n)]

        # left to right
        level = 0
        for i in range(n):
            if dominoes[i] == "R":
                level = n
            elif dominoes[i] == "L":
                level = 0
            else:
                level = max(level-1, 0)
            d[i] += level

        # right to left
        level = 0
        for i in range(n-1, -1, -1):
            if dominoes[i] == "L":
                level = n
            elif dominoes[i] == "R":
                level = 0
            else:
                level = max(level-1, 0)
            d[i] -= level

        res = ""
        for i in range(n):
            c = "."
            if d[i] > 0:
                c = "R"
            elif d[i] < 0:
                c = "L"
            res += c
        return res
