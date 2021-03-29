/*
Given a string s, partition s such that every substring of the partition is a palindrome.

Return the minimum cuts needed for a palindrome partitioning of s.



Example 1:

Input: s = "aab"
Output: 1
Explanation: The palindrome partitioning ["aa","b"] could be produced using 1 cut.
Example 2:

Input: s = "a"
Output: 0
Example 3:

Input: s = "ab"
Output: 1


Constraints:

1 <= s.length <= 2000
s consists of lower-case English letters only.
*/

/*
Solution 1:
DP

expand from center
decide mid, then see if we can min cut count

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func minCut(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var s = Array(s)

        // dp[i] min cuts until i
        var dp = Array(0..<n)

        for mid in 1..<n {
            // odd len, center is [mid]
            var left = mid
            var right = mid
            while left >= 0, right < n, s[left] == s[right] {
                dp[right] = min(
                    dp[right],
                    left > 0 ? dp[left-1] + 1 : 0
                )
                left -= 1
                right += 1
            }

            // even len, center is [mid-1, mid]
            left = mid-1
            right = mid
            while left >= 0, right < n, s[left] == s[right] {
                dp[right] = min(
                    dp[right],
                    left > 0 ? dp[left-1] + 1 : 0
                )
                left -= 1
                right += 1
            }
        }

        return dp[n-1]
    }
}