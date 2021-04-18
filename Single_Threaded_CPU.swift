/*
You are given n​​​​​​ tasks labeled from 0 to n - 1 represented by a 2D integer array tasks, where tasks[i] = [enqueueTimei, processingTimei] means that the i​​​​​​th​​​​ task will be available to process at enqueueTimei and will take processingTimei to finish processing.

You have a single-threaded CPU that can process at most one task at a time and will act in the following way:

If the CPU is idle and there are no available tasks to process, the CPU remains idle.
If the CPU is idle and there are available tasks, the CPU will choose the one with the shortest processing time. If multiple tasks have the same shortest processing time, it will choose the task with the smallest index.
Once a task is started, the CPU will process the entire task without stopping.
The CPU can finish a task then start a new one instantly.
Return the order in which the CPU will process the tasks.



Example 1:

Input: tasks = [[1,2],[2,4],[3,2],[4,1]]
Output: [0,2,3,1]
Explanation: The events go as follows:
- At time = 1, task 0 is available to process. Available tasks = {0}.
- Also at time = 1, the idle CPU starts processing task 0. Available tasks = {}.
- At time = 2, task 1 is available to process. Available tasks = {1}.
- At time = 3, task 2 is available to process. Available tasks = {1, 2}.
- Also at time = 3, the CPU finishes task 0 and starts processing task 2 as it is the shortest. Available tasks = {1}.
- At time = 4, task 3 is available to process. Available tasks = {1, 3}.
- At time = 5, the CPU finishes task 2 and starts processing task 3 as it is the shortest. Available tasks = {1}.
- At time = 6, the CPU finishes task 3 and starts processing task 1. Available tasks = {}.
- At time = 10, the CPU finishes task 1 and becomes idle.
Example 2:

Input: tasks = [[7,10],[7,12],[7,5],[7,4],[7,2]]
Output: [4,3,2,0,1]
Explanation: The events go as follows:
- At time = 7, all the tasks become available. Available tasks = {0,1,2,3,4}.
- Also at time = 7, the idle CPU starts processing task 4. Available tasks = {0,1,2,3}.
- At time = 9, the CPU finishes task 4 and starts processing task 3. Available tasks = {0,1,2}.
- At time = 13, the CPU finishes task 3 and starts processing task 2. Available tasks = {0,1}.
- At time = 18, the CPU finishes task 2 and starts processing task 0. Available tasks = {1}.
- At time = 28, the CPU finishes task 0 and starts processing task 1. Available tasks = {}.
- At time = 40, the CPU finishes task 1 and becomes idle.


Constraints:

tasks.length == n
1 <= n <= 105
1 <= enqueueTimei, processingTimei <= 109
*/

/*
Solution 1:
Time Limit Exceeded

- for each task, append it index
- sort task by enqueueTime, processingTime
- each time, track and pick proper available task
*/
class Solution {
    func getOrder(_ tasks: [[Int]]) -> [Int] {
        let n = tasks.count
        if n == 1 { return [0] }

        // append index
        // tasks[i] -> [enqueueTime_i, processingTime_i, i]
        var tasks = tasks
        for i in 0..<n {
            tasks[i].append(i)
        }

        // sort tasks by enqueueTime, then processingTime
        tasks.sort(by: { first, second -> Bool in
            return first[0] == second[0] ? first[1] < second[1] : first[0] < second[0]
        })

        var available = [[Int]]()
        available.append(tasks.removeFirst())
        var time = 0

        var order = [Int]()
        while !available.isEmpty {
            let cur = available.removeFirst()
            order.append(cur[2])
            time = max(time, cur[0]) + cur[1]

            while !tasks.isEmpty, tasks.first![0] <= time {
                insert(tasks.removeFirst(), &available)
            }
            // print(time)
        }
        return order
    }

    // insert task into available by processingTime, then index
    func insert(_ task: [Int], _ available: inout [[Int]]) {
        // defer{
        //     print("added", task, available)
        // }
        if available.isEmpty {
            available.append(task)
            return
        }

        var left = 0
        var right = available.count-1
        while left < right {
            let mid = left + (right-left)/2
            if available[mid][1] < task[1]
            || (available[mid][1] == task[1] && available[mid][2] < task[2]) {
                // first by processingTime, then by index
                left = mid + 1
            } else {
                right = mid
            }
        }

        if available[left][1] < task[1]
        || (available[left][1] == task[1] && available[left][2] < task[2]) {
            available.insert(task, at: left+1)
        } else {
            available.insert(task, at: left)
        }
    }
}