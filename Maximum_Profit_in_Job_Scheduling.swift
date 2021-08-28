/*
We have n jobs, where every job is scheduled to be done from startTime[i] to endTime[i], obtaining a profit of profit[i].

You're given the startTime, endTime and profit arrays, return the maximum profit you can take such that there are no two jobs in the subset with overlapping time range.

If you choose a job that ends at time X you will be able to start another job that starts at time X.



Example 1:



Input: startTime = [1,2,3,3], endTime = [3,4,5,6], profit = [50,10,40,70]
Output: 120
Explanation: The subset chosen is the first and fourth job.
Time range [1-3]+[3-6] , we get profit of 120 = 50 + 70.
Example 2:



Input: startTime = [1,2,3,4,6], endTime = [3,5,10,6,9], profit = [20,20,100,70,60]
Output: 150
Explanation: The subset chosen is the first, fourth and fifth job.
Profit obtained 150 = 20 + 70 + 60.
Example 3:



Input: startTime = [1,1,1], endTime = [2,3,4], profit = [5,6,4]
Output: 6


Constraints:

1 <= startTime.length == endTime.length == profit.length <= 5 * 104
1 <= startTime[i] < endTime[i] <= 109
1 <= profit[i] <= 104
*/

/*
Solution 1:
DP + binary search

1. sort by start time
2. dp[i], maxProfit for job[i...]
3. update dp[i]
-> base dp[n-1] = job[n-1][2]
-> dp[i] = max(dp[index]+job[i][2], max(dp[(i+1)..<index)]))

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func jobScheduling(_ startTime: [Int], _ endTime: [Int], _ profit: [Int]) -> Int {
        let n = startTime.count
        if n == 1 { return profit[0] }

        var job = Array(repeating: [Int](), count: n)
        for i in 0..<n {
            job[i] = [startTime[i], endTime[i], profit[i]]
        }

        // sort by startTime
        job.sort(by: { first, second -> Bool in
            return first[0] < second[0]
        })

        // dp[i] is maxProfit for job[i...]
        var dp = Array(repeating: 0, count: n)
        dp[n-1] = job[n-1][2]

        for i in stride(from: n-2, through: 0, by: -1) {

            // find later job which start >= job[i].endTIme
            let index = getIndex(i, n, job)

            // init ith profit as dp[index]
            dp[i] = job[i][2] + (index == n ? 0 : dp[index])

            // for element in (i+1)..<index, these object are overlapping with i object,
            // pick maxProfit between them
            for j in (i+1)..<index {
                dp[i] = max(dp[i], dp[j])
            }
        }
        return dp[0]
    }

    func getIndex(_ i: Int, _ n: Int, _ job: [[Int]]) -> Int {
        var left = i+1
        var right = n-1
        while left < right {
            let mid = left + (right-left)/2
            if job[mid][0] < job[i][1] {
                left = mid+1
            } else {
                right = mid
            }
        }

        return job[left][0] < job[i][1] ? left+1 : left
    }
}