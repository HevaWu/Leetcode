/*
Given a string s, return true if the s can be palindrome after deleting at most one character from it.



Example 1:

Input: s = "aba"
Output: true
Example 2:

Input: s = "abca"
Output: true
Explanation: You could delete the character 'c'.
Example 3:

Input: s = "abc"
Output: false


Constraints:

1 <= s.length <= 105
s consists of lowercase English letters.
*/

/*
Solution 1:
two pointer,
use isPalindrome to help checking if string is a palindrome string
*/
class Solution {
    func validPalindrome(_ s: String) -> Bool {
        var low = 0
        var high = s.count-1
        var s = Array(s)

        while low < high {
            if s[low] == s[high] {
                low += 1
                high -= 1
            } else {
                return isPalindrome(Array(s[(low+1)...high]))
                || isPalindrome(Array(s[low..<high]))
            }
        }
        return true
    }

    func isPalindrome(_ s: [Character]) -> Bool {
        var low = 0
        var high = s.count-1
        while low < high {
            if s[low] != s[high] {
                return false
            }
            low += 1
            high -= 1
        }
        return true
    }
}