/*
Given an array nums of n integers and an integer k, determine whether there exist two adjacent subarrays of length k such that both subarrays are strictly increasing. Specifically, check if there are two subarrays starting at indices a and b (a < b), where:

Both subarrays nums[a..a + k - 1] and nums[b..b + k - 1] are strictly increasing.
The subarrays must be adjacent, meaning b = a + k.
Return true if it is possible to find two such subarrays, and false otherwise.



Example 1:

Input: nums = [2,5,7,8,9,2,3,4,3,1], k = 3

Output: true

Explanation:

The subarray starting at index 2 is [7, 8, 9], which is strictly increasing.
The subarray starting at index 5 is [2, 3, 4], which is also strictly increasing.
These two subarrays are adjacent, so the result is true.
Example 2:

Input: nums = [1,2,3,4,4,4,4,5,6,7], k = 5

Output: false



Constraints:

2 <= nums.length <= 100
1 < 2 * k <= nums.length
-1000 <= nums[i] <= 1000
*/


/*
Solution 1:
iterate nums array
when finding decrease, check current 2 array record situation and update

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func hasIncreasingSubarrays(_ nums: [Int], _ k: Int) -> Bool {
        let n = nums.count
        if k == 1 && n >= 2 { return true }
        var arr1Num = 1
        var arr2Num = 0
        for i in 1..<n {
            if nums[i] > nums[i-1] {
                if arr1Num < k {
                    arr1Num += 1
                } else if arr1Num == k {
                    arr2Num += 1
                    if arr2Num == k {
                        return true
                    }
                }
            } else {
                // cutted update 2 num
                if arr2Num == 0 {
                    // reset first array count
                    arr1Num = arr1Num < k ? 1 : k
                    arr2Num = arr1Num == k ? 1 : 0
                } else if arr2Num > 0 {
                    // reset both first and second array count
                    let indexConnect = i - arr2Num
                    let connectIncrease = nums[indexConnect] > nums[indexConnect-1]
                    arr1Num = connectIncrease ? k : 1
                    arr2Num = arr1Num == k ? 1 : 0
                }
                // print(i, arr1Num, arr2Num)
            }
        }
        return false
    }
}
