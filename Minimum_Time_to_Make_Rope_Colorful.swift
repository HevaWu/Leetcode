/*
Alice has n balloons arranged on a rope. You are given a 0-indexed string colors where colors[i] is the color of the ith balloon.

Alice wants the rope to be colorful. She does not want two consecutive balloons to be of the same color, so she asks Bob for help. Bob can remove some balloons from the rope to make it colorful. You are given a 0-indexed integer array neededTime where neededTime[i] is the time (in seconds) that Bob needs to remove the ith balloon from the rope.

Return the minimum time Bob needs to make the rope colorful.



Example 1:


Input: colors = "abaac", neededTime = [1,2,3,4,5]
Output: 3
Explanation: In the above image, 'a' is blue, 'b' is red, and 'c' is green.
Bob can remove the blue balloon at index 2. This takes 3 seconds.
There are no longer two consecutive balloons of the same color. Total time = 3.
Example 2:


Input: colors = "abc", neededTime = [1,2,3]
Output: 0
Explanation: The rope is already colorful. Bob does not need to remove any balloons from the rope.
Example 3:


Input: colors = "aabaa", neededTime = [1,2,3,4,1]
Output: 2
Explanation: Bob will remove the ballons at indices 0 and 4. Each ballon takes 1 second to remove.
There are no longer two consecutive balloons of the same color. Total time = 1 + 1 = 2.


Constraints:

n == colors.length == neededTime.length
1 <= n <= 105
1 <= neededTime[i] <= 104
colors contains only lowercase English letters.
*/

/*
Solution 1:
Maintain running sum and max neededTime for repeated colors

- curMaxCost: max neededTime ballon of current repeated
- curSumCost: current repeated color balloons' total neededTime
- start: the start index of current repeated colors

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minCost(_ colors: String, _ neededTime: [Int]) -> Int {
        let n = colors.count
        if n == 1 { return 0 }

        var cost = 0

        var colors = Array(colors)

        // the largest neededTime ballon's time
        // of current repeat color ballons
        var curMaxCost = neededTime[0]

        // sum of current repeat color ballons' neededTime
        var curSumCost = neededTime[0]

        // start index of current repeat color
        var start = 0

        for i in 1..<n {
            if colors[i] == colors[i-1] {
                curMaxCost = max(curMaxCost, neededTime[i])
                curSumCost += neededTime[i]
            } else {
                // new color ballon

                // check if previous ballon has repeated or not
                if i-start-1 > 0 {
                    // there are some repeated ballon
                    cost += (curSumCost - curMaxCost)
                }

                // reset state with new color
                curMaxCost = neededTime[i]
                curSumCost = neededTime[i]
                start = i
            }
        }

        // check if the last ballon has repeated or not
        if n-start-1 > 0 {
            cost += (curSumCost - curMaxCost)
        }

        return cost
    }
}