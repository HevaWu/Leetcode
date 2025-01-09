/*
You are given an array of strings words and a string pref.

Return the number of strings in words that contain pref as a prefix.

A prefix of a string s is any leading contiguous substring of s.



Example 1:

Input: words = ["pay","attention","practice","attend"], pref = "at"
Output: 2
Explanation: The 2 strings that contain "at" as a prefix are: "attention" and "attend".
Example 2:

Input: words = ["leetcode","win","loops","success"], pref = "code"
Output: 0
Explanation: There are no strings that contain "code" as a prefix.


Constraints:

1 <= words.length <= 100
1 <= words[i].length, pref.length <= 100
words[i] and pref consist of lowercase English letters.
*/

/*
Solution 1:
Iterate words and check if the word has prefix "pref"

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func prefixCount(_ words: [String], _ pref: String) -> Int {
        var count = 0
        for word in words {
            if word.hasPrefix(pref) {
                count += 1
            }
        }
        return count
    }
}
