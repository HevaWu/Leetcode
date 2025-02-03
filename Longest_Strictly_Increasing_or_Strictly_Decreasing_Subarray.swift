/*
You are given an array of integers nums. Return the length of the longest
subarray
 of nums which is either
strictly increasing
 or
strictly decreasing
.



Example 1:

Input: nums = [1,4,3,3,2]

Output: 2

Explanation:

The strictly increasing subarrays of nums are [1], [2], [3], [3], [4], and [1,4].

The strictly decreasing subarrays of nums are [1], [2], [3], [3], [4], [3,2], and [4,3].

Hence, we return 2.

Example 2:

Input: nums = [3,3,3,3]

Output: 1

Explanation:

The strictly increasing subarrays of nums are [3], [3], [3], and [3].

The strictly decreasing subarrays of nums are [3], [3], [3], and [3].

Hence, we return 1.

Example 3:

Input: nums = [3,2,1]

Output: 3

Explanation:

The strictly increasing subarrays of nums are [3], [2], and [1].

The strictly decreasing subarrays of nums are [3], [2], [1], [3,2], [2,1], and [3,2,1].

Hence, we return 3.



Constraints:

1 <= nums.length <= 50
1 <= nums[i] <= 50
*/

/*
Solution 1:
iterate array twice, once for increase check, one for decrease check

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func longestMonotonicSubarray(_ nums: [Int]) -> Int {
        var increase = 0
        var cur = 1
        let n = nums.count
        if n == 1 { return 1 }
        // go through strictly increase case
        for i in 1..<n {
            if nums[i] > nums[i-1] {
                cur += 1
            } else {
                increase = max(increase, cur)
                cur = 1
            }
        }
        increase = max(increase, cur)

        // go through stricktly decrease
        cur = 1
        var decrease = 0
        for i in stride(from: n-1, to: 0, by: -1) {
            if nums[i-1] > nums[i] {
                cur += 1
            } else {
                decrease = max(decrease, cur)
                cur = 1
            }
        }
        decrease = max(decrease, cur)
        return max(increase, decrease)
    }
}
