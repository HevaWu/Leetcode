/*
You are given two integer arrays nums1 and nums2. We write the integers of nums1 and nums2 (in the order they are given) on two separate horizontal lines.

We may draw connecting lines: a straight line connecting two numbers nums1[i] and nums2[j] such that:

nums1[i] == nums2[j], and
the line we draw does not intersect any other connecting (non-horizontal) line.
Note that a connecting line cannot intersect even at the endpoints (i.e., each number can only belong to one connecting line).

Return the maximum number of connecting lines we can draw in this way.



Example 1:


Input: nums1 = [1,4,2], nums2 = [1,2,4]
Output: 2
Explanation: We can draw 2 uncrossed lines as in the diagram.
We cannot draw 3 uncrossed lines, because the line from nums1[1] = 4 to nums2[2] = 4 will intersect the line from nums1[2]=2 to nums2[1]=2.
Example 2:

Input: nums1 = [2,5,1,2,5], nums2 = [10,5,2,1,5,2]
Output: 3
Example 3:

Input: nums1 = [1,3,7,1,7,5], nums2 = [1,9,2,5,1]
Output: 2


Constraints:

1 <= nums1.length, nums2.length <= 500
1 <= nums1[i], nums2[j] <= 2000
*/

/*
Solution 1:
DP

if nums1[i1] == nums2[i2]:
    dp[i1][i2] = 1 + dp[i1+1][i2+1]
dp[i1][i2] = max(dp[i1][i2], max(
    dp[i1+1][i2],
    dp[i1][i2+1]
))

Time Complexity: O(n1 * n2)
Space Complexity: O(n1 * n2)
*/
class Solution {
    func maxUncrossedLines(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n1 = nums1.count
        let n2 = nums2.count
        var dp: [[Int?]] = Array(repeating: Array(repeating: nil, count: n2), count: n1)
        return check(0, 0, n1, n2, nums1, nums2, &dp)
    }

    func check(_ i1: Int, _ i2: Int, _ n1: Int, _ n2: Int, _ nums1: [Int], _ nums2: [Int], _ dp: inout [[Int?]]) -> Int {
        if i1 >= n1 || i2 >= n2 { return 0 }
        if let val = dp[i1][i2] { return val }
        var val = 0
        if nums1[i1] == nums2[i2] {
            val = 1 + check(i1+1, i2+1, n1, n2, nums1, nums2, &dp)
        }
        val = max(val, max(
            check(i1+1, i2, n1, n2, nums1, nums2, &dp),
            check(i1, i2+1, n1, n2, nums1, nums2, &dp)
        ))
        dp[i1][i2] = val
        return val
    }
}
