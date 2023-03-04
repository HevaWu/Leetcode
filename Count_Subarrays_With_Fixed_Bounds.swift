/*
You are given an integer array nums and two integers minK and maxK.

A fixed-bound subarray of nums is a subarray that satisfies the following conditions:

The minimum value in the subarray is equal to minK.
The maximum value in the subarray is equal to maxK.
Return the number of fixed-bound subarrays.

A subarray is a contiguous part of an array.



Example 1:

Input: nums = [1,3,5,2,7,5], minK = 1, maxK = 5
Output: 2
Explanation: The fixed-bound subarrays are [1,3,5] and [1,3,5,2].
Example 2:

Input: nums = [1,1,1,1], minK = 1, maxK = 1
Output: 10
Explanation: Every subarray of nums is a fixed-bound subarray. There are 10 possible subarrays.


Constraints:

2 <= nums.length <= 105
1 <= nums[i], minK, maxK <= 106
*/

/*
Solution 1:
greedy

use minIndex, maxIndex, leftBound
to record (latest appearance of minK, latest appearance of maxK, last out of bounds index)
sub += max(0, min(minIndex, maxIndex) - leftBound)
to accumulate possible subarray

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countSubarrays(_ nums: [Int], _ minK: Int, _ maxK: Int) -> Int {
        let n = nums.count
        var sub = 0
        var leftBound = -1
        var minIndex = -1
        var maxIndex = -1

        for i in 0..<n {
            if nums[i] < minK || nums[i] > maxK {
                leftBound = i
            }

            if nums[i] == minK {
                minIndex = i
            }
            if nums[i] == maxK {
                maxIndex = i
            }
            sub += max(0, min(minIndex, maxIndex) - leftBound)
        }

        return sub
    }
}
