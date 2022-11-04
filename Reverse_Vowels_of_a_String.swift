/*
Given a string s, reverse only all the vowels in the string and return it.

The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.



Example 1:

Input: s = "hello"
Output: "holle"
Example 2:

Input: s = "leetcode"
Output: "leotcede"


Constraints:

1 <= s.length <= 3 * 105
s consist of printable ASCII characters.
*/


/*
Solution 1:
2 pointer

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func reverseVowels(_ s: String) -> String {
        var s = Array(s)
        var i = 0
        var j = s.count-1
        while i < j {
            while i < j, !vowelSet.contains(s[i]) {
                i += 1
            }
            while i < j, !vowelSet.contains(s[j]) {
                j -= 1
            }

            // swap i, j
            s.swapAt(i, j)

            i += 1
            j -= 1
        }
        return String(s)
    }

    let vowelSet = Set([
        Character("a"),
        Character("e"),
        Character("i"),
        Character("o"),
        Character("u"),
        Character("A"),
        Character("E"),
        Character("I"),
        Character("O"),
        Character("U"),
    ])
}
