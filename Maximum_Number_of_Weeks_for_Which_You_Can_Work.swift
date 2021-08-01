/*
There are n projects numbered from 0 to n - 1. You are given an integer array milestones where each milestones[i] denotes the number of milestones the ith project has.

You can work on the projects following these two rules:

Every week, you will finish exactly one milestone of one project. You must work every week.
You cannot work on two milestones from the same project for two consecutive weeks.
Once all the milestones of all the projects are finished, or if the only milestones that you can work on will cause you to violate the above rules, you will stop working. Note that you may not be able to finish every project's milestones due to these constraints.

Return the maximum number of weeks you would be able to work on the projects without violating the rules mentioned above.



Example 1:

Input: milestones = [1,2,3]
Output: 6
Explanation: One possible scenario is:
​​​​- During the 1st week, you will work on a milestone of project 0.
- During the 2nd week, you will work on a milestone of project 2.
- During the 3rd week, you will work on a milestone of project 1.
- During the 4th week, you will work on a milestone of project 2.
- During the 5th week, you will work on a milestone of project 1.
- During the 6th week, you will work on a milestone of project 2.
The total number of weeks is 6.
Example 2:

Input: milestones = [5,2,1]
Output: 7
Explanation: One possible scenario is:
- During the 1st week, you will work on a milestone of project 0.
- During the 2nd week, you will work on a milestone of project 1.
- During the 3rd week, you will work on a milestone of project 0.
- During the 4th week, you will work on a milestone of project 1.
- During the 5th week, you will work on a milestone of project 0.
- During the 6th week, you will work on a milestone of project 2.
- During the 7th week, you will work on a milestone of project 0.
The total number of weeks is 7.
Note that you cannot work on the last milestone of project 0 on 8th week because it would violate the rules.
Thus, one milestone in project 0 will remain unfinished.


Constraints:

n == milestones.length
1 <= n <= 105
1 <= milestones[i] <= 109
*/

/*
Solution 2:
greedy

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func numberOfWeeks(_ milestones: [Int]) -> Int {
        let n = milestones.count
        var sum = 0
        var maxVal = 0
        for i in 0..<n {
            sum += milestones[i]
            maxVal = max(maxVal, milestones[i])
        }

        if sum - maxVal >= maxVal { return sum }
        // # start from the project with most milestones (_sum - _max + 1) and work on the the rest of milestones (_sum - _max)
        return 2 * (sum - maxVal) + 1
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func numberOfWeeks(_ milestones: [Int]) -> Int {
        let n = milestones.count
        var milestones = milestones.sorted(by: >)

        var week = 0
        while milestones.count > 1 {
            let p1 = milestones.removeFirst()

            var next = 0
            while next < milestones.count, milestones[next] == p1 {
                next += 1
            }

            if next > 0 {
                let remain = next == milestones.count ? 0 : milestones[next]
                // print(remain, next, p1)

                // 0...(next-1) is equal to p1
                week += (p1-remain) * (next+1)

                if remain > 0 {
                    milestones[0..<next] = Array(repeating: remain, count: next+1)[0...]
                } else {
                    // remain is 0, finish
                    milestones = [Int]()
                }
            } else {
                let p2 = milestones.removeFirst()
                week += 2
                if p1-1 > 0 { insert(p1-1, &milestones) }
                if p2-1 > 0 { insert(p2-1, &milestones) }
            }
            // print(next, week, milestones)
        }

        if milestones.count == 1, milestones[0] > 0 {
            week += 1
        }

        return week
    }

    func insert(_ target: Int, _ arr: inout [Int]) {
        if arr.isEmpty {
            arr.append(target)
            return
        }

        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] > target {
                left = mid+1
            } else {
                right = mid
            }
        }
        arr.insert(target, at: arr[left] > target ? left+1 : left)
    }
}