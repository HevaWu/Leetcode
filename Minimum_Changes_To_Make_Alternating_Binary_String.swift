/*
You are given a string s consisting only of the characters '0' and '1'. In one operation, you can change any '0' to '1' or vice versa.

The string is called alternating if no two adjacent characters are equal. For example, the string "010" is alternating, while the string "0100" is not.

Return the minimum number of operations needed to make s alternating.



Example 1:

Input: s = "0100"
Output: 1
Explanation: If you change the last character to '1', s will be "0101", which is alternating.
Example 2:

Input: s = "10"
Output: 0
Explanation: s is already alternating.
Example 3:

Input: s = "1111"
Output: 2
Explanation: You need two operations to reach "0101" or "1010".


Constraints:

1 <= s.length <= 104
s[i] is either '0' or '1'.
*/

/*
Solution 1:
two variable to store:
if make the alternate string start from 0
if make the alternate string start from 1

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minOperations(_ s: String) -> Int {
        // start as "0"
        var s0 = 0
        // start as "1"
        var s1 = 0

        var i = 0
        for c in s {
            if c == Character("0") {
                if i % 2 == 0 {
                    // flip it to 1 to keep alternate string start from 1
                    s1 += 1
                } else {
                    s0 += 1
                }
            } else {
                if i % 2 == 0 {
                    s0 += 1
                } else {
                    s1 += 1
                }
            }
            i += 1
        }
        return min(s0, s1)
    }
}
