/*
Given a string s, return the number of unique palindromes of length three that are a subsequence of s.

Note that even if there are multiple ways to obtain the same subsequence, it is still only counted once.

A palindrome is a string that reads the same forwards and backwards.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

For example, "ace" is a subsequence of "abcde".


Example 1:

Input: s = "aabca"
Output: 3
Explanation: The 3 palindromic subsequences of length 3 are:
- "aba" (subsequence of "aabca")
- "aaa" (subsequence of "aabca")
- "aca" (subsequence of "aabca")
Example 2:

Input: s = "adc"
Output: 0
Explanation: There are no palindromic subsequences of length 3 in "adc".
Example 3:

Input: s = "bbcbaba"
Output: 4
Explanation: The 4 palindromic subsequences of length 3 are:
- "bbb" (subsequence of "bbcbaba")
- "bcb" (subsequence of "bbcbaba")
- "bab" (subsequence of "bbcbaba")
- "aba" (subsequence of "bbcbaba")


Constraints:

3 <= s.length <= 10^5
s consists of only lowercase English letters.

*/

/*
Solution 1:
use total to record whole character frequency first
then iterate s again
this time, use cur to record character frequency which we've already go through with

- use cur, and total to check if we can find a valid palindrome, if we can, insert it into Set

Time Complexity: O(n * 26)
Space Complexity: O(n)
*/
class Solution {
    func countPalindromicSubsequence(_ s: String) -> Int {
        let n = s.count

        var total = [Character: Int]()
        for c in s {
            total[c, default: 0] += 1
        }

        var cur = [Character: Int]()
        var set = Set<String>()
        for c in s {
            for k in total.keys {
                if k != c {
                    if let findedK = cur[k], let sumK = total[k], sumK-findedK > 0 {
                        // can find a palindrome as kck
                        set.insert(String(k)+String(c)+String(k))
                    }
                } else {
                    // > 1 to check if we can find a palindrome as kkk
                    if let findedK = cur[k], let sumK = total[k], sumK-findedK > 1 {
                        set.insert(String(repeating: k, count: 3))
                    }
                }
            }
            cur[c, default: 0] += 1
        }

        return set.count
    }
}