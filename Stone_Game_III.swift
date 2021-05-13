/*
Alice and Bob continue their games with piles of stones. There are several stones arranged in a row, and each stone has an associated value which is an integer given in the array stoneValue.

Alice and Bob take turns, with Alice starting first. On each player's turn, that player can take 1, 2 or 3 stones from the first remaining stones in the row.

The score of each player is the sum of values of the stones taken. The score of each player is 0 initially.

The objective of the game is to end with the highest score, and the winner is the player with the highest score and there could be a tie. The game continues until all the stones have been taken.

Assume Alice and Bob play optimally.

Return "Alice" if Alice will win, "Bob" if Bob will win or "Tie" if they end the game with the same score.



Example 1:

Input: values = [1,2,3,7]
Output: "Bob"
Explanation: Alice will always lose. Her best move will be to take three piles and the score become 6. Now the score of Bob is 7 and Bob wins.
Example 2:

Input: values = [1,2,3,-9]
Output: "Alice"
Explanation: Alice must choose all the three piles at the first move to win and leave Bob with negative score.
If Alice chooses one pile her score will be 1 and the next move Bob's score becomes 5. The next move Alice will take the pile with value = -9 and lose.
If Alice chooses two piles her score will be 3 and the next move Bob's score becomes 3. The next move Alice will take the pile with value = -9 and also lose.
Remember that both play optimally so here Alice will choose the scenario that makes her win.
Example 3:

Input: values = [1,2,3,6]
Output: "Tie"
Explanation: Alice cannot win this game. She can end the game in a draw if she decided to choose all the first three piles, otherwise she will lose.
Example 4:

Input: values = [1,2,3,-1,-2,-3,7]
Output: "Alice"
Example 5:

Input: values = [-1,-2,-3]
Output: "Tie"


Constraints:

1 <= values.length <= 50000
-1000 <= values[i] <= 1000
*/


/*
Solution 2:
DP

constant dp array space
we only need pre 3 value
*/
class Solution {
    func stoneGameIII(_ stoneValue: [Int]) -> String {
        let n = stoneValue.count

        var dp = Array(repeating: 0, count: 4)

        for i in stride(from: n-1, through: 0, by: -1) {
            var take = 0
            dp[i % 4] = Int.min
            for k in i...min(i+2, n-1) {
                take += stoneValue[k]
                dp[i % 4] = max(dp[i % 4], take - dp[(k+1) % 4])
            }
        }

        return dp[0] == 0 ? "Tie" : (dp[0] > 0 ? "Alice" : "Bob")
    }
}

/*
Solution 1:
DP

dp[i] Alice win from stoneValue[i...]
dp[n] = 0, 2 players tie

Alice has 3 options to win
- take stoneValue[i], win take-dp[i+1]
- take stoneValue[i]+stoneValue[i+1], win take-dp[i+2]
- take stoneValue[i]+stoneValue[i+1]+stoneValue[i+2], win take-dp[i+3]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func stoneGameIII(_ stoneValue: [Int]) -> String {
        let n = stoneValue.count
        // stoneValue[i...], highest score Alice win Bob
        var dp = Array(repeating: Int.min, count: n+1)
        dp[n] = 0

        for i in stride(from: n-1, through: 0, by: -1) {
            var take = 0
            for k in i...min(i+2, n-1) {
                take += stoneValue[k]
                dp[i] = max(dp[i], take - dp[k+1])
            }
        }

        return dp[0] == 0 ? "Tie" : (dp[0] > 0 ? "Alice" : "Bob")
    }
}