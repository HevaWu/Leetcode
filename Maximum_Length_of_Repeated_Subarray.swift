/*
Given two integer arrays nums1 and nums2, return the maximum length of a subarray that appears in both arrays.



Example 1:

Input: nums1 = [1,2,3,2,1], nums2 = [3,2,1,4,7]
Output: 3
Explanation: The repeated subarray with maximum length is [3,2,1].
Example 2:

Input: nums1 = [0,0,0,0,0], nums2 = [0,0,0,0,0]
Output: 5


Constraints:

1 <= nums1.length, nums2.length <= 1000
0 <= nums1[i], nums2[i] <= 100
*/

/*
Solution 2:
Sliding window

The initial position and the directions in which we slide. One step means shifting the top array by one position (index) to the right, or the the bottom array by one position (index) to the left:
            [1,2,3,2,1]   -->
            <--    [3,2,1,4,7]

            [1,2,3,2,1]
                [3,2,1,4,7]

            [1,2,3,2,1]      -->
    <--      [3,2,1,4,7]

and so on

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func findLength(_ nums1: [Int], _ nums2: [Int]) -> Int {
        if nums1.count > nums2.count { return findLength(nums2, nums1) }

        // n1 < n2
        let n1 = nums1.count
        let n2 = nums2.count

        var maxLen = 0
        for i in 0..<(n1+n2-1) {
            var s1 = max(0, n1-1-i)
            var s2 = max(0, i-(n1-1))
            var count = 0

            while s1 < n1, s2 < n2 {
                if nums1[s1] == nums2[s2] {
                    count += 1
                    maxLen = max(maxLen, count)
                } else {
                    count = 0
                }
                s1 += 1
                s2 += 1
            }
        }

        return maxLen
    }
}

/*
Solution 1
DP

let dp[i][j] be the longest common prefix of A[i:] and B[j:]. Whenever A[i] == B[j], we know dp[i][j] = dp[i+1][j+1] + 1. Also, the answer is max(dp[i][j]) over all i, j.

We can perform bottom-up dynamic programming to find the answer based on this recurrence. Our loop invariant is that the answer is already calculated correctly and stored in dp for any larger i, j.

Time Complexity: O(M*N), where M,N are the lengths of A, B.
Space Complexity: O(M*N), the space used by dp.
*/
class Solution {
    func findLength(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n1 = nums1.count
        let n2 = nums2.count

        // dp[i][j] common sub-array len of nums1[i...] nums2[j...]
        var dp = Array(
            repeating: Array(repeating: 0, count: n2),
            count: n1
        )

        var res = 0
        for i1 in stride(from: n1-1, through: 0, by: -1) {
            for i2 in stride(from: n2-1, through: 0, by: -1) {
                if nums1[i1] == nums2[i2] {
                    dp[i1][i2] = (i1+1 < n1 && i2+1<n2 ? dp[i1+1][i2+1] : 0) + 1
                    res = max(res, dp[i1][i2])
                }
            }
        }

        return res
    }
}