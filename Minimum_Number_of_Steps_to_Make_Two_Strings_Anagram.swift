/*
You are given two strings of the same length s and t. In one step you can choose any character of t and replace it with another character.

Return the minimum number of steps to make t an anagram of s.

An Anagram of a string is a string that contains the same characters with a different (or the same) ordering.



Example 1:

Input: s = "bab", t = "aba"
Output: 1
Explanation: Replace the first 'a' in t with b, t = "bba" which is anagram of s.
Example 2:

Input: s = "leetcode", t = "practice"
Output: 5
Explanation: Replace 'p', 'r', 'a', 'i' and 'c' from t with proper characters to make t anagram of s.
Example 3:

Input: s = "anagram", t = "mangaar"
Output: 0
Explanation: "anagram" and "mangaar" are anagrams.


Constraints:

1 <= s.length <= 5 * 104
s.length == t.length
s and t consist of lowercase English letters only.
*/

/*
Solution 1:
build freq array to record each lower case character appearance in s and t
for s, increase the freq, for t, decrease the freq

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minSteps(_ s: String, _ t: String) -> Int {
        let a = Character("a").asciiValue!
        var freq = Array(repeating: 0, count: 26)
        for c in s {
            let index = Int(c.asciiValue! - a)
            freq[index] += 1
        }
        for c in t {
            let index = Int(c.asciiValue! - a)
            freq[index] -= 1
        }
        var steps = 0
        for i in 0..<26 {
            if freq[i] > 0 {
                steps += freq[i]
            }
        }
        return steps
    }
}
