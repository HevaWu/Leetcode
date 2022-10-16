/*
You want to schedule a list of jobs in d days. Jobs are dependent (i.e To work on the ith job, you have to finish all the jobs j where 0 <= j < i).

You have to finish at least one task every day. The difficulty of a job schedule is the sum of difficulties of each day of the d days. The difficulty of a day is the maximum difficulty of a job done on that day.

You are given an integer array jobDifficulty and an integer d. The difficulty of the ith job is jobDifficulty[i].

Return the minimum difficulty of a job schedule. If you cannot find a schedule for the jobs return -1.



Example 1:


Input: jobDifficulty = [6,5,4,3,2,1], d = 2
Output: 7
Explanation: First day you can finish the first 5 jobs, total difficulty = 6.
Second day you can finish the last job, total difficulty = 1.
The difficulty of the schedule = 6 + 1 = 7
Example 2:

Input: jobDifficulty = [9,9,9], d = 4
Output: -1
Explanation: If you finish a job per day you will still have a free day. you cannot find a schedule for the given jobs.
Example 3:

Input: jobDifficulty = [1,1,1], d = 3
Output: 3
Explanation: The schedule is one job per day. total difficulty will be 3.


Constraints:

1 <= jobDifficulty.length <= 300
0 <= jobDifficulty[i] <= 1000
1 <= d <= 10
*/

/*
Solution 1:
DP top-down

dp[i][d] is the minDifficulty for start from i jobs, finish remain all jobDifficulty in d days
base value:
- dp[i][1] is the max difficulty for jobDifficulty[i...]
- dp[n][d] is 0

Time Complexity: O(nd)
Space Complexity: O(nd)
*/
class Solution {
    func minDifficulty(_ jobDifficulty: [Int], _ d: Int) -> Int {
        let n = jobDifficulty.count
        guard n >= d else { return -1 }
        // for ith day, try to pick jobs
        // dp[i][d] start from ith day,
        // with assign remaining jobs in d days
        // the minDifficulty
        var dp: [[Int?]] = Array(
            repeating: Array(
                repeating: nil,
                count: d+1
            ),
            count: n+1
        )
        preprocess(&dp, jobDifficulty, n)
        return check(0, d, &dp, jobDifficulty, n)
    }

    func preprocess(_ dp: inout [[Int?]], _ jobDifficulty: [Int], _ n: Int) {
        // for d == 1,
        // dp[start][1] should be the max value of jobDifficulty[start...]
        var val = 0
        for i in stride(from: n-1, through: 0, by: -1) {
            val = max(val, jobDifficulty[i])
            dp[i][1] = val
        }
    }

    // return minDifficulty for "start" day,
    // assign remaining jobDifficulty in "d" days
    func check(_ start: Int, _ d: Int, _ dp: inout [[Int?]],
            _ jobDifficulty: [Int], _ n: Int
    ) -> Int {
        if let val = dp[start][d] {
            return val
        }
        if start == n { return 0 }

        // count sum of difficulties
        var val = Int.max
        // current day's difficulty
        var cur = 0
        for i in start...(n-d) {
            // assign start...i jobs to current day
            cur = max(cur, jobDifficulty[i])
            val = min(val, cur + check(i+1, d-1, &dp, jobDifficulty, n))
        }
        dp[start][d] = val
        return val
    }
}
