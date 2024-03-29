/*
You are given an integer array nums and a positive integer k.

Return the number of subarrays where the maximum element of nums appears at least k times in that subarray.

A subarray is a contiguous sequence of elements within an array.



Example 1:

Input: nums = [1,3,2,3,3], k = 2
Output: 6
Explanation: The subarrays that contain the element 3 at least 2 times are: [1,3,2,3], [1,3,2,3,3], [3,2,3], [3,2,3,3], [2,3,3] and [3,3].
Example 2:

Input: nums = [1,4,2,1], k = 3
Output: 0
Explanation: No subarray contains the element 4 at least 3 times.


Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 106
1 <= k <= 105
*/

/*
Solution 1:
two pointer

- find maxNum
- two pointer find all continuos subarray

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        var maxNum = nums[0]
        for i in 0..<n {
            maxNum = max(maxNum, nums[i])
        }

        var l = 0
        var r = 0
        var maxNumCount = 0
        var res = 0
        while r < n {
            if nums[r] == maxNum {
                maxNumCount += 1
            }
            while maxNumCount >= k {
                if nums[l] == maxNum {
                    maxNumCount -= 1
                }
                l += 1
                res += (n-r)
            }
            r += 1
        }
        return res
    }
}
