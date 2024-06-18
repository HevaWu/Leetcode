/*
You have n jobs and m workers. You are given three arrays: difficulty, profit, and worker where:

difficulty[i] and profit[i] are the difficulty and the profit of the ith job, and
worker[j] is the ability of jth worker (i.e., the jth worker can only complete a job with difficulty at most worker[j]).
Every worker can be assigned at most one job, but one job can be completed multiple times.

For example, if three workers attempt the same job that pays $1, then the total profit will be $3. If a worker cannot complete any job, their profit is $0.
Return the maximum profit we can achieve after assigning the workers to the jobs.



Example 1:

Input: difficulty = [2,4,6,8,10], profit = [10,20,30,40,50], worker = [4,5,6,7]
Output: 100
Explanation: Workers are assigned jobs of difficulty [4,4,6,6] and they get a profit of [20,20,30,30] separately.
Example 2:

Input: difficulty = [85,47,57], profit = [24,66,99], worker = [40,25,25]
Output: 0


Constraints:

n == difficulty.length
n == profit.length
m == worker.length
1 <= n, m <= 104
1 <= difficulty[i], profit[i], worker[i] <= 105
*/

/*
Solution 1:
- combine jobs
- sort jobs by increasing difficulty, decreasing profit
- build sortedJob array, so that [difficulty[i], max profit for jobs' difficulty <= difficulty[i]], keep difficulty[i] increasing
- binary search to get the max profit for each worker

Time Complexity: O(nlogn + mlogn)
Space Complexity: O(n)
*/
class Solution {
    func maxProfitAssignment(_ difficulty: [Int], _ profit: [Int], _ worker: [Int]) -> Int {
        // jobs[i] is [difficulty[i], profit[i]]
        var jobs = [[Int]]()
        let n = difficulty.count
        for i in 0..<n {
            jobs.append([difficulty[i], profit[i]])
        }

        // sort job by increase difficulty, decrease profit
        jobs.sort(by: { j1, j2 -> Bool in
            return j1[0] == j2[0] ? j1[1] > j2[1] : j1[0] < j2[0]
        })

        // sortedJob[i] means [difficulty[i], max profit for job difficulty <= difficulty[i]]
        // sort by increase difficulty
        var cur = jobs[0]
        var curMaxProfit = jobs[0][1]
        var sortedJob = [[Int]]()
        for i in 1..<n {
            if jobs[i][0] != cur[0] {
                sortedJob.append([cur[0], curMaxProfit])
                curMaxProfit = max(curMaxProfit, jobs[i][1])
                cur = jobs[i]
            }
        }

        if sortedJob.last![0] != cur[0] {
            sortedJob.append([cur[0], curMaxProfit])
        }
        // print(sortedJob)

        var maxProfit = 0
        for ability in worker {
            maxProfit += getMaxProfit(ability, sortedJob, sortedJob.count)
            // print(maxProfit)
        }
        return maxProfit
    }

    func getMaxProfit(_ ability: Int, _ sortedJob: [[Int]], _ n: Int) -> Int {
        var l = 0
        var r = n-1
        while l < r {
            let mid = l + (r - l) / 2
            if sortedJob[mid][0] == ability {
                return sortedJob[mid][1]
            }
            if sortedJob[mid][0] < ability {
                l = mid + 1
            } else {
                r = mid
            }
        }
        var index = sortedJob[l][0] > ability ? l-1 : l
        index = min(index, n-1)
        return index < 0 ? 0 : sortedJob[index][1]
    }
}
