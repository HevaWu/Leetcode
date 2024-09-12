/*
You are given a string allowed consisting of distinct characters and an array of strings words. A string is consistent if all characters in the string appear in the string allowed.

Return the number of consistent strings in the array words.



Example 1:

Input: allowed = "ab", words = ["ad","bd","aaab","baa","badab"]
Output: 2
Explanation: Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.
Example 2:

Input: allowed = "abc", words = ["a","b","c","ab","ac","bc","abc"]
Output: 7
Explanation: All strings are consistent.
Example 3:

Input: allowed = "cad", words = ["cc","acd","b","ba","bac","bad","ac","d"]
Output: 4
Explanation: Strings "cc", "acd", "ac", and "d" are consistent.


Constraints:

1 <= words.length <= 104
1 <= allowed.length <= 26
1 <= words[i].length <= 10
The characters in allowed are distinct.
words[i] and allowed contain only lowercase English letters.
*/

/*
Solution 1:
check word by word
store allowed in an array

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countConsistentStrings(_ allowed: String, _ words: [String]) -> Int {
        var charAllowed = Array(repeating: false, count: 26)
        for c in allowed {
            let index = indexOfChar(c)
            charAllowed[index] = true
        }

        var consistent = 0
        for word in words {
            if wordIsAllowed(word, charAllowed) {
                consistent += 1
            }
        }
        return consistent
    }

    func wordIsAllowed(_ word: String, _ charAllowed: [Bool]) -> Bool {
        for c in word {
            let index = indexOfChar(c)
            if !charAllowed[index] {
                return false
            }
        }
        return true
    }

    func indexOfChar(_ c: Character) -> Int {
        let a = Character("a").asciiValue!
        return Int(c.asciiValue! - a)
    }
}
