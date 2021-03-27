/*
A chef has collected data on the satisfaction level of his n dishes. Chef can cook any dish in 1 unit of time.

Like-time coefficient of a dish is defined as the time taken to cook that dish including previous dishes multiplied by its satisfaction level  i.e.  time[i]*satisfaction[i]

Return the maximum sum of Like-time coefficient that the chef can obtain after dishes preparation.

Dishes can be prepared in any order and the chef can discard some dishes to get this maximum value.



Example 1:

Input: satisfaction = [-1,-8,0,5,-9]
Output: 14
Explanation: After Removing the second and last dish, the maximum total Like-time coefficient will be equal to (-1*1 + 0*2 + 5*3 = 14). Each dish is prepared in one unit of time.
Example 2:

Input: satisfaction = [4,3,2]
Output: 20
Explanation: Dishes can be prepared in any order, (2*1 + 3*2 + 4*3 = 20)
Example 3:

Input: satisfaction = [-1,-4,-5]
Output: 0
Explanation: People don't like the dishes. No dish is prepared.
Example 4:

Input: satisfaction = [-2,5,-1,0,3,-3]
Output: 35


Constraints:

n == satisfaction.length
1 <= n <= 500
-10^3 <= satisfaction[i] <= 10^3
*/

/*
Solution 2:
optimize solution 1

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func maxSatisfaction(_ satisfaction: [Int]) -> Int {
        var preSum = 0
        var likeTime = 0

        for s in satisfaction.sorted(by: >) {
            preSum += s
            if preSum < 0 { break }
            likeTime += preSum
        }

        return likeTime
    }
}

/*
Solution 1:
greedy

- sort array by descending order
- start from 0, iteratively check its like time
  - cur = cur+preSum+s
  - likeTime = max(likeTime, cur)

Time Compexitly: O(nlogn)
Space Compexitly: O(n)
*/
class Solution {
    func maxSatisfaction(_ satisfaction: [Int]) -> Int {
        let n = satisfaction.count
        if n == 1 {
            return satisfaction[0] > 0 ? satisfaction[0] : 0
        }

        // sort by descending order
        var satisfaction = satisfaction.sorted(by: >)
        // if largest one is <= 0, return 0
        if satisfaction[0] <= 0 {
            return 0
        }

        var likeTime = 0

        // pre sum of checked element
        var preSum = 0

        // current satisfaction time
        var cur = 0

        for s in satisfaction {
            cur = cur + preSum + s
            likeTime = max(likeTime, cur)

            preSum += s
            if preSum < 0 {
                break
            }
        }

        return likeTime
    }
}