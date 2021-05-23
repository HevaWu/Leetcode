/*
Given a binary string s, return true if the longest contiguous segment of 1s is strictly longer than the longest contiguous segment of 0s in s. Return false otherwise.

For example, in s = "110100010" the longest contiguous segment of 1s has length 2, and the longest contiguous segment of 0s has length 3.
Note that if there are no 0s, then the longest contiguous segment of 0s is considered to have length 0. The same applies if there are no 1s.



Example 1:

Input: s = "1101"
Output: true
Explanation:
The longest contiguous segment of 1s has length 2: "1101"
The longest contiguous segment of 0s has length 1: "1101"
The segment of 1s is longer, so return true.
Example 2:

Input: s = "111000"
Output: false
Explanation:
The longest contiguous segment of 1s has length 3: "111000"
The longest contiguous segment of 0s has length 3: "111000"
The segment of 1s is not longer, so return false.
Example 3:

Input: s = "110100010"
Output: false
Explanation:
The longest contiguous segment of 1s has length 2: "110100010"
The longest contiguous segment of 0s has length 3: "110100010"
The segment of 1s is not longer, so return false.


Constraints:

1 <= s.length <= 100
s[i] is either '0' or '1'.
*/

class Solution {
    func checkZeroOnes(_ s: String) -> Bool {
        var l1 = 0
        var l0 = 0

        var isOne = false
        var cur = 0
        for c in s {
            if c == "0" {
                if isOne {
                    // pre is 1
                    l1 = max(l1, cur)

                    isOne = false
                    cur = 1
                } else {
                    cur += 1
                }
            } else {
                // c == "1"
                if isOne {
                    cur += 1
                } else {
                    // pre is 0
                    l0 = max(l0, cur)

                    isOne = true
                    cur = 1
                }
            }
        }

        if isOne {
            l1 = max(l1, cur)
        } else {
            l0 = max(l0, cur)
        }

        return l1 > l0
    }
}