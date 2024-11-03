/*
Given two strings s and goal, return true if and only if s can become goal after some number of shifts on s.

A shift on s consists of moving the leftmost character of s to the rightmost position.

For example, if s = "abcde", then it will be "bcdea" after one shift.


Example 1:

Input: s = "abcde", goal = "cdeab"
Output: true
Example 2:

Input: s = "abcde", goal = "abced"
Output: false


Constraints:

1 <= s.length, goal.length <= 100
s and goal consist of lowercase English letters.

*/

/*
Solution 1:
for each index in goal, check if this could be start character of s,
if it is, check if this is a possible shift string (start from i in goal)

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func rotateString(_ s: String, _ goal: String) -> Bool {
        let ns = s.count
        let ng = goal.count
        if ns != ng { return false }

        var goal = Array(goal)
        var s = Array(s)
        for i in 0..<ng {
            if goal[i] == s[0], canRotate(i, goal, ng, s, ns) {
                return true
            }
        }
        return false
    }

    func canRotate(_ index: Int, _ goal: [Character], _ ng: Int, _ s: [Character], _ ns: Int) -> Bool {
        var index = index
        for i in 0..<ns {
            if s[i] != goal[index] {
                return false
            }
            index += 1
            if index == ng {
                index = 0
            }
        }
        return true
    }
}
