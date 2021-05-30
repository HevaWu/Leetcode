/*
5754. Substrings of Size Three with Distinct Characters
User Accepted:0
User Tried:0
Total Accepted:0
Total Submissions:0
Difficulty:Easy
A string is good if there are no repeated characters.

Given a string s​​​​​, return the number of good substrings of length three in s​​​​​​.

Note that if there are multiple occurrences of the same substring, every occurrence should be counted.

A substring is a contiguous sequence of characters in a string.



Example 1:

Input: s = "xyzzaz"
Output: 1
Explanation: There are 4 substrings of size 3: "xyz", "yzz", "zza", and "zaz".
The only good substring of length 3 is "xyz".
Example 2:

Input: s = "aababcabc"
Output: 4
Explanation: There are 7 substrings of size 3: "aab", "aba", "bab", "abc", "bca", "cab", and "abc".
The good substrings are "abc", "bca", "cab", and "abc".


Constraints:

1 <= s.length <= 100
s​​​​​​ consists of lowercase English letters.
*/

class Solution {
    func countGoodSubstrings(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var s = Array(s)
        var count = 0
        var cur = [Character: Int]()
        var key = 0

        for i in 0..<n {
            let c = s[i]
            if cur[c] == nil || cur[c] == 0 {
                key += 1
            }
            cur[c, default: 0] += 1

            if i >= 3 {
                let pre = s[i-3]
                if let val = cur[pre] {
                    if val == 1 {
                        key -= 1
                    }
                    cur[pre] = val-1
                }
            }

            if key == 3 {
                count += 1
            }
        }
        return count
    }
}