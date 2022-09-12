/*
You have an initial power of power, an initial score of 0, and a bag of tokens where tokens[i] is the value of the ith token (0-indexed).

Your goal is to maximize your total score by potentially playing each token in one of two ways:

If your current power is at least tokens[i], you may play the ith token face up, losing tokens[i] power and gaining 1 score.
If your current score is at least 1, you may play the ith token face down, gaining tokens[i] power and losing 1 score.
Each token may be played at most once and in any order. You do not have to play all the tokens.

Return the largest possible score you can achieve after playing any number of tokens.



Example 1:

Input: tokens = [100], power = 50
Output: 0
Explanation: Playing the only token in the bag is impossible because you either have too little power or too little score.
Example 2:

Input: tokens = [100,200], power = 150
Output: 1
Explanation: Play the 0th token (100) face up, your power becomes 50 and score becomes 1.
There is no need to play the 1st token since you cannot play it face up to add to your score.
Example 3:

Input: tokens = [100,200,300,400], power = 200
Output: 2
Explanation: Play the tokens in this order to get a score of 2:
1. Play the 0th token (100) face up, your power becomes 100 and score becomes 1.
2. Play the 3rd token (400) face down, your power becomes 500 and score becomes 0.
3. Play the 1st token (200) face up, your power becomes 300 and score becomes 1.
4. Play the 2nd token (300) face up, your power becomes 0 and score becomes 2.


Constraints:

0 <= tokens.length <= 1000
0 <= tokens[i], power < 104
*/

/*
Solution 1:
Greedy

We don't need to play anything until absolutely necessary. Let's play tokens face up until we can't, then play a token face down and continue.

We must be careful, as it is easy for our implementation to be incorrect if we do not handle corner cases correctly. We should always play tokens face up until exhaustion, then play one token face down and continue.

Our loop must be constructed with the right termination condition: we can either play a token face up or face down.

Our final answer could be any of the intermediate answers we got after playing tokens face up (but before playing them face down.)

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func bagOfTokensScore(_ tokens: [Int], _ power: Int) -> Int {
        var tokens = tokens.sorted()
        var l = 0
        var r = tokens.count-1

        // check current power
        var power = power
        // check current points
        var points = 0

        // record max points
        var score = 0

        while l <= r
        && (power >= tokens[l] || points > 0) {
            while l <= r, power >= tokens[l] {
                power -= tokens[l]
                l += 1
                points += 1
            }

            score = max(score, points)
            if l <= r, points > 0 {
                power += tokens[r]
                r -= 1
                points -= 1
            }
        }

        return score
    }
}
