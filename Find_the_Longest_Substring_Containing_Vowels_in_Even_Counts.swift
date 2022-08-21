/*
Given the string s, return the size of the longest substring containing each vowel an even number of times. That is, 'a', 'e', 'i', 'o', and 'u' must appear an even number of times.



Example 1:

Input: s = "eleetminicoworoep"
Output: 13
Explanation: The longest substring is "leetminicowor" which contains two each of the vowels: e, i and o and zero of the vowels: a and u.
Example 2:

Input: s = "leetcodeisgreat"
Output: 5
Explanation: The longest substring is "leetc" which contains two e's.
Example 3:

Input: s = "bcbcbc"
Output: 6
Explanation: In this case, the given string "bcbcbc" is the longest because all vowels: a, e, i, o and u appear zero times.


Constraints:

1 <= s.length <= 5 x 10^5
s contains only lowercase English letters.
*/

/*
Solution 1:
bitmask + dp

represent the vowel appearance by bitmask
00000 means appearance of aeiou
0 means even
1 means odd
every time when add/remove a vowel, use XOR(^) to update the bitmask

to find the longest substring
check the substring from size of n to 1
use dp to help tracking current i..<(i+len) window's substring vowel appearance
dp[i] means i..<(i+len) window appearance

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func findTheLongestSubstring(_ s: String) -> Int {
        let n = s.count
        var s = Array(s)

        // dp[i] the number of vowels for substring i..<(i+len)
        // use bitmask to indicate if vowels are all even
        // 00000 represents aeiou appearance
        // 0 - even, 1 - odd
        var dp = Array(repeating: 0, count: n)

        // build dp[0] for len = n
        for c in s {
            dp[0] = updateVowel(c, dp[0])
        }

        // current string is already hold all vowels as even freq
        if dp[0] == 0 { return n }

        for len in stride(from: n-1, through: 1, by: -1) {
            let temp = dp
            for i in 0...(n-len) {
                if i-1 >= 0 {
                    // can update dp[i][len] from dp[i-1][len+1]
                    // by check s[i-1]
                    dp[i] = updateVowel(s[i-1], temp[i-1])
                } else {
                    // can update dp[i][len] from dp[i][len+1]
                    // by check s[i+len]
                    dp[i] = updateVowel(s[i+len], temp[i])
                }

                if dp[i] == 0 {
                    // all vowel is even freq
                    return len
                }
            }
        }
        return 0
    }

    // check if c is vowel, if it is,
    // update val to update vowel appearance
    // 00000 represents aeiou appearance
    // 0 - even, 1 - odd
    func updateVowel(_ c: Character, _ val: Int) -> Int {
        var val = val
        switch c {
        case "a": val = (1 << 4) ^ val
        case "e": val = (1 << 3) ^ val
        case "i": val = (1 << 2) ^ val
        case "o": val = (1 << 1) ^ val
        case "u": val = (1 << 0) ^ val
        default: break
        }
        return val
    }
}