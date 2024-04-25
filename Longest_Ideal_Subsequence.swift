/*
You are given a string s consisting of lowercase letters and an integer k. We call a string t ideal if the following conditions are satisfied:

t is a subsequence of the string s.
The absolute difference in the alphabet order of every two adjacent letters in t is less than or equal to k.
Return the length of the longest ideal string.

A subsequence is a string that can be derived from another string by deleting some or no characters without changing the order of the remaining characters.

Note that the alphabet order is not cyclic. For example, the absolute difference in the alphabet order of 'a' and 'z' is 25, not 1.



Example 1:

Input: s = "acfgbd", k = 2
Output: 4
Explanation: The longest ideal string is "acbd". The length of this string is 4, so 4 is returned.
Note that "acfgbd" is not ideal because 'c' and 'f' have a difference of 3 in alphabet order.
Example 2:

Input: s = "abcd", k = 3
Output: 4
Explanation: The longest ideal string is "abcd". The length of this string is 4, so 4 is returned.


Constraints:

1 <= s.length <= 105
0 <= k <= 25
s consists of lowercase English letters.
*/

/*
Solution 2:
dp[i] is longest ideal substring end with char i

Time Complexity: O(n*k)
Space Complexity: O(1)
*/
class Solution {
    func longestIdealString(_ s: String, _ k: Int) -> Int {
        let a = Character("a").asciiValue!
        var s = Array(s)
        let n = s.count
        if n == 1 { return 1 }
        // dp[i] is longest ideal substring end with s[i]
        var dp = Array(repeating: 0, count: 27)

        for i in stride(from: n-1, through: 0, by: -1) {
            let index = Int(s[i].asciiValue! - a)
            for j in max(0, index-k)...min(index+k, 26) {
                dp[index] = max(dp[index], dp[j])
            }
            dp[index] += 1
            // print(dp)
        }
        var longest = 1
        for i in 0...26 {
            longest = max(longest, dp[i])
        }
        return longest
    }
}

/*
Solution 1:
TLE
dp[i] is longest ideal substring end with s[i]

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func longestIdealString(_ s: String, _ k: Int) -> Int {
        let a = Character("a").asciiValue!
        var s = Array(s)
        let n = s.count
        if n == 1 { return 1 }
        // dp[i] is longest ideal substring end with s[i]
        var dp = Array(repeating: 1, count: n)
        var longest = 1
        for i in 1..<n {
            let e = Int(s[i].asciiValue! - a)
            for j in 0..<i {
                let s = Int(s[j].asciiValue! - a)
                if abs(s-e) <= k {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
            longest = max(longest, dp[i])
        }
        return longest
    }
}
