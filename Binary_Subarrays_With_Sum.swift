/*
Given a binary array nums and an integer goal, return the number of non-empty subarrays with a sum goal.

A subarray is a contiguous part of the array.



Example 1:

Input: nums = [1,0,1,0,1], goal = 2
Output: 4
Explanation: The 4 subarrays are bolded and underlined below:
[1,0,1,0,1]
[1,0,1,0,1]
[1,0,1,0,1]
[1,0,1,0,1]
Example 2:

Input: nums = [0,0,0,0,0], goal = 0
Output: 15


Constraints:

1 <= nums.length <= 3 * 104
nums[i] is either 0 or 1.
0 <= goal <= nums.length
*/

/*
Solution 1:
dictionary to record the previous continuos subarray sum

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func numSubarraysWithSum(_ nums: [Int], _ goal: Int) -> Int {
        var dic = [0 : 1]
        var cur = 0
        var totalSub = 0
        for num in nums {
            cur += num
            if let val = dic[cur - goal] {
                totalSub += val
            }
            dic[cur, default: 0] += 1
        }
        return totalSub
    }
}
