/*
You are given two integer arrays nums1 and nums2 of length n.

The XOR sum of the two integer arrays is (nums1[0] XOR nums2[0]) + (nums1[1] XOR nums2[1]) + ... + (nums1[n - 1] XOR nums2[n - 1]) (0-indexed).

For example, the XOR sum of [1,2,3] and [3,2,1] is equal to (1 XOR 3) + (2 XOR 2) + (3 XOR 1) = 2 + 0 + 2 = 4.
Rearrange the elements of nums2 such that the resulting XOR sum is minimized.

Return the XOR sum after the rearrangement.



Example 1:

Input: nums1 = [1,2], nums2 = [2,3]
Output: 2
Explanation: Rearrange nums2 so that it becomes [3,2].
The XOR sum is (1 XOR 3) + (2 XOR 2) = 2 + 0 = 2.
Example 2:

Input: nums1 = [1,0,3], nums2 = [5,3,4]
Output: 8
Explanation: Rearrange nums2 so that it becomes [5,4,3].
The XOR sum is (1 XOR 5) + (0 XOR 4) + (3 XOR 3) = 4 + 4 + 0 = 8.


Constraints:

n == nums1.length
n == nums2.length
1 <= n <= 14
0 <= nums1[i], nums2[i] <= 107
*/

/*
Solution 1:
DP + Bit

We have a tight constraint here: n <= 14. Thus, we can just try all combinations.

For each position i in the first array, we'll try all elements in the second array that haven't been chosen before. We can use a bit mask to represent the chosen elements.

To avoid re-computing the same subproblem, we memoise the result for each bit mask.

Time Complexity: O(n*n)
Space Complexity: O(2^n)
*/
class Solution {
    func minimumXORSum(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count

        var dp: [Int?] = Array(repeating: nil, count: 1<<n)
        return dfs(0, n, 0, nums1, nums2, &dp)
    }

    func dfs(_ i: Int, _ n: Int, _ mask: Int,
             _ nums1: [Int], _ nums2: [Int], _ dp: inout [Int?]) -> Int {
        if i >= n { return 0 }
        if let val = dp[mask] { return val }

        var val = Int.max

        for j in 0..<n {
            if (mask & (1<<j)) == 0 {
                val = min(val, (nums1[i] ^ nums2[j]) + dfs(i+1, n, mask+(1<<j), nums1, nums2, &dp))
            }
        }

        dp[mask] = val
        return val
    }
}
