/*
You are given a 0-indexed binary string s and two integers minJump and maxJump. In the beginning, you are standing at index 0, which is equal to '0'. You can move from index i to index j if the following conditions are fulfilled:

i + minJump <= j <= min(i + maxJump, s.length - 1), and
s[j] == '0'.
Return true if you can reach index s.length - 1 in s, or false otherwise.



Example 1:

Input: s = "011010", minJump = 2, maxJump = 3
Output: true
Explanation:
In the first step, move from index 0 to index 3.
In the second step, move from index 3 to index 5.
Example 2:

Input: s = "01101110", minJump = 2, maxJump = 3
Output: false


Constraints:

2 <= s.length <= 105
s[i] is either '0' or '1'.
s[0] == '0'
1 <= minJump <= maxJump < s.length
*/

/*
Solution 2:
use maxPoint to help extend left side bound

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func canReach(_ s: String, _ minJump: Int, _ maxJump: Int) -> Bool {
        var s = Array(s)
        let n = s.count
        if s[n-1] == "1" { return false }

        var canJump = [0]
        var maxPoint = 0
        while !canJump.isEmpty {
            let i = canJump.removeFirst()

            // trick point
            let left = max(i+minJump, maxPoint+1)
            if left < n {
                for j in max(i+minJump, maxPoint+1)...min(i+maxJump, n-1) {
                    if s[j] == "0" {
                        if j == n-1 { return true }
                        canJump.append(j)
                    }
                }

                // trick point
                maxPoint = max(maxPoint, i+maxJump)
            }
        }
        return false
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func canReach(_ s: String, _ minJump: Int, _ maxJump: Int) -> Bool {
        var s = Array(s)
        let n = s.count
        if s[n-1] == "1" { return false }

        // dp[i] can reach to n-1
        var dp = Array(repeating: false, count: n)
        dp[n-1] = true

        for i in stride(from: n-2, through: 0, by: -1) {
            if i+minJump < n {
                for j in (i+minJump)...min(i+maxJump, n-1) where s[j] == "0" {
                    if dp[j] {
                        dp[i] = true
                        break
                    }
                }
            }
        }

        // print(dp)
        return dp[0]
    }
}