/*
Given two strings s1 and s2, return true if s2 contains a permutation of s1, or false otherwise.

In other words, return true if one of s1's permutations is the substring of s2.



Example 1:

Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").
Example 2:

Input: s1 = "ab", s2 = "eidboaoo"
Output: false


Constraints:

1 <= s1.length, s2.length <= 104
s1 and s2 consist of lowercase English letters.
*/

/*
Solution 2:
Optimize solution 1
when track s2, keep window
then check if window is same as freq

Time Complexity: O(n1 + n2)
Space Complexity: O(26)
*/
class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        var s1arr = Array(repeating: 0, count: 26)
        let asciia = Character("a").asciiValue!
        for c in s1 {
            s1arr[Int(c.asciiValue! - asciia)] += 1
        }

        var s2 = Array(s2)
        var s2arr = Array(repeating: 0, count: 26)
        let size = s1.count
        for i in 0..<s2.count {
            let start = i-size
            s2arr[Int(s2[i].asciiValue! - asciia)] += 1
            if start >= 0 {
                s2arr[Int(s2[start].asciiValue! - asciia)] -= 1
            }

            if s2arr == s1arr {
                  return true
            }
        }
        return false
    }
}

/*
Solution 1:
use freq array to help recording s1's char appearance
then use cur to update current substring window
once find the match substring, return true

Time Complexity: O(n1 + n2^2)
- n1: s1.count
- n2: s2.count
Space Complexity: O(26)
*/
class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let asciia = Character("a").asciiValue!
        var freq = Array(repeating: 0, count: 26)
        for c in s1 {
            freq[Int(c.asciiValue! - asciia)] += 1
        }

        var cur = Array(repeating: 0, count: 26)
        let n = s2.count
        var s2 = Array(s2)
        var s = 0
        for e in 0..<n {
            let index = Int(s2[e].asciiValue! - asciia)
            cur[index] += 1
            if cur[index] > freq[index] {
                // shorten s until make cur[index] == freq[index]
                while s <= e, cur[index] > freq[index] {
                    cur[Int(s2[s].asciiValue! - asciia)] -= 1
                    s += 1
                }
            }
            if cur[index] == freq[index] {
                if cur == freq { return true }
            }
        }
        return false
    }
}
