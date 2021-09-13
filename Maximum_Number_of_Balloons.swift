/*
Given a string text, you want to use the characters of text to form as many instances of the word "balloon" as possible.

You can use each character in text at most once. Return the maximum number of instances that can be formed.



Example 1:



Input: text = "nlaebolko"
Output: 1
Example 2:



Input: text = "loonbalxballpoon"
Output: 2
Example 3:

Input: text = "leetcode"
Output: 0


Constraints:

1 <= text.length <= 104
text consists of lower case English letters only.
*/

/*
Solution 1:
Find the letter than can make the minimum number of instances of the word "balloon".

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maxNumberOfBalloons(_ text: String) -> Int {
        // balloon

        var charMap = [Character: Int]()

        for c in text {
            charMap[c, default: 0] += 1
        }

        // check appearance of b,a,l,o,n
        let b = charMap[Character("b"), default: 0]
        let a = charMap[Character("a"), default: 0]
        let l = charMap[Character("l"), default: 0] / 2
        let o = charMap[Character("o"), default: 0] / 2
        let n = charMap[Character("n"), default: 0]

        return min(
            min(b, a),
            min(l, min(o, n))
        )
    }
}