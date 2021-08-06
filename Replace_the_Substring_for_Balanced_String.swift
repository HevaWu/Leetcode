/*
You are given a string containing only 4 kinds of characters 'Q', 'W', 'E' and 'R'.

A string is said to be balanced if each of its characters appears n/4 times where n is the length of the string.

Return the minimum length of the substring that can be replaced with any other string of the same length to make the original string s balanced.

Return 0 if the string is already balanced.



Example 1:

Input: s = "QWER"
Output: 0
Explanation: s is already balanced.
Example 2:

Input: s = "QQWE"
Output: 1
Explanation: We need to replace a 'Q' to 'R', so that "RQWE" (or "QRWE") is balanced.
Example 3:

Input: s = "QQQW"
Output: 2
Explanation: We can replace the first "QQ" to "ER".
Example 4:

Input: s = "QQQQ"
Output: 3
Explanation: We can replace the last 3 'Q' to make s = "QWER".


Constraints:

1 <= s.length <= 10^5
s.length is a multiple of 4
s contains only 'Q', 'W', 'E' and 'R'.
*/

/*
Solution 1:
sliding window

1. go through string and store all freq for the characters
2. sliding window to see if we can make sure QWER in [0..<left] [right...] is satisfy the rule

Time Complexity: O(n)
Sapce Complexity: O(4)
*/
class Solution {
    func balancedString(_ s: String) -> Int {
        let n = s.count
        var s = Array(s)
        let size = n/4

        var map = [Character: Int]()
        for c in s {
            map[c, default: 0] += 1
        }

        var len = n

        var left = 0
        var right = 0
        while right < n {
            map[s[right], default: 0] -= 1
            while left < n,
            map[Character("Q"), default: 0] <= size,
            map[Character("W"), default: 0] <= size,
            map[Character("E"), default: 0] <= size,
            map[Character("R"), default: 0] <= size {
                len = min(len, right-left+1)
                map[s[left], default: 0] += 1
                left += 1
            }
            right += 1
        }
        return len
    }
}
