/*
You are given two integers n and k and two integer arrays speed and efficiency both of length n. There are n engineers numbered from 1 to n. speed[i] and efficiency[i] represent the speed and efficiency of the ith engineer respectively.

Choose at most k different engineers out of the n engineers to form a team with the maximum performance.

The performance of a team is the sum of their engineers' speeds multiplied by the minimum efficiency among their engineers.

Return the maximum performance of this team. Since the answer can be a huge number, return it modulo 109 + 7.



Example 1:

Input: n = 6, speed = [2,10,3,1,5,8], efficiency = [5,4,3,9,7,2], k = 2
Output: 60
Explanation:
We have the maximum performance of the team by selecting engineer 2 (with speed=10 and efficiency=4) and engineer 5 (with speed=5 and efficiency=7). That is, performance = (10 + 5) * min(4, 7) = 60.
Example 2:

Input: n = 6, speed = [2,10,3,1,5,8], efficiency = [5,4,3,9,7,2], k = 3
Output: 68
Explanation:
This is the same example as the first but k = 3. We can select engineer 1, engineer 2 and engineer 5 to get the maximum performance of the team. That is, performance = (2 + 10 + 5) * min(5, 4, 7) = 68.
Example 3:

Input: n = 6, speed = [2,10,3,1,5,8], efficiency = [5,4,3,9,7,2], k = 4
Output: 72


Constraints:

1 <= <= k <= n <= 105
speed.length == n
efficiency.length == n
1 <= speed[i] <= 105
1 <= efficiency[i] <= 108
*/

/*Solution 1:
greedy + priorityQueue

Intuition
- As a reminder, the performance of a team is defined as the sum of all members' speeds multiplied by the minimum efficiency among the members.
- As one can see, the performance of a team depends on two variables.
- To facilitate the enumeration process, let us first fix the value of one of the variables, namely the minimum efficiency of the team.
- The key idea behind the enumeration process is as follows:
    - For each candidate, we treat him/her as the one who has the minimum efficiency in a team. Then, we select the rest of the team members based on this condition.
    - The above enumeration is sound, which means it is guaranteed to find the optimal solution to the problem. For example, before arriving at a final solution where candidate X has the minimum efficiency on the team, we must have enumerated all potential team compositions that include candidate X.
- Most importantly, the above enumeration helps prune some of the unnecessary team compositions. Hence it runs significantly faster. Starting from a fixed candidate and only accepting new team members that have a higher efficiency than the fixed candidate, allows us to only consider teams of size k, rather than enumerating all teams of size one to k. This is because once the minimum efficiency of a team is fixed, each new team member is guaranteed to improve the team's performance. Therefore, we should add as many new members as possible.
- Actually, the above enumeration can be categorized as a Greedy algorithm, where we decompose a problem into a series of stages, and at each stage we make the locally optimal choice.
- In our case, we derive the solution through an enumeration process, where at each step we build a locally optimal team by starting from a fixed engineer with the minimum efficiency on the team. At the end of the enumeration process, we select the maximum among the locally optimal solutions to obtain the globally optimal solution.

Algorithm
- 1). Let's select the first engineer from the list of candidates as a potential member of the team.
- 2). Next, we will select the rest of the team members. We will use the following criteria in order to maximize the performance of the team:
    - Each of the selected members should have an efficiency that is at least as high as the engineer that was picked in the first step.
    - With the minimum effiency fixed, it will be beneficial to pick as many additional members as possible, up to the maximum quota of k-1 members.

Implementation:
- First of all, given a fixed member, we must find all eligible candidates (at most k-1 members) whose efficiencies are higher than the fixed member's efficiency.
    - To achieve this task, we could sort the candidates, in descending order, based on efficiency.
    - We then iterate through the sorted candidates. For each candidate, we only need to consider the earlier candidates. Since the list is sorted, only the earlier candidates will have a higher efficiency than the current candidate.
- Given all the eligible candidates, in order to maximize the total speed, we need to find the fastest k-1 eligible candidates.
    - To achieve this task, we can sort the candidates again. But this time, we sort only the earlier candidates, and most importantly we sort by speed rather than efficiency.
    - The sorting idea is a valid one. However, a more efficient option would be to apply the Priority Queue data structure here. The priority queue, also known as heap, is a data structure which dynamically maintains the order of elements based on some predefined priority. The priority queue is well-known for its optimized time complexity when maintaining a list of sorted elements. As such, we will we opt to use a priority queue in the following implementation.

sum up:
- First of all, let's sort the candidates by efficiency in descending order.
- Then, we will iterate through the sorted candidates.
    - At each iteration, our goal is to construct a team with at most k members, while treating the current candidate as the one with the lowest efficiency on the team.
    - We use a priority queue to store the speeds for the rest k-1 team members. The priority queue is maintained as a sliding window along with our iteration. For example, we pop out the member with the lowest speed when we exceed the predefined capacity of the queue, which is k-1.


Time Complexity: O(N⋅(logN+logK))
Space Complexity: O(N + K)
*/
class Solution {
    func maxPerformance(_ n: Int, _ speed: [Int], _ efficiency: [Int], _ k: Int) -> Int {
        let mod = Int(1e9+7)
        var candidates = [(e: Int, s: Int)]()

        let n = speed.count
        for i in 0..<n {
            candidates.append((efficiency[i], speed[i]))
        }

        // sort by efficiency
        candidates.sort(by: { first, second in
            return first.e > second.e
        })

        // print(candidates)

        var speedHeap = [Int]()
        var maxP = 0 // max performance
        var sumS = 0 // sum of speed

        for (curE, curS) in candidates {
            if speedHeap.count > k-1 {
                // pop member with lowest speed when we exceed capacity
                sumS -= speedHeap.removeFirst()
            }

            insert(curS, &speedHeap)

            // print(speedHeap, curS, sumS, curE)
            sumS += curS

            // calculate max performance with current member
            maxP = max(maxP, curE * sumS)
        }
        return maxP % mod
    }

    // insert target in arr
    // make sort in ascending order
    func insert(_ target: Int, _ arr: inout [Int]) {
        if arr.isEmpty {
            arr.append(target)
            return
        }

        var left = 0
        var right = arr.count-1

        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }

        arr.insert(target, at: arr[left] < target ? left + 1 : left)
    }
}