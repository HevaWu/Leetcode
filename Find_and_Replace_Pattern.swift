/*
Given a list of strings words and a string pattern, return a list of words[i] that match pattern. You may return the answer in any order.

A word matches the pattern if there exists a permutation of letters p so that after replacing every letter x in the pattern with p(x), we get the desired word.

Recall that a permutation of letters is a bijection from letters to letters: every letter maps to another letter, and no two letters map to the same letter.



Example 1:

Input: words = ["abc","deq","mee","aqq","dkd","ccc"], pattern = "abb"
Output: ["mee","aqq"]
Explanation: "mee" matches the pattern because there is a permutation {a -> m, b -> e, ...}.
"ccc" does not match the pattern because {a -> c, b -> c, ...} is not a permutation, since a and b map to the same letter.
Example 2:

Input: words = ["a","b","c"], pattern = "a"
Output: ["a","b","c"]


Constraints:

1 <= pattern.length <= 20
1 <= words.length <= 50
words[i].length == pattern.length
pattern and words[i] are lowercase English letters.
*/

/*
Solution 1:
2 maps

Idea:
- check if each words match pattern
- in match, use 2 map to check if 2 char is map correctly

Time Complexity: O(nk)
- n is words.count
- k is pattern.count

Space Complexity: O(k)
*/
class Solution {
    func findAndReplacePattern(_ words: [String], _ pattern: String) -> [String] {
        return words.filter { match($0, pattern) }
    }

    func match(_ word: String, _ pattern: String) -> Bool {
        if word.count != pattern.count { return false }
        let n = word.count

        var wp = [Character: Character]()
        var pw = [Character: Character]()

        // defer {
        //     print(word, wp, pw)
        // }

        for i in word.indices {
            let w = word[i]
            let p = pattern[i]

            if (wp[w] != nil && wp[w]! != p)
            || (pw[p] != nil && pw[p]! != w) {
                return false
            }

            wp[w] = p
            pw[p] = w
        }
        return true
    }
}