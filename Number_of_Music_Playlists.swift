/*
Your music player contains n different songs and she wants to listen to goal (not necessarily different) songs during your trip.  You create a playlist so that:

Every song is played at least once
A song can only be played again only if k other songs have been played
Return the number of possible playlists.  As the answer can be very large, return it modulo 109 + 7.



Example 1:

Input: n = 3, goal = 3, k = 1
Output: 6
Explanation: There are 6 possible playlists. [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1].
Example 2:

Input: n = 2, goal = 3, k = 0
Output: 6
Explanation: There are 6 possible playlists. [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2, 1], [2, 1, 2], [1, 2, 2]
Example 3:

Input: n = 2, goal = 3, k = 1
Output: 2
Explanation: There are 2 possible playlists. [1, 2, 1], [2, 1, 2]


Note:

0 <= k < n <= goal <= 100

*/

/*
Solution 1:
DP

let dp[i][j] be the number of playlists of length i that have exactly j unique songs. We want dp[L][N], and it seems likely we can develop a recurrence for dp.

Consider dp[i][j]. Last song, we either played a song for the first time or we didn't.
- If we did, then we had dp[i - 1][j - 1] * (N - j + 1) ways to choose it.
- If we didn't, then we repeated a previous song in dp[i-1][j] * max(j-K, 0) ways (j of them, except the last K ones played are banned.)

Time Complexity: O(goal * n)
Space Complexity: O(goal * n)
*/
class Solution {
    func numMusicPlaylists(_ n: Int, _ goal: Int, _ k: Int) -> Int {
        let mod = Int(1e9 + 7)

        // dp[i][j], i length playlists that have j unique songs
        var dp = Array(
            repeating: Array(repeating: 0, count: n+1),
            count: goal+1
        )

        dp[0][0] = 1

        for i in 1...goal {
            for j in 1...n {
                dp[i][j] = (dp[i-1][j-1] * (n-(j-1)) + dp[i-1][j] * max(j-k, 0)) % mod
            }
        }
        return dp[goal][n]
    }
}