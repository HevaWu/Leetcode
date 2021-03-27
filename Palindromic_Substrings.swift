/*
Given a string, your task is to count how many palindromic substrings in this string.

The substrings with different start indexes or end indexes are counted as different substrings even they consist of same characters.

Example 1:

Input: "abc"
Output: 3
Explanation: Three palindromic strings: "a", "b", "c".


Example 2:

Input: "aaa"
Output: 6
Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".


Note:

The input string length won't exceed 1000.

*/

/*
Solution 3:
expand from center

- choose all possible center
  - single character in string is the center for possible odd-length palindromes
  - pair character in string is center for possible even-length palindromes
- for each center, expand as long as we get palindromes

Time Complexity: O(n^2)
Space Complexity: O(1)
*/

class Solution {
    func countSubstrings(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        var s = Array(s)
        let n = s.count

        var count = 0

        for i in 0..<n {
            expandCenter(s, n, i, i, &count)
            expandCenter(s, n, i, i+1, &count)
        }

        return count
    }

    func expandCenter(_ s: [Character], _ n: Int,
                      _ start: Int, _ end: Int,
                      _ count: inout Int) {
        guard start >= 0, end < n, s[start] == s[end] else { return }
        count += 1
        expandCenter(s, n, start-1, end+1, &count)
    }
}

/*
Solution 2:
DP

Idea:
- dp[i][j] = dp[i+1][j-1] && (s[i] == s[j])
- dp base:
  - dp[i][i] = true
  - dp[i][i+1] = (s[i] == s[i+1])

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func countSubstrings(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        var s = Array(s)
        let n = s.count

        // each single char would be a valid palindromic substring
        var count = n

        // dp[i][j] means s[i...j] is palindromic or not
        var dp = Array(repeating: Array(repeating: false, count: n),
                       count: n)

        for i in 0..<n {
            dp[i][i] = true
        }

        for i in 0..<(n-1) {
            dp[i][i+1] = s[i] == s[i+1]
            count += (dp[i][i+1] ? 1 : 0)
        }

        if n <= 2 { return count }

        for len in 3...n {
            var i = 0
            var j = i+len-1
            while j < n {
                dp[i][j] = dp[i+1][j-1] && s[i] == s[j]
                count += (dp[i][j] ? 1 : 0)
                i += 1
                j += 1
            }
        }

        return count
    }
}

/*
Solution 1:
Time Limit Exceeded

brute force
check each i,j pair to see if result is palindrome

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func countSubstrings(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        var s = Array(s)
        let n = s.count

        var checked = [String: Bool]()

        var count = 0
        for i in 0..<n {
            for j in i..<n {
                if isPalindromic(s, i, j, &checked) {
                    count += 1
                }
            }
        }
        return count
    }

    func isPalindromic(_ s: [Character],
                       _ start: Int, _ end: Int,
                       _ checked: inout [String: Bool]) -> Bool {
        let str = String(s[start...end])
        if let val = checked[str] {
            return val
        }

        var start = start
        var end = end
        while start < end {
            if s[start] != s[end] {
                checked[str] = false
                return false
            }
            start += 1
            end -= 1
        }
        checked[str] = true
        return true
    }
}