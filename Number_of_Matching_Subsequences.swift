/*
Given a string s and an array of strings words, return the number of words[i] that is a subsequence of s.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

For example, "ace" is a subsequence of "abcde".


Example 1:

Input: s = "abcde", words = ["a","bb","acd","ace"]
Output: 3
Explanation: There are three strings in words that are a subsequence of s: "a", "acd", "ace".
Example 2:

Input: s = "dsahjpjauf", words = ["ahjpjau","ja","ahbwzgqnuk","tnmlanowax"]
Output: 2


Constraints:

1 <= s.length <= 5 * 104
1 <= words.length <= 5000
1 <= words[i].length <= 50
s and words[i] consist of only lowercase English letters.
*/

/*
Solution 1:
map + traverse String

use isSub() to help checking if sub is substring of s
use cache to memorize previous checked string

Time Complexity: O(n_s * max(words[i].count))
*/
class Solution {
    func numMatchingSubseq(_ s: String, _ words: [String]) -> Int {
        var s = Array(s)
        var count = 0

        // memo previous checked string
        var cache = [String: Bool]()
        for word in words {
            if let val = cache[word] {
                count += (val ? 1 : 0)
            } else {
                let val = isSub(s, Array(word))
                count += (val ? 1 : 0)
                cache[word] = val
            }
        }
        return count
    }

    func isSub(_ s: [Character], _ sub: [Character]) -> Bool {
        let n_s = s.count
        let n_sub = sub.count

        var i_s = 0
        for i in 0..<sub.count {
            while i_s < n_s, s[i_s] != sub[i] {
                i_s += 1
            }
            if i_s == n_s { return false }
            i_s += 1
        }
        return true
    }
}