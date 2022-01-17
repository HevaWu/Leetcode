/*
Given a pattern and a string s, find if s follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.



Example 1:

Input: pattern = "abba", s = "dog cat cat dog"
Output: true
Example 2:

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
Example 3:

Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false


Constraints:

1 <= pattern.length <= 300
pattern contains only lower-case English letters.
1 <= s.length <= 3000
s contains only lowercase English letters and spaces ' '.
s does not contain any leading or trailing spaces.
All the words in s are separated by a single space.
*/

/*
Solution 1
2 maps

wordToLetter
letterToWord

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let words = s.split(separator: " ")
        let pattern = Array(pattern)

        var letterToWord = [Int: String]()
        var wordToLetter = [String: Int]()

        if pattern.count != words.count { return false }
        let ascii_a = Character("a").asciiValue!

        for i in 0..<pattern.count {
            let letter = Int(pattern[i].asciiValue! - ascii_a)
            let word = String(words[i])

            if let existWord = letterToWord[letter],
            existWord != word {
                return false
            }
            if let existLetter = wordToLetter[word],
            existLetter != letter {
                return false
            }

            letterToWord[letter] = word
            wordToLetter[word] = letter
        }
        return true
    }
}