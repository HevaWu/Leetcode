/*
Given a string s, return the "reversed" string where all characters that are not a letter stay in the same place, and all letters reverse their positions.



Example 1:

Input: s = "ab-cd"
Output: "dc-ba"
Example 2:

Input: s = "a-bC-dEf-ghIj"
Output: "j-Ih-gfE-dCba"
Example 3:

Input: s = "Test1ng-Leet=code-Q!"
Output: "Qedo1ct-eeLg=ntse-T!"


Note:

s.length <= 100
33 <= s[i].ASCIIcode <= 122
s doesn't contain \ or "

*/

/*
Solution 1:
2 pointer to iterate the string and swap if it is needed

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func reverseOnlyLetters(_ s: String) -> String {
        var s = Array(s)
        var l = 0
        var r = s.count-1
        while l < r {
            if s[l].isLetter, s[r].isLetter {
                // swap l,r
                s.swapAt(l, r)
                l += 1
                r -= 1
            } else if !s[l].isLetter {
                l += 1
            } else if !s[r].isLetter {
                r -= 1
            }
        }
        return String(s)
    }
}