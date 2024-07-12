/*
You are given a string s and two integers x and y. You can perform two types of operations any number of times.

Remove substring "ab" and gain x points.
For example, when removing "ab" from "cabxbae" it becomes "cxbae".
Remove substring "ba" and gain y points.
For example, when removing "ba" from "cabxbae" it becomes "cabxe".
Return the maximum points you can gain after applying the above operations on s.



Example 1:

Input: s = "cdbcbbaaabab", x = 4, y = 5
Output: 19
Explanation:
- Remove the "ba" underlined in "cdbcbbaaabab". Now, s = "cdbcbbaaab" and 5 points are added to the score.
- Remove the "ab" underlined in "cdbcbbaaab". Now, s = "cdbcbbaa" and 4 points are added to the score.
- Remove the "ba" underlined in "cdbcbbaa". Now, s = "cdbcba" and 5 points are added to the score.
- Remove the "ba" underlined in "cdbcba". Now, s = "cdbc" and 5 points are added to the score.
Total score = 5 + 4 + 5 + 5 = 19.
Example 2:

Input: s = "aabbaaxybbaabb", x = 5, y = 4
Output: 20


Constraints:

1 <= s.length <= 105
1 <= x, y <= 104
s consists of lowercase English letters.
*/

/*
Solution 1:
First omit all high score pairs, then loop all low score pairs

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maximumGain(_ s: String, _ x: Int, _ y: Int) -> Int {
        var points = 0
        var top = [Character]()
        var topScore = 0
        var bot = [Character]()
        var botScore = 0
        if y > x {
            top = [Character("b"), Character("a")]
            topScore = y
            bot = [Character("a"), Character("b")]
            botScore = x
        } else {
            top = [Character("a"), Character("b")]
            topScore = x
            bot = [Character("b"), Character("a")]
            botScore = y
        }

        // remove first top substrings, because they have more points
        var stack = [Character]()
        for c in s {
            if c == top[1], !stack.isEmpty, stack.last! == top[0] {
                points += topScore
                stack.removeLast()
            } else {
                stack.append(c)
            }
        }

        // remove bot substrings to get more points
        var stack2 = [Character]()
        for c in stack {
            if c == bot[1], !stack2.isEmpty, stack2.last! == bot[0] {
                points += botScore
                stack2.removeLast()
            } else {
                stack2.append(c)
            }
        }

        return points
    }
}
