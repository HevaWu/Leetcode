/* 
Given an array of integers nums and an integer k. A continuous subarray is called nice if there are k odd numbers on it.

Return the number of nice sub-arrays.

 

Example 1:

Input: nums = [1,1,2,1,1], k = 3
Output: 2
Explanation: The only sub-arrays with 3 odd numbers are [1,1,2,1] and [1,2,1,1].
Example 2:

Input: nums = [2,4,6], k = 1
Output: 0
Explanation: There are no odd numbers in the array.
Example 3:

Input: nums = [2,2,2,1,2,2,1,2,2,2], k = 2
Output: 16
 

Constraints:

1 <= nums.length <= 50000
1 <= nums[i] <= 10^5
1 <= k <= nums.length
*/

/*
Solution 1:
use freq to record the "number of summary which contains i odd number"

Tim Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func numberOfSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        // freq[i] is the number of subarray which continas i odd number
        var freq = Array(repeating: 0, count: n+1)
        freq[0] = 1
        var res = 0
        var odd = 0
        for num in nums {
            odd += ((num & 1) == 1 ? 1: 0)
            if odd - k >= 0 {
                res += freq[odd-k]
            }
            freq[odd] += 1
        }
        return res
    }
}