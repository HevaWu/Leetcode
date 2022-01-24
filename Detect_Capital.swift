/*
We define the usage of capitals in a word to be right when one of the following cases holds:

All letters in this word are capitals, like "USA".
All letters in this word are not capitals, like "leetcode".
Only the first letter in this word is capital, like "Google".
Given a string word, return true if the usage of capitals in it is right.



Example 1:

Input: word = "USA"
Output: true
Example 2:

Input: word = "FlaG"
Output: false


Constraints:

1 <= word.length <= 100
word consists of lowercase and uppercase English letters.
*/

/*
Solution 1:
check all of uppercase count in the string

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func detectCapitalUse(_ word: String) -> Bool {
        if word.count == 1 {
            return true
        }

        var uppercaseCount = 0
        for c in word {
            if c.isUppercase {
                uppercaseCount += 1
            }
        }

        if (uppercaseCount == 0)
        || (uppercaseCount == word.count)
        || (uppercaseCount == 1 && word.first?.isUppercase == true) {
            return true
        }
        return false
    }
}