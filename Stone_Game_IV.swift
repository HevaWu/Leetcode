/*
Alice and Bob take turns playing a game, with Alice starting first.

Initially, there are n stones in a pile. On each player's turn, that player makes a move consisting of removing any non-zero square number of stones in the pile.

Also, if a player cannot make a move, he/she loses the game.

Given a positive integer n, return true if and only if Alice wins the game otherwise return false, assuming both players play optimally.



Example 1:

Input: n = 1
Output: true
Explanation: Alice can remove 1 stone winning the game because Bob doesn't have any moves.
Example 2:

Input: n = 2
Output: false
Explanation: Alice can only remove 1 stone, after that Bob removes the last one winning the game (2 -> 1 -> 0).
Example 3:

Input: n = 4
Output: true
Explanation: n is already a perfect square, Alice can win with one move, removing 4 stones (4 -> 0).


Constraints:

1 <= n <= 105

*/

/*
Solution 2:
DP
think in the backtrack way. If we have a state i that we know the current player must lose, what can we infer?

-- Any other states that can go to i must be True.

Let's say in another state j the current player in j can go to i by removing stones. In this case, the state j is True since the current player must win.

How to find all the state j? Well, we can iterate over the square numbers and add them to i.

Time Complexity:O(N * (root of N))
Space Complexity: O(root of N)
*/
class Solution {
    func winnerSquareGame(_ n: Int) -> Bool {
        var dp = Array(repeating: false, count: n+1)
        dp[1] = true

        if n <= 1 { return dp[n] }

        for i in 2...n {

            var j = 1
            while i-j*j >= 0 {
                if !dp[i-j*j] {
                    dp[i] = true
                    break
                }
                j += 1
            }
        }
        return dp[n]
    }
}

/*
Solution 1:
DFS with memoization

Time Complexity:O(N * (root of N))
Space Complexity: O(root of N)
*/
class Solution {
    func winnerSquareGame(_ n: Int) -> Bool {
        var map = [Int: Bool]()
        map[0] = false
        map[1] = true

        return dfs(n, &map)
    }

    func dfs(_ n: Int, _ map: inout [Int: Bool]) -> Bool {
        if let exist = map[n] {
            return exist
        }

        var i = 1
        var result = false
        while n - i*i >= 0 {
            if !dfs(n-i*i, &map) {
                result = true
                break
            }
            i += 1
        }
        map[n] = result
        return result
    }
}