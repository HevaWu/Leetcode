/*
You are given two strings s and t of the same length and an integer maxCost.

You want to change s to t. Changing the ith character of s to ith character of t costs |s[i] - t[i]| (i.e., the absolute difference between the ASCII values of the characters).

Return the maximum length of a substring of s that can be changed to be the same as the corresponding substring of t with a cost less than or equal to maxCost. If there is no substring from s that can be changed to its corresponding substring from t, return 0.



Example 1:

Input: s = "abcd", t = "bcdf", maxCost = 3
Output: 3
Explanation: "abc" of s can change to "bcd".
That costs 3, so the maximum length is 3.
Example 2:

Input: s = "abcd", t = "cdef", maxCost = 3
Output: 1
Explanation: Each character in s costs 2 to change to character in t,  so the maximum length is 1.
Example 3:

Input: s = "abcd", t = "acde", maxCost = 0
Output: 1
Explanation: You cannot make any change, so the maximum length is 1.


Constraints:

1 <= s.length <= 105
t.length == s.length
0 <= maxCost <= 106
s and t consist of only lowercase English letters.
*/

/*
Solution 1:
sliding window

use maxCost to keep window's length
each step, extend r pointer
when notice maxCost < 0, extend l pointer

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func equalSubstring(_ s: String, _ t: String, _ maxCost: Int) -> Int {
        let asciia = Character("a").asciiValue!
        var s = Array(s)
        var t = Array(t)
        let n = s.count

        var maxCost = maxCost
        var l = 0
        var r = 0
        while r < n {
            let rval = abs(
                Int(s[r].asciiValue! - asciia)
                - Int(t[r].asciiValue! - asciia)
            )
            maxCost -= rval
            if maxCost < 0 {
                let lval = abs(
                    Int(s[l].asciiValue! - asciia)
                    - Int(t[l].asciiValue! - asciia)
                )
                maxCost += lval
                l += 1
            }
            r += 1
        }
        return r-l
    }
}

/*
Solution 1:
slide window
TLE

use cost[i][j] to help record the cost from s[i...j] to t[i...j]

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func equalSubstring(_ s: String, _ t: String, _ maxCost: Int) -> Int {
        let asciia = Character("a").asciiValue!
        let n = s.count
        if n == 1 {
            let val = abs(
                Int(s.first!.asciiValue! - asciia)
                - Int(t.first!.asciiValue! - asciia)
            )
            return val <= maxCost ? 1 : 0
        }

        var s = Array(s)
        var t = Array(t)

        // cost[i][j] means the cost from s[i...j] to t[i...j]
        var cost = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in 0..<n {
            let val = abs(
                Int(s[i].asciiValue! - asciia)
                - Int(t[i].asciiValue! - asciia)
            )
            cost[i][i] = val

            // try to record the largest window's value
            cost[0][n-1] += val
        }

        if cost[0][n-1] <= maxCost { return n }

        // slid window from largest to 0,
        // to find the max length substring
        for len in stride(from: n-1, through: 1, by: -1) {
            for i in 0...(n-len) {
                let j = i + len - 1
                if j+1 < n, cost[i][j+1] != 0 {
                    cost[i][j] = cost[i][j+1] - cost[j+1][j+1]
                } else {
                    cost[i][j] = cost[i-1][j] - cost[i-1][i-1]
                }

                // print(cost, cost[i][j])
                if cost[i][j] <= maxCost {
                    return len
                }
            }
        }
        return 0
    }
}