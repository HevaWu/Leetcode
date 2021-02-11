/*
Given an array of positive integers nums and a positive integer target, return the minimal length of a contiguous subarray [numsl, numsl+1, ..., numsr-1, numsr] of which the sum is greater than or equal to target. If there is no such subarray, return 0 instead.

 

Example 1:

Input: target = 7, nums = [2,3,1,2,4,3]
Output: 2
Explanation: The subarray [4,3] has the minimal length under the problem constraint.
Example 2:

Input: target = 4, nums = [1,4,4]
Output: 1
Example 3:

Input: target = 11, nums = [1,1,1,1,1,1,1,1]
Output: 0
 

Constraints:

1 <= target <= 109
1 <= nums.length <= 105
1 <= nums[i] <= 105
 

Follow up: If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log(n)).

*/

/*
Solution 1
2 pointer

first -> keep increasing cur
second -> if cur >= target, check if cur-nums[second] >= target

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        let n = nums.count
        
        var first = 0
        var second = 0
        
        var res = n+1
        var cur = 0
        while first < n {
            cur += nums[first] 
            if cur >= target {
                while cur-nums[second] >= target, second <= first {
                    cur -= nums[second]
                    second += 1
                }
                res = min(res, first - second + 1)
            } 
            first += 1
        }
        
        return res == n+1 ? 0 : res
    }
}