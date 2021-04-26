/*
Your friend is typing his name into a keyboard. Sometimes, when typing a character c, the key might get long pressed, and the character will be typed 1 or more times.

You examine the typed characters of the keyboard. Return True if it is possible that it was your friends name, with some characters (possibly none) being long pressed.



Example 1:

Input: name = "alex", typed = "aaleex"
Output: true
Explanation: 'a' and 'e' in 'alex' were long pressed.
Example 2:

Input: name = "saeed", typed = "ssaaedd"
Output: false
Explanation: 'e' must have been pressed twice, but it wasn't in the typed output.
Example 3:

Input: name = "leelee", typed = "lleeelee"
Output: true
Example 4:

Input: name = "laiden", typed = "laiden"
Output: true
Explanation: It's not necessary to long press any character.


Constraints:

1 <= name.length <= 1000
1 <= typed.length <= 1000
name and typed contain only lowercase English letters.
*/

/*
Solution 1:
2 pointer
iterate name & typed

Time Complexity: O(max(n1, n2))
Space Complexity: O(1)
*/
class Solution {
    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        var name = Array(name)
        var typed = Array(typed)

        let n1 = name.count
        let n2 = typed.count

        if n2 < n1 { return false }

        var i1 = 0
        var i2 = 0
        while i1 < n1, i2 < n2 {
            if name[i1] == typed[i2] {
                i1 += 1
                i2 += 1
            } else if i1 > 0, typed[i2] == name[i1-1] {
                // long typed char
                i2 += 1
            } else {
                return false
            }
        }

        // i2 reach the end, but i1 still contains some unchecked char
        if i1 != n1 { return false }

        // check if remaining typed char is same as last char in name
        while i2 < n2 {
            if name[n1-1] == typed[i2] {
                i2 += 1
            } else {
                return false
            }
        }

        return true
    }
}