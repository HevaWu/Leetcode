/*
There are n people and 40 types of hats labeled from 1 to 40.

Given a list of list of integers hats, where hats[i] is a list of all hats preferred by the i-th person.

Return the number of ways that the n people wear different hats to each other.

Since the answer may be too large, return it modulo 10^9 + 7.



Example 1:

Input: hats = [[3,4],[4,5],[5]]
Output: 1
Explanation: There is only one way to choose hats given the conditions.
First person choose hat 3, Second person choose hat 4 and last one hat 5.
Example 2:

Input: hats = [[3,5,1],[3,5]]
Output: 4
Explanation: There are 4 ways to choose hats
(3,5), (5,3), (1,3) and (1,5)
Example 3:

Input: hats = [[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4]]
Output: 24
Explanation: Each person can choose hats labeled from 1 to 4.
Number of Permutations of (1,2,3,4) = 24.
Example 4:

Input: hats = [[1,2,3],[2,3,5,6],[1,3,7,9],[1,8,9],[2,5,7]]
Output: 111


Constraints:

n == hats.length
1 <= n <= 10
1 <= hats[i].length <= 40
1 <= hats[i][j] <= 40
hats[i] contains a list of unique integers.
*/

/*
Solution 1:
DP + bitmask

n <= 10 is less then number of different hats <= 40. We can assign up to 40 different hats to n people and use dp to calculate number of ways.

Time: O(40 * 2^n * n), where n is the number of people, n <= 10
Explain: There are total hat*assignedPeople = 40*2^n states in dfs(..hat, assignedPeople...) function, each state needs a loop up to n times (int p : h2p[hat]) to calculate the result.
Space: O(40 * 2^n)
*/
class Solution {
    let mod = Int(1e9+7)

    func numberWays(_ hats: [[Int]]) -> Int {

        let n = hats.count

        var h2p = Array(repeating: [Int](), count: 41)
        for i in 0..<n {
            for hat in hats[i] {
                h2p[hat].append(i)
            }
        }

        // dp[i][j] number of ways assign i different hats with j different people
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: 1<<10),
            count: 41
        )

        return check(1, 0, (1<<n)-1, h2p, &dp)
    }

    // mask: all people assigned mask, will be 11111...111
    func check(_ hat: Int, _ visitedPeople: Int, _ mask: Int,
               _ h2p: [[Int]], _ dp: inout [[Int?]]) -> Int {
        // assigned different hat to all people
        if visitedPeople == mask { return 1 }

        // no more hats to process
        if hat > 40 { return 0 }

        if let val = dp[hat][visitedPeople] { return val }

        // not wear the hat
        var val = check(hat+1, visitedPeople, mask, h2p, &dp)
        for p in h2p[hat] {
            // p already assigned
            if (visitedPeople & (1<<p)) != 0 { continue }

            // wear hat for p person
            val = (val + check(hat+1, visitedPeople | (1<<p), mask, h2p, &dp)) % mod
        }

        dp[hat][visitedPeople] = val
        return val
    }
}