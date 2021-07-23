/*
You are given a 2D integer array logs where each logs[i] = [birthi, deathi] indicates the birth and death years of the ith person.

The population of some year x is the number of people alive during that year. The ith person is counted in year x's population if x is in the inclusive range [birthi, deathi - 1]. Note that the person is not counted in the year that they die.

Return the earliest year with the maximum population.



Example 1:

Input: logs = [[1993,1999],[2000,2010]]
Output: 1993
Explanation: The maximum population is 1, and 1993 is the earliest year with this population.
Example 2:

Input: logs = [[1950,1961],[1960,1971],[1970,1981]]
Output: 1960
Explanation:
The maximum population is 2, and it had happened in years 1960 and 1970.
The earlier year between them is 1960.


Constraints:

1 <= logs.length <= 100
1950 <= birthi < deathi <= 2050
*/

/*
Solution 1:
sort + binary search

sort by birth date
use binary search to
- when adding current person's log, remove previous index number of person who has died
- add current person's death date into aliveArr logs

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func maximumPopulation(_ logs: [[Int]]) -> Int {
        // sort by birth date
        var logs = logs.sorted(by: { first, second -> Bool in
            return first[0] == second[0] ? first[1] < second[1] : first[0] < second[0]
        })
        // print(logs)

        var maxP = 0
        var earliest = 0
        var aliveArr = [Int]()
        for log in logs {
            var index = getIndex(log[0], aliveArr)
            // remove 0..<index
            aliveArr.removeFirst(index)
            // print(aliveArr)

            // population is in inclusive range of [birth, death-1]
            index = getIndex(log[1]-1, aliveArr)
            aliveArr.insert(log[1]-1, at: index)

            // print(aliveArr)
            if maxP < aliveArr.count {
                maxP = aliveArr.count
                earliest = log[0]
            }
        }
        return earliest
    }

    func getIndex(_ date: Int, _ aliveArr: [Int]) -> Int {
        if aliveArr.isEmpty { return 0 }

        var left = 0
        var right = aliveArr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if aliveArr[mid] < date {
                left = mid+1
            } else {
                right = mid
            }
        }

        return aliveArr[left] < date ? left+1 : left
    }
}