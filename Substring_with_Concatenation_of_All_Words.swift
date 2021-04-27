/*
You are given a string s and an array of strings words of the same length. Return all starting indices of substring(s) in s that is a concatenation of each word in words exactly once, in any order, and without any intervening characters.

You can return the answer in any order.



Example 1:

Input: s = "barfoothefoobarman", words = ["foo","bar"]
Output: [0,9]
Explanation: Substrings starting at index 0 and 9 are "barfoo" and "foobar" respectively.
The output order does not matter, returning [9,0] is fine too.
Example 2:

Input: s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]
Output: []
Example 3:

Input: s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]
Output: [6,9,12]


Constraints:

1 <= s.length <= 104
s consists of lower-case English letters.
1 <= words.length <= 5000
1 <= words[i].length <= 30
words[i] consists of lower-case English letters.
*/

class Solution {
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        var s = Array(s)
        let ns = s.count

        let len = words[0].count
        let nw = words.count

        if ns < nw*len { return [] }

        var requireWords = [String: Int]()
        for word in words {
            requireWords[word, default: 0] += 1
        }

        var right = 0
        var res = [Int]()
        for i in 0...(ns-len*nw) {
            var finded = [String: Int]()
            var j = 0
            while j < nw {
                let cur = String(s[i+j*len..<(i+(j+1)*len)])
                if let needed = requireWords[cur] {
                    finded[cur, default: 0] += 1
                    if finded[cur]! > needed {
                        break
                    }
                } else {
                    break
                }
                j += 1
            }

            if j == nw {
                res.append(i)
            }
        }
        return res
    }
}