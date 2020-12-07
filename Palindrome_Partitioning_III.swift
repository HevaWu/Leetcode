/*
You are given a string s containing lowercase letters and an integer k. You need to :

First, change some characters of s to other lowercase English letters.
Then divide s into k non-empty disjoint substrings such that each substring is palindrome.
Return the minimal number of characters that you need to change to divide the string.

 

Example 1:

Input: s = "abc", k = 2
Output: 1
Explanation: You can split the string into "ab" and "c", and change 1 character in "ab" to make it palindrome.
Example 2:

Input: s = "aabbc", k = 3
Output: 0
Explanation: You can split the string into "aa", "bb" and "c", all of them are palindrome.
Example 3:

Input: s = "leetcode", k = 8
Output: 0
 

Constraints:

1 <= k <= s.length <= 100.
s only contains lowercase English letters.

Hint 1: For each substring calculate the minimum number of steps to make it palindrome and store it in a table.
Hint 2: Create a dp(pos, cnt) which means the minimum number of characters changed for the suffix of s starting on pos splitting the suffix on cnt chunks.
*/

/* Solution 1: DP
How many changes do I need to perform to make S.substring(i, j) to a palindrome.
How many ways can I split the string from i to j into groups and what are their costs.
What is the minimum combination of these groups.

dp[k][end]
min((aabb)(c), (aab)(bc), (aa)(bbc), (a)(abbc)) = dp[2][4]
or dp[2][4] = Math.min(toPal[0][3] + toPal[4][4], toPal[0][2] + toPal[3][4], toPal[0][1] + toPal[2][4], toPal[0][0] + toPal[1][4])
min((aab)(b), (aa)(bb), (aa)(bb)) = dp[2][3]
or dp[2][3] = Math.min(toPal[0][2] + toPal[3][3], toPal[0][1] + toPal[2][3], toPal[0][0] + toPal[1][3])
min((aa)(b), (a)(ab)) = dp[2][2]
or dp[2][2] = Math.min(toPal[0][1] + toPal[2][2], toPal[0][0] + toPal[1][2])
min((a)(a)) = dp[2][1]
or dp[2][1] = toPal[0][0] + toPal[1][1]

dp[3][5] // this our answer because we want 3rd group to end at index 5
dp[3][5] = Math.min(dp[2][4] + toPal[5][5], dp[2][3] + toPal[4][5], dp[2][2] + toPal[3][5], dp[2][1] + toPal[2][5])

Time Complexity:
O(n^2 + nk)
*/

class Solution {
    func palindromePartition(_ s: String, _ k: Int) -> Int {
        guard s.count > k else { return 0 }
        let n = s.count
        var dp = Array(repeating: Array(repeating: 0, count: n), count: k+1)
        
        // calculate cost of transfer s.substring(i, j) to palindrome
        let s = Array(s)
        let getCost: (Int, Int) -> Int = { i, j in
            var res = 0
            var i = i
            var j = j
            while i < j {
                if s[i] != s[j] {
                    res += 1
                }
                i += 1
                j -= 1
            }
            return res
        }
        
        // cost map cache
        let cost: [[Int]] = {
            var res = Array(repeating: Array(repeating: 0, count: n), count: n)
            for i in 0..<n {
                for j in (i+1)..<n {
                    res[i][j] = getCost(i, j)
                }
            }
            return res
        }()
        
        for j in 0..<n {
            dp[1][j] = cost[0][j]
        }
        
        if k == 1 { return dp[1][n-1] }
        
        for i in 2...k {
            for j in (i-1)..<n {
                var _min = n
                for t in 0..<j {
                    _min = min(_min, dp[i-1][t] + cost[t+1][j])
                }
                dp[i][j] = _min
            }
        }
        return dp[k][n-1]
    }
}

