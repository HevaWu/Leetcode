/*
Given a binary array nums and an integer k, return the maximum number of consecutive 1's in the array if you can flip at most k 0's.



Example 1:

Input: nums = [1,1,1,0,0,0,1,1,1,1,0], k = 2
Output: 6
Explanation: [1,1,1,0,0,1,1,1,1,1,1]
Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.
Example 2:

Input: nums = [0,0,1,1,0,0,1,1,1,0,1,1,0,0,0,1,1,1,1], k = 3
Output: 10
Explanation: [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1]
Bolded numbers were flipped from 0 to 1. The longest subarray is underlined.


Constraints:

1 <= nums.length <= 105
nums[i] is either 0 or 1.
0 <= k <= nums.length
*/

/*
Solution 1:
2 pointer + sliding window

always make a canFlip k 0's window
and record so far longest ones

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func longestOnes(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count

        var left = 0
        var right = 0
        var flip = 0

        var cur = 0
        var longest = 0
        while right < n {
            if nums[right] == 0 {
                flip += 1

                // use left <= right to make sure flip properly,
                // ex: k = 0, canFlip window size will also be 0
                while flip > k, left <= right {
                    if nums[left] == 0 {
                        flip -= 1
                    }
                    cur -= 1
                    left += 1
                }
            }

            cur += 1
            longest = max(longest, cur)
            right += 1
        }
        return longest
    }
}