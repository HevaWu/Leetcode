/*
Given an integer array arr and an integer k, modify the array by repeating it k times.

For example, if arr = [1, 2] and k = 3 then the modified array will be [1, 2, 1, 2, 1, 2].

Return the maximum sub-array sum in the modified array. Note that the length of the sub-array can be 0 and its sum in that case is 0.

As the answer can be very large, return the answer modulo 109 + 7.



Example 1:

Input: arr = [1,2], k = 3
Output: 9
Example 2:

Input: arr = [1,-2,1], k = 5
Output: 2
Example 3:

Input: arr = [-1,-2], k = 7
Output: 0


Constraints:

1 <= arr.length <= 105
1 <= k <= 105
-104 <= arr[i] <= 104

*/

/*
Solution 1:

find
- one_sum: sum of arr
- max_sub: maximum result of contiguous element sub arr
- max_prefix: maximum prefix of arr
- max_suffix: maximum suffix of arr

for k = 1, return max_sub
for k > 1, check max of
- max_sub
- if oneSum > 0,
  - max_prefix + max_suffix + oneSum * (k-2)
  - max_prefix + max_suffix

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func kConcatenationMaxSum(_ arr: [Int], _ k: Int) -> Int {
        let n = arr.count
        let mod = Int(1e9+7)

        var cur = 0
        var max_sub = 0
        var one_sum = 0
        for i in 0..<n {
            one_sum += arr[i]

            cur = cur > 0 ? cur+arr[i] : arr[i]
            max_sub = max(max_sub, cur)
        }

        if k == 1 { return max_sub }

        var max_prefix = Int.min
        var max_suffix = Int.min

        cur = 0
        for i in 0..<n {
            cur += arr[i]
            max_prefix = max(max_prefix, cur)
        }

        cur = 0
        for i in stride(from: n-1, through: 0, by: -1) {
            cur += arr[i]
            max_suffix = max(max_suffix, cur)
        }


        if one_sum > 0 {
            return max(max_prefix + max_suffix + one_sum * (k-2), max_sub) % mod
        } else {
            return max(max_prefix + max_suffix, max_sub) % mod
        }
    }
}