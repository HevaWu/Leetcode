/*
Given a string s and an integer k, return the maximum number of vowel letters in any substring of s with length k.

Vowel letters in English are 'a', 'e', 'i', 'o', and 'u'.



Example 1:

Input: s = "abciiidef", k = 3
Output: 3
Explanation: The substring "iii" contains 3 vowel letters.
Example 2:

Input: s = "aeiou", k = 2
Output: 2
Explanation: Any substring of length 2 contains 2 vowels.
Example 3:

Input: s = "leetcode", k = 3
Output: 2
Explanation: "lee", "eet" and "ode" contain 2 vowels.


Constraints:

1 <= s.length <= 105
s consists of lowercase English letters.
1 <= k <= s.length
*/

/*
Solution 1:
iteration
always keep k size window and check its maximum vowel numbers

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxVowels(_ s: String, _ k: Int) -> Int {
        var vowel = Set<Character>([
            Character("a"),
            Character("e"),
            Character("i"),
            Character("o"),
            Character("u")
        ])
        var cur = 0
        var val = 0
        var s = Array(s)
        for i in 0..<s.count {
            if i >= k {
                cur -= (vowel.contains(s[i-k]) ? 1 : 0)
            }
            cur += (vowel.contains(s[i]) ? 1 : 0)
            val = max(val, cur)
        }
        return val
    }
}
