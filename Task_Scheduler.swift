/*
Given a characters array tasks, representing the tasks a CPU needs to do, where each letter represents a different task. Tasks could be done in any order. Each task is done in one unit of time. For each unit of time, the CPU could complete either one task or just be idle.

However, there is a non-negative integer n that represents the cooldown period between two same tasks (the same letter in the array), that is that there must be at least n units of time between any two same tasks.

Return the least number of units of times that the CPU will take to finish all the given tasks.

 

Example 1:

Input: tasks = ["A","A","A","B","B","B"], n = 2
Output: 8
Explanation: 
A -> B -> idle -> A -> B -> idle -> A -> B
There is at least 2 units of time between any two same tasks.
Example 2:

Input: tasks = ["A","A","A","B","B","B"], n = 0
Output: 6
Explanation: On this case any permutation of size 6 would work since n = 0.
["A","A","A","B","B","B"]
["A","B","A","B","A","B"]
["B","B","B","A","A","A"]
...
And so on.
Example 3:

Input: tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2
Output: 16
Explanation: 
One possible solution is
A -> B -> C -> A -> D -> E -> A -> F -> G -> A -> idle -> idle -> A -> idle -> idle -> A
 

Constraints:

1 <= task.length <= 104
tasks[i] is upper-case English letter.
The integer n is in the range [0, 100].
*/

/*
Solution 2:
optimize solution 1
*/
class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        let asciiA = Character("A").asciiValue!
        
        var counter = Array(repeating: 0, count: 26)
        for task in tasks {
            counter[Int(task.asciiValue! - asciiA)] += 1
        }
        
        let maxCount = counter.max()!
        let maxEle = counter.filter { $0==maxCount }.count
        
        return max(tasks.count, (n+1)*(maxCount-1)+maxEle)
    }
}

/*
Solution 1:
find how many idles we need to

1. find maxEle, maxCount
 - maxCount: maximum appeared tasks frequency
 - maxEle: how many element have appeared same maxEle 
2. count idle
  - emptySlots - available = idle
3. return task.count+idle

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        var maxEle = 0
        var maxCount = 0

        var map = [Character: Int]()
        for task in tasks {
            map[task, default: 0] += 1
            if maxCount == map[task]! {
                maxEle += 1
            } else if maxCount < map[task]! {
                maxEle = map[task]!
                maxCount = 1
            }
        }
        
        var partCount = maxCount - 1
        var partLen = n - (maxEle - 1)
        
        var emptySlots = partCount * partLen
        var available = tasks.count - maxEle * maxCount
        var idle = max(0, emptySlots - available)
        
        return tasks.count + idle
    }
}