/*
Return the lexicographically smallest subsequence of s that contains all the distinct characters of s exactly once.

Note: This question is the same as 316: https://leetcode.com/problems/remove-duplicate-letters/



Example 1:

Input: s = "bcabc"
Output: "abc"
Example 2:

Input: s = "cbacdcbc"
Output: "acdb"


Constraints:

1 <= s.length <= 1000
s consists of lowercase English letters.

*/

/*
Solution 1:

Find the index of last occurrence for each character.
Use a stack to keep the characters for result.
Loop on each character in the input string S,
if the current character is smaller than the last character in the stack,
and the last character exists in the following stream,
we can pop the last character to get a smaller result.

Time Complexity:O(N)
Space Complexity: O(26)
*/
class Solution {
    func smallestSubsequence(_ s: String) -> String {
        let ascii_a = Character("a").asciiValue!
        var s = Array(s)

        // last[i], ith char last position in s
        var last = Array(repeating: -1, count: 26)
        for i in 0..<s.count {
            last[Int(s[i].asciiValue! - ascii_a)] = i
        }

        // index array
        var stack = [Int]()
        var visited = Array(repeating: 0, count: 26)
        for i in 0..<s.count {
            let c = Int(s[i].asciiValue! - ascii_a)
            if visited[c] > 0 { continue }
            visited[c] += 1
            while !stack.isEmpty, stack.last! > c, i < last[stack.last!] {
                // remove last char and clear it as
                visited[stack.removeLast()] = 0
            }
            stack.append(c)
        }

        var str = String()
        for i in stack {
            str.append(String(UnicodeScalar(Int(ascii_a) + i)!))
        }
        return str
    }
}