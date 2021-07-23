/*
Run-length encoding is a string compression method that works by replacing consecutive identical characters (repeated 2 or more times) with the concatenation of the character and the number marking the count of the characters (length of the run). For example, to compress the string "aabccc" we replace "aa" by "a2" and replace "ccc" by "c3". Thus the compressed string becomes "a2bc3".

Notice that in this problem, we are not adding '1' after single characters.

Given a string s and an integer k. You need to delete at most k characters from s such that the run-length encoded version of s has minimum length.

Find the minimum length of the run-length encoded version of s after deleting at most k characters.



Example 1:

Input: s = "aaabcccd", k = 2
Output: 4
Explanation: Compressing s without deleting anything will give us "a3bc3d" of length 6. Deleting any of the characters 'a' or 'c' would at most decrease the length of the compressed string to 5, for instance delete 2 'a' then we will have s = "abcccd" which compressed is abc3d. Therefore, the optimal way is to delete 'b' and 'd', then the compressed version of s will be "a3c3" of length 4.
Example 2:

Input: s = "aabbaa", k = 2
Output: 2
Explanation: If we delete both 'b' characters, the resulting compressed string would be "a4" of length 2.
Example 3:

Input: s = "aaaaaaaaaaa", k = 0
Output: 3
Explanation: Since k is zero, we cannot delete anything. The compressed string is "a11" of length 3.


Constraints:

1 <= s.length <= 100
0 <= k <= s.length
s contains only lowercase English letters.
*/

/*
Solution 1:
backtracking with memorization

record, current index, last char, last char's count, remain can delete count
- s[index] == lastChar
    - combine them, check next (index+1, lastChar, lastCount+1, remain)
    - if lastCount == 1, 9, 99, after +1, the length+1, so "+ (lastCount in [1,9,99] ? 1 : 0)"
- s[index] != lastChar
    - 2 options
    - 1. keep current index char, 1 + (index+1, s[index], 1, remain)
    - 2. remove current index char, (index+1, lastChar, lastCount, remain-1)

Time Complexity: O(n * 26 * n * k)
Space COmplication: O(n * 26 * n * k)
*/
class Solution {
    func getLengthOfOptimalCompression(_ s: String, _ k: Int) -> Int {
        let n = s.count
        var s = Array(s)

        // dp[index][last][lastCount][remain]
        var cache: [[[[Int?]]]] = Array(
            repeating: Array(
                repeating: Array(
                    repeating: Array(
                        repeating: nil,
                        count: k+1
                    ),
                    count: n+1
                ),
                count: 27
            ),
            count: n+1
        )

        return check(s, 0, nil, 0, k, &cache)
    }

    let ascii_a = Character("a").asciiValue!
    var lastCountOverSet = Set([1, 9, 99])
    func check(_ s: [Character],
               _ index: Int, _ last: Character?,
               _ lastCount: Int, _ remain: Int,
               _ cache: inout [[[[Int?]]]]) -> Int {
        if remain < 0 { return s.count+1 }
        if index >= s.count { return 0 }

        let lastIndex = last == nil ? 26 : Int(last!.asciiValue! - ascii_a)
        if let val = cache[index][lastIndex][lastCount][remain] {
            return val
        }

        var val = 0
        if let last = last, s[index] == last {
            val = check(s, index+1, last, lastCount+1, remain, &cache) + (lastCountOverSet.contains(lastCount) ? 1 : 0)
        } else {
            val = min(
                check(s, index+1, s[index], 1, remain, &cache) + 1,
                check(s, index+1, last, lastCount, remain-1, &cache)
            )
        }

        cache[index][lastIndex][lastCount][remain] = val
        return val
    }
}