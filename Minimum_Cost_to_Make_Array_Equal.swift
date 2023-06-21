/*
You are given two 0-indexed arrays nums and cost consisting each of n positive integers.

You can do the following operation any number of times:

Increase or decrease any element of the array nums by 1.
The cost of doing one operation on the ith element is cost[i].

Return the minimum total cost such that all the elements of the array nums become equal.



Example 1:

Input: nums = [1,3,5,2], cost = [2,3,1,14]
Output: 8
Explanation: We can make all the elements equal to 2 in the following way:
- Increase the 0th element one time. The cost is 2.
- Decrease the 1st element one time. The cost is 3.
- Decrease the 2nd element three times. The cost is 1 + 1 + 1 = 3.
The total cost is 2 + 3 + 3 = 8.
It can be shown that we cannot make the array equal with a smaller cost.
Example 2:

Input: nums = [2,2,2,2,2], cost = [4,2,8,1,3]
Output: 0
Explanation: All the elements are already equal, so no operations are needed.


Constraints:

n == nums.length == cost.length
1 <= n <= 105
1 <= nums[i], cost[i] <= 106
*/

/*
Solution 1:
get the minNum and maxNum

use minVal to record how many cost used when change from minNum
use maxVal to record how many cost used when change from maxNum

always pick less cost
accumulate until minNum == maxNum

Time Complexity: O(n + (maxNum - minNum))
Space Complexity: O(maxNum - minNum)
*/
class Solution {
    func minCost(_ nums: [Int], _ cost: [Int]) -> Int {
        var res = 0
        var map = [Int: Int]()
        let n = nums.count
        var minNum = nums[0]
        var maxNum = nums[0]
        for i in 0..<n {
            map[nums[i], default: 0] += cost[i]
            minNum = min(minNum, nums[i])
            maxNum = max(maxNum, nums[i])
        }

        var minVal = map[minNum, default: 0]
        var maxVal = map[maxNum, default: 0]
        while minNum < maxNum {
            if minVal <= maxVal {
                res += minVal
                minNum += 1
                minVal += map[minNum, default: 0]
            } else {
                res += maxVal
                maxNum -= 1
                maxVal += map[maxNum, default: 0]
            }
        }

        return res
    }
}
