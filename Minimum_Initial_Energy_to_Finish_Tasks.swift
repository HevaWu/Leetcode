/*
You are given an array tasks where tasks[i] = [actuali, minimumi]:

actuali is the actual amount of energy you spend to finish the ith task.
minimumi is the minimum amount of energy you require to begin the ith task.
For example, if the task is [10, 12] and your current energy is 11, you cannot start this task. However, if your current energy is 13, you can complete this task, and your energy will be 3 after finishing it.

You can finish the tasks in any order you like.

Return the minimum initial amount of energy you will need to finish all the tasks.



Example 1:

Input: tasks = [[1,2],[2,4],[4,8]]
Output: 8
Explanation:
Starting with 8 energy, we finish the tasks in the following order:
    - 3rd task. Now energy = 8 - 4 = 4.
    - 2nd task. Now energy = 4 - 2 = 2.
    - 1st task. Now energy = 2 - 1 = 1.
Notice that even though we have leftover energy, starting with 7 energy does not work because we cannot do the 3rd task.
Example 2:

Input: tasks = [[1,3],[2,4],[10,11],[10,12],[8,9]]
Output: 32
Explanation:
Starting with 32 energy, we finish the tasks in the following order:
    - 1st task. Now energy = 32 - 1 = 31.
    - 2nd task. Now energy = 31 - 2 = 29.
    - 3rd task. Now energy = 29 - 10 = 19.
    - 4th task. Now energy = 19 - 10 = 9.
    - 5th task. Now energy = 9 - 8 = 1.
Example 3:

Input: tasks = [[1,7],[2,8],[3,9],[4,10],[5,11],[6,12]]
Output: 27
Explanation:
Starting with 27 energy, we finish the tasks in the following order:
    - 5th task. Now energy = 27 - 5 = 22.
    - 2nd task. Now energy = 22 - 2 = 20.
    - 3rd task. Now energy = 20 - 3 = 17.
    - 1st task. Now energy = 17 - 1 = 16.
    - 4th task. Now energy = 16 - 4 = 12.
    - 6th task. Now energy = 12 - 6 = 6.


Constraints:

1 <= tasks.length <= 105
1 <= actual​i <= minimumi <= 104

*/

/*
Solution 2:
greedy

sort tasks by ascending diff->(t[1]-t[0])
take tasks, effort += t[0] effort = max(effort, t[1])

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func minimumEffort(_ tasks: [[Int]]) -> Int {
        var tasks = tasks.sorted(by: { first, second -> Bool in
            let diff1 = first[1]-first[0]
            let diff2 = second[1] - second[0]
            return diff1 < diff2
        })

        var effort = 0
        for t in tasks {
            effort += t[0]
            effort = max(effort, t[1])
        }
        return effort
    }
}

/*
Solution 1:
binary search

task: sort by max gap between minimum and actual,
first sort by descending t[1] - t[0], then sort by descending t[1]

binary search for find minimum proper energy to handle all tasks

Time Complexity: O(nlogn + log(right-left)*n)
- n is len of tasks
Space Complexity: O(n)
*/
class Solution {
    func minimumEffort(_ tasks: [[Int]]) -> Int {
        var tasks = tasks.sorted(by: { first, second -> Bool in
            let diff1 = first[1]-first[0]
            let diff2 = second[1] - second[0]
            return diff1 == diff2 ? first[1] > second[1] : diff1 > diff2
        })

        var left = 0
        var right = tasks.reduce(into: 0) { res, next in
            res += next[1]
        }

        // print(tasks)
        while left+1 < right {
            let mid = left + (right - left)/2
            if canFinish(mid, tasks) {
                right = mid
            } else {
                left = mid
            }
        }
        return right
    }

    func canFinish(_ energy: Int, _ tasks: [[Int]]) -> Bool {
        var res = true
        var energy = energy
        for task in tasks {
            if energy < task[1] {
                return false
            } else {
                energy -= task[0]
            }
        }
        return res
    }
}