/*
Given a string s, return the length of the longest substring between two equal characters, excluding the two characters. If there is no such substring return -1.

A substring is a contiguous sequence of characters within a string.



Example 1:

Input: s = "aa"
Output: 0
Explanation: The optimal substring here is an empty substring between the two 'a's.
Example 2:

Input: s = "abca"
Output: 2
Explanation: The optimal substring here is "bc".
Example 3:

Input: s = "cbzxy"
Output: -1
Explanation: There are no characters that appear twice in s.


Constraints:

1 <= s.length <= 300
s contains only lowercase English letters.
*/

/*
Solution 1:
record the characters first appear position

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxLengthBetweenEqualCharacters(_ s: String) -> Int {
        // freq[i], character i first appear position
        var freq = Array(repeating: -1, count: 26)
        var s = Array(s)
        let n = s.count
        let a = Character("a").asciiValue!
        var len = -1
        for i in 0..<n {
            let index = Int(s[i].asciiValue! - a)
            if freq[index] != -1 {
                // exclude the two equal characters
                len = max(len, i-freq[index]-1)
            } else {
                freq[index] = i
            }
        }
        return len
    }
}
