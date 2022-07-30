/*
You are the manager of a basketball team. For the upcoming tournament, you want to choose the team with the highest overall score. The score of the team is the sum of scores of all the players in the team.

However, the basketball team is not allowed to have conflicts. A conflict exists if a younger player has a strictly higher score than an older player. A conflict does not occur between players of the same age.

Given two lists, scores and ages, where each scores[i] and ages[i] represents the score and age of the ith player, respectively, return the highest overall score of all possible basketball teams.



Example 1:

Input: scores = [1,3,5,10,15], ages = [1,2,3,4,5]
Output: 34
Explanation: You can choose all the players.
Example 2:

Input: scores = [4,5,6,5], ages = [2,1,2,1]
Output: 16
Explanation: It is best to choose the last 3 players. Notice that you are allowed to choose multiple people of the same age.
Example 3:

Input: scores = [1,2,3,5], ages = [8,9,10,1]
Output: 6
Explanation: It is best to choose the first 3 players.


Constraints:

1 <= scores.length, ages.length <= 1000
scores.length == ages.length
1 <= scores[i] <= 106
1 <= ages[i] <= 1000
*/

/*
Solution 1:
bottom up DP

1. combine age and score into player 2D array, [(age, score)]
2. sort player by increasing age, increasing score
3. dp[i] indicate the highest score with ith player as first member
- for i in (n-1 through 0)
  - try to update it by checking later dp[j]
  - use temp to help record later remaining member's score
  - for j in (i through n-1)
    - if i, j has same age, or i has lower age and i's score <= j's score
    - update temp with highest dp[j]
  - temp += i's score
  - update highest

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func bestTeamScore(_ scores: [Int], _ ages: [Int]) -> Int {
        let n = scores.count

        var player = [(age: Int, score: Int)]()
        for i in 0..<n {
            player.append((ages[i], scores[i]))
        }


        player.sort(by: { p1, p2 -> Bool in
            return p1.age == p2.age
                         ? p1.score < p2.score
                         : p1.age < p2.age
        })

        // dp[i] means the higheset score with
        // ith player as first member
        var dp = Array(repeating: 0, count: n)
        var highest = 0
        for i in stride(from: n-1, through: 0, by: -1) {
            // help checking the remaining member's highest score
            var temp = 0
            for j in i..<n {
                if (player[j].age == player[i].age)
                || (player[j].age > player[i].age
                    && player[j].score >= player[i].score){
                    temp = max(temp, dp[j])
                }
            }
            temp += player[i].score
            dp[i] = temp
            highest = max(highest, temp)
        }
        return highest
    }
}