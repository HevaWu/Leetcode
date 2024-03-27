/*
Given an array of integers nums and an integer k, return the number of contiguous subarrays where the product of all the elements in the subarray is strictly less than k.



Example 1:

Input: nums = [10,5,2,6], k = 100
Output: 8
Explanation: The 8 subarrays that have product less than 100 are:
[10], [5], [2], [6], [10, 5], [5, 2], [2, 6], [5, 2, 6]
Note that [10, 5, 2] is not included as the product of 100 is not strictly less than k.
Example 2:

Input: nums = [1,2,3], k = 0
Output: 0


Constraints:

1 <= nums.length <= 3 * 104
1 <= nums[i] <= 1000
0 <= k <= 106
*/

/*
Solution 1:
Sliding window

keep hold nums[l...r] which product < k
then record possible continuous subarray from it (r-l+1)

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var l = 0
        var r = 0
        var product = 1
        var count = 0
        if k <= 1  { return 0 }
        while r < n {
            product *= nums[r]
            while product >= k {
                product /= nums[l]
                l += 1
            }
            count += (1 + (r-l))
            r += 1
        }
        return count
    }
}
