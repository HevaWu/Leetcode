/*
You are given a 2D integer array intervals, where intervals[i] = [lefti, righti] describes the ith interval starting at lefti and ending at righti (inclusive). The size of an interval is defined as the number of integers it contains, or more formally righti - lefti + 1.

You are also given an integer array queries. The answer to the jth query is the size of the smallest interval i such that lefti <= queries[j] <= righti. If no such interval exists, the answer is -1.

Return an array containing the answers to the queries.



Example 1:

Input: intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]
Output: [3,3,1,4]
Explanation: The queries are processed as follows:
- Query = 2: The interval [2,4] is the smallest interval containing 2. The answer is 4 - 2 + 1 = 3.
- Query = 3: The interval [2,4] is the smallest interval containing 3. The answer is 4 - 2 + 1 = 3.
- Query = 4: The interval [4,4] is the smallest interval containing 4. The answer is 4 - 4 + 1 = 1.
- Query = 5: The interval [3,6] is the smallest interval containing 5. The answer is 6 - 3 + 1 = 4.
Example 2:

Input: intervals = [[2,3],[2,5],[1,8],[20,25]], queries = [2,19,5,22]
Output: [2,-1,4,6]
Explanation: The queries are processed as follows:
- Query = 2: The interval [2,3] is the smallest interval containing 2. The answer is 3 - 2 + 1 = 2.
- Query = 19: None of the intervals contain 19. The answer is -1.
- Query = 5: The interval [2,5] is the smallest interval containing 5. The answer is 5 - 2 + 1 = 4.
- Query = 22: The interval [20,25] is the smallest interval containing 22. The answer is 25 - 20 + 1 = 6.


Constraints:

1 <= intervals.length <= 105
1 <= queries.length <= 105
queries[i].length == 2
1 <= lefti <= righti <= 107
1 <= queries[j] <= 107
*/


/*
Solution 1:
Time Limit Exceeded

sort intervals by end, then by start
for each query, check and get smallest interval
*/
class Solution {
    func minInterval(_ intervals: [[Int]], _ queries: [Int]) -> [Int] {
        var intervals = intervals.sorted(by: { first, second -> Bool in
            return first[1] == second[1]
                ? first[0] < second[0]
                : first[1] < second[1]
        })

        var cache = [Int: Int]()
        return queries.map { q -> Int in
            if let val = cache[q] { return val }
            if let interval = getSmallest(q, intervals) {
                cache[q] = interval[1] - interval[0] + 1
            } else {
                cache[q] = -1
            }
            return cache[q]!
        }
    }

    func getSmallest(_ q: Int, _ intervals: [[Int]]) -> [Int]? {
        let n = intervals.count
        var left = 0
        var right = n-1

        while left < right {
            let mid = left + (right-left)/2
            if intervals[mid][1] < q {
                left = mid+1
            } else {
                right = mid
            }
        }

        var index = left
        if intervals[left][1] < q {
            // search from left+1
            index = left+1
        }

        // print(q, index, intervals)

        var size = Int.max
        var res = [Int]()
        while index < n {
            // print("check", intervals[index][1] >= q, intervals[index][1] - intervals[index][0] < size)
            let dis = intervals[index][1] - intervals[index][0]
            if intervals[index][0] <= q, intervals[index][1] >= q, dis < size {
                res = intervals[index]
                size = dis
            }
            index += 1
        }
        return size == Int.max ? nil : res
    }
}