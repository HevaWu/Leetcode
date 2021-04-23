/*
Give a string s, count the number of non-empty (contiguous) substrings that have the same number of 0's and 1's, and all the 0's and all the 1's in these substrings are grouped consecutively.

Substrings that occur multiple times are counted the number of times they occur.

Example 1:
Input: "00110011"
Output: 6
Explanation: There are 6 substrings that have equal number of consecutive 1's and 0's: "0011", "01", "1100", "10", "0011", and "01".

Notice that some of these substrings repeat and are counted the number of times they occur.

Also, "00110011" is not a valid substring because all the 0's (and 1's) are not grouped together.
Example 2:
Input: "10101"
Output: 4
Explanation: There are 4 substrings: "10", "01", "10", "01" that have equal number of consecutive 1's and 0's.
Note:

s.length will be between 1 and 50,000.
s will only consist of "0" or "1" characters.
*/

/*
Solution 2:

remember only prev = groups[-2] and cur = groups[-1]. Then, the answer is the sum of min(prev, cur) over each different final (prev, cur) we see.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countBinarySubstrings(_ s: String) -> Int {
        var count = 0
        var pre = 0
        var cur = 1
        var s = Array(s)
        for i in 1..<s.count {
            if s[i-1] == s[i] {
                cur += 1
            } else {
                count += min(pre, cur)
                pre = cur
                cur = 1
            }
        }
        // add last one
        return count + min(pre, cur)
    }
}

/*
Solution 1:
iterate s

always memo pre different index, and current number index

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countBinarySubstrings(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var s = Array(s)

        // pre index
        var pre = 0
        var cur = 0

        var count = 0

        var i = 1
        while i < n {
            while i < n, s[i] == s[cur] {
                i += 1
            }

            if pre != cur {
                count += min(cur-pre, i-cur)
                pre = cur
            }
            cur = i
        }
        return count
    }
}