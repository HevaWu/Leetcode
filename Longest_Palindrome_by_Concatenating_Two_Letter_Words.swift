/*
You are given an array of strings words. Each element of words consists of two lowercase English letters.

Create the longest possible palindrome by selecting some elements from words and concatenating them in any order. Each element can be selected at most once.

Return the length of the longest palindrome that you can create. If it is impossible to create any palindrome, return 0.

A palindrome is a string that reads the same forward and backward.



Example 1:

Input: words = ["lc","cl","gg"]
Output: 6
Explanation: One longest palindrome is "lc" + "gg" + "cl" = "lcggcl", of length 6.
Note that "clgglc" is another longest palindrome that can be created.
Example 2:

Input: words = ["ab","ty","yt","lc","cl","ab"]
Output: 8
Explanation: One longest palindrome is "ty" + "lc" + "cl" + "yt" = "tylcclyt", of length 8.
Note that "lcyttycl" is another longest palindrome that can be created.
Example 3:

Input: words = ["cc","ll","xx"]
Output: 2
Explanation: One longest palindrome is "cc", of length 2.
Note that "ll" is another longest palindrome that can be created, and so is "xx".


Constraints:

1 <= words.length <= 105
words[i].length == 2
words[i] consists of lowercase English letters.
*/


/*
Solution 1:
build frequency map then use it to build palindrome string

each word length is 2
only have 2 possibilities, two letters are same, OR two letters are different
if two letters are same, it can be put in middle of palindrome, or if there is multiple word, can put in left and right of palindrome
if two letters are different, if can find its reverse string in words, can put it and its reverse in left and right of palindrome

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func longestPalindrome(_ words: [String]) -> Int {
        var len = 0
        var freq = [String: Int]()
        for word in words {
            freq[word, default: 0] += 1
        }

        let keyList = freq.keys
        var findMidWord = false
        for key in keyList {
            if let val = freq[key] {
                // check if the reverse of key exist or not
                // if exit, can build palindrom by key, keyReverse
                let keyReverse = String(key.reversed())
                if key != keyReverse,
                 let valReverse = freq[keyReverse] {
                    let pick = min(val, valReverse)
                    guard pick >= 1 else { continue }
                    // 2 len words * 2 string(reverse and normal)
                    len += pick * 4
                    freq[key] = pick == val ? nil : val-pick
                    freq[keyReverse] = pick == valReverse ? nil : valReverse - pick
                } else if key == keyReverse {
                    let pick = val / 2
                    guard pick >= 1 else {
                        if val == 1 { findMidWord = true }
                        continue
                    }

                    len += pick * 4
                    freq[key] = val == (pick*2) ? nil : val-(pick*2)
                    if freq[key] != nil { findMidWord = true }
                }
            }
        }

        // find same char words which can be put in the middle of palindrome
        if findMidWord { len += 2 }
        return len
    }
}
