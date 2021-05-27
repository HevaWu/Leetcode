/*
Given a string array words, return the maximum value of length(word[i]) * length(word[j]) where the two words do not share common letters. If no such two words exist, return 0.



Example 1:

Input: words = ["abcw","baz","foo","bar","xtfn","abcdef"]
Output: 16
Explanation: The two words can be "abcw", "xtfn".
Example 2:

Input: words = ["a","ab","abc","d","cd","bcd","abcd"]
Output: 4
Explanation: The two words can be "ab", "cd".
Example 3:

Input: words = ["a","aa","aaa","aaaa"]
Output: 0
Explanation: No such pair of words.


Constraints:

2 <= words.length <= 1000
1 <= words[i].length <= 1000
words[i] consists only of lowercase English letters.
*/

/*
Solution 1:
- sort words by descending size
- record which char appears by using occur[i] |= 1 << Int(c.asciiValue! - ascii_a)
- iterate words, check if we can extend res

Time Complexity: O(nlogn + nm + n*n)
Space Complexity: O(n+26)
*/
class Solution {
    func maxProduct(_ words: [String]) -> Int {
        var words = words.sorted(by: { first, second -> Bool in
            return first.count > second.count
        })
        let n = words.count
        let ascii_a = Character("a").asciiValue!

        var occur = Array(repeating: 0, count: n)

        for i in 0..<n {
            for c in words[i] {
                occur[i] |= 1 << Int(c.asciiValue! - ascii_a)
            }
        }

        var res = 0
        for i in 0..<n {
            if words[i].count * words[i].count <= res { break }

            if i+1 < n {
                for j in i+1..<n {
                    if occur[i] & occur[j] == 0 {
                        // we sort array by descending size order,
                        // once finded, don't need to check remaining
                        res = max(res, words[i].count * words[j].count)
                        break
                    }
                }
            }
        }
        return res
    }
}