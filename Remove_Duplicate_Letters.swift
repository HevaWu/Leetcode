/*
Given a string s, remove duplicate letters so that every letter appears once and only once. You must make sure your result is
the smallest in lexicographical order
 among all possible results.



Example 1:

Input: s = "bcabc"
Output: "abc"
Example 2:

Input: s = "cbacdcbc"
Output: "acdb"


Constraints:

1 <= s.length <= 104
s consists of lowercase English letters.

*/

/*
Solution 1:
recursively do this function
1. record the repeat times of each character
2. find the position for the smallest s[i]
3. current s.pos + the remainning string replace all the current s.pos

Time Complexity: O(26n)
Space Complexity: O(26n)
*/
class Solution {
    func removeDuplicateLetters(_ s: String) -> String {
        if s.count == 0 { return "" }
        var arr = Array(repeating: 0, count: 26)
        let a = Character("a").asciiValue!
        for c in s {
            arr[Int(c.asciiValue! - a)] += 1
        }

        var pos = 0
        var s = Array(s)
        for i in 0..<s.count {
            if s[i] < s[pos] {
                pos = i
            }
            arr[Int(s[i].asciiValue! - a)] -= 1
            if arr[Int(s[i].asciiValue! - a)] == 0 { break }
        }

        var res = [Character]()
        if (pos+1) < s.count {
            for i in (pos+1)..<s.count {
                if s[i] != s[pos] {
                    res.append(s[i])
                }
            }
            // print(res)
        }
        return String(s[pos]) + removeDuplicateLetters(String(res))
    }
}
