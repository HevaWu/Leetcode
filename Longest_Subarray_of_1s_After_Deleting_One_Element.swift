/*
Given a binary array nums, you should delete one element from it.

Return the size of the longest non-empty subarray containing only 1's in the resulting array. Return 0 if there is no such subarray.



Example 1:

Input: nums = [1,1,0,1]
Output: 3
Explanation: After deleting the number in position 2, [1,1,1] contains 3 numbers with value of 1's.
Example 2:

Input: nums = [0,1,1,1,0,1,1,0,1]
Output: 5
Explanation: After deleting the number in position 4, [0,1,1,1,1,1,0,1] longest subarray with value of 1's is [1,1,1,1,1].
Example 3:

Input: nums = [1,1,1]
Output: 2
Explanation: You must delete one element.


Constraints:

1 <= nums.length <= 105
nums[i] is either 0 or 1.
*/

/*
Solution 2:
use prev, space, cur to record previous continuos 1 subarray, the space between prev and cur, and current continuos 1 subarray

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func longestSubarray(_ nums: [Int]) -> Int {
        // record the previous continuous 1 subarry
        var prev = 0
        // record 0 between prev and cur
        var space = 0
        // record the current continuous 1 subarray
        var cur = 0

        var longest = 0
        for num in nums {
            if num == 1 {
                cur += 1
            } else {
                if space == 1 {
                    longest = max(longest, prev + cur)
                }
                longest = max(longest, cur - 1)
                prev = cur
                cur = 0
                space = 1
            }
        }
        if space == 1 {
            longest = max(longest, prev + cur)
        }
        longest = max(longest, cur - 1)
        return longest
    }
}

/*
Solution 1:
2 pointer

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func longestSubarray(_ nums: [Int]) -> Int {
        var s = 0
        var e = 0
        var zero = 0
        var longest = 0
        while e < nums.count {
            if nums[e] == 0 {
                zero += 1
            }
            e += 1
            while s < e, zero > 1 {
                if nums[s] == 0 {
                    zero -= 1
                }
                s += 1
            }
            if zero <= 1 {
                longest = max(longest, e - s - 1)
            }
        }
        return longest
    }
}
