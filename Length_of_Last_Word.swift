/*
Given a string s consisting of words and spaces, return the length of the last word in the string.

A word is a maximal
substring
 consisting of non-space characters only.



Example 1:

Input: s = "Hello World"
Output: 5
Explanation: The last word is "World" with length 5.
Example 2:

Input: s = "   fly me   to   the moon  "
Output: 4
Explanation: The last word is "moon" with length 4.
Example 3:

Input: s = "luffy is still joyboy"
Output: 6
Explanation: The last word is "joyboy" with length 6.


Constraints:

1 <= s.length <= 104
s consists of only English letters and spaces ' '.
There will be at least one word in s.
*/

/*
Solution 1:
Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func lengthOfLastWord(_ s: String) -> Int {
        var len = 0
        var end = s.count-1
        var s = Array(s)
        while end >= 0, s[end] == Character(" ") {
            end -= 1
        }
        while end >= 0, s[end] != Character(" ") {
            len += 1
            end -= 1
        }
        return len
    }
}
