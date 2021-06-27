/*
A wonderful string is a string where at most one letter appears an odd number of times.

For example, "ccjjc" and "abab" are wonderful, but "ab" is not.
Given a string word that consists of the first ten lowercase English letters ('a' through 'j'), return the number of wonderful non-empty substrings in word. If the same substring appears multiple times in word, then count each occurrence separately.

A substring is a contiguous sequence of characters in a string.



Example 1:

Input: word = "aba"
Output: 4
Explanation: The four wonderful substrings are underlined below:
- "aba" -> "a"
- "aba" -> "b"
- "aba" -> "a"
- "aba" -> "aba"
Example 2:

Input: word = "aabb"
Output: 9
Explanation: The nine wonderful substrings are underlined below:
- "aabb" -> "a"
- "aabb" -> "aa"
- "aabb" -> "aab"
- "aabb" -> "aabb"
- "aabb" -> "a"
- "aabb" -> "abb"
- "aabb" -> "b"
- "aabb" -> "bb"
- "aabb" -> "b"
Example 3:

Input: word = "he"
Output: 2
Explanation: The two wonderful substrings are underlined below:
- "he" -> "h"
- "he" -> "e"


Constraints:

1 <= word.length <= 105
word consists of lowercase English letters from 'a' to 'j'.
*/

/*
Solution 2:
bitmask

mask && 0 == 1 means odd "a"
mask && 2 == 2 means odd "b"

build mask,
for loop check to add odd char substring

Time Complexity: O(10 n)
Space Complexity: O(1)
*/
class Solution {
    func wonderfulSubstrings(_ word: String) -> Int {
        var mask = 0
        var finded = 0

        var maskCache = Array(repeating: 0, count: 1024)
        maskCache[0] = 1

        let ascii_a = Character("a").asciiValue!
        for c in word {
            mask ^= 1<<Int(c.asciiValue! - ascii_a)
            finded += maskCache[mask]

            // print(mask)
            for i in 0..<10 {
                finded += maskCache[mask ^ (1<<i)]
            }
            maskCache[mask] += 1
        }
        return finded
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func wonderfulSubstrings(_ word: String) -> Int {
        let n = word.count
        var word = Array(word)
        // 00000_00000, if one digit is 1, means char appears odd times
        var mask = 0

        var finded = 0
        var cur = String()

        for i in 0..<n {
            mask = 0
            cur = String()
            check(i, n, word, &cur, &mask, &finded)
        }
        return finded
    }

    let ascii_a = Character("a").asciiValue!
    func check(_ index: Int, _ n: Int, _ word: [Character],
               _ cur: inout String, _ mask: inout Int, _ finded: inout Int) {
        if !cur.isEmpty && (mask == 1 || mask == 0 || (log2(Double(mask)).truncatingRemainder(dividingBy: 1) == 0.0)) {
            // only have 1 odd number
            // print(cur)
            finded += 1
        }

        guard index < n else {
            return
        }

        cur.append(word[index])
        // print("inside", cur)
        mask ^= (1<<Int(word[index].asciiValue! - ascii_a))

        check(index+1, n, word, &cur, &mask, &finded)
    }
}