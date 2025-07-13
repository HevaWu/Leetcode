/*
You are given a 0-indexed integer array players, where players[i] represents the ability of the ith player. You are also given a 0-indexed integer array trainers, where trainers[j] represents the training capacity of the jth trainer.

The ith player can match with the jth trainer if the player's ability is less than or equal to the trainer's training capacity. Additionally, the ith player can be matched with at most one trainer, and the jth trainer can be matched with at most one player.

Return the maximum number of matchings between players and trainers that satisfy these conditions.



Example 1:

Input: players = [4,7,9], trainers = [8,2,5,8]
Output: 2
Explanation:
One of the ways we can form two matchings is as follows:
- players[0] can be matched with trainers[0] since 4 <= 8.
- players[1] can be matched with trainers[3] since 7 <= 8.
It can be proven that 2 is the maximum number of matchings that can be formed.
Example 2:

Input: players = [1,1,1], trainers = [10]
Output: 1
Explanation:
The trainer can be matched with any of the 3 players.
Each player can only be matched with one trainer, so the maximum answer is 1.


Constraints:

1 <= players.length, trainers.length <= 105
1 <= players[i], trainers[j] <= 109
*/

/*
Solution 1:
Sort players and trainers
Binary search trainer, use previous found trainer index at next round search

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func matchPlayersAndTrainers(_ players: [Int], _ trainers: [Int]) -> Int {
        var players = players.sorted()
        var trainers = trainers.sorted()
        var match = 0
        var trainerStartIndex = 0
        for player in players {
            let findedTrainer = matchTrainers(player, &trainers, trainerStartIndex)
            if findedTrainer == -1 {
                // all later players cannot find more larger capacity trainers
                return match
            } else {
                match += 1
                trainerStartIndex = findedTrainer + 1
            }
        }
        return match
    }

    // match trainers, return true if match successfully
    // try the index of matched trainers, if cannot find, return -1
    func matchTrainers(_ player: Int, _ trainers: inout [Int], _ l: Int) -> Int {
        // print(player)
        if trainers.count == 0 || l >= trainers.count { return -1 }
        if trainers.count == 1 && player > trainers[0] {
            return -1
        }

        // binary search find a matched trainers, remove that trainer from trainers array
        var l = l
        var r = trainers.count - 1
        while l < r {
            let mid = l + (r - l) / 2
            // print(mid, l, r)
            if trainers[mid] < player {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        var index = trainers[l] < player ? l+1 : l
        if index < trainers.count, trainers[index] >= player {
            return index
        }

        return -1
    }
}
