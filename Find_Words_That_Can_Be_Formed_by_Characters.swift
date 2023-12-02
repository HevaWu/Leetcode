/*
You are given an array of strings words and a string chars.

A string is good if it can be formed by characters from chars (each character can only be used once).

Return the sum of lengths of all good strings in words.



Example 1:

Input: words = ["cat","bt","hat","tree"], chars = "atach"
Output: 6
Explanation: The strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.
Example 2:

Input: words = ["hello","world","leetcode"], chars = "welldonehoneyr"
Output: 10
Explanation: The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.


Constraints:

1 <= words.length <= 1000
1 <= words[i].length, chars.length <= 100
words[i] and chars consist of lowercase English letters.
*/

/*
Solution 1:
build dic for char frequency in chars
then check each word to see if it can be formed with given dic

Time Complexity: O(n + m)
- n: chars.count
- m: largest length of word in words
Space Complexity: O(n)
*/
class Solution {
    func countCharacters(_ words: [String], _ chars: String) -> Int {
        var dic = [Character: Int]()
        for c in chars {
            dic[c, default: 0] += 1
        }

        var res = 0
        for word in words {
            if canForm(word, in: dic) {
                res += word.count
            }
        }
        return res
    }

    func canForm(_ word: String, in dic: [Character: Int]) -> Bool {
        var dic = dic
        for c in word {
            if dic[c, default: 0] > 0 {
                dic[c, default: 0] -= 1
            } else {
                return false
            }
        }
        return true
    }
}
