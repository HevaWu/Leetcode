/*
Given two integer arrays nums1 and nums2, sorted in non-decreasing order, return the minimum integer common to both arrays. If there is no common integer amongst nums1 and nums2, return -1.

Note that an integer is said to be common to nums1 and nums2 if both arrays have at least one occurrence of that integer.



Example 1:

Input: nums1 = [1,2,3], nums2 = [2,4]
Output: 2
Explanation: The smallest element common to both arrays is 2, so we return 2.
Example 2:

Input: nums1 = [1,2,3,6], nums2 = [2,3,4,5]
Output: 2
Explanation: There are two common elements in the array 2 and 3 out of which 2 is the smallest, so 2 is returned.


Constraints:

1 <= nums1.length, nums2.length <= 105
1 <= nums1[i], nums2[j] <= 109
Both nums1 and nums2 are sorted in non-decreasing order.
*/

/*
Solution 1:
check by order
the two array already sorted, check them one by one to see if there is any minimum common value

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func getCommon(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var i1 = 0
        var i2 = 0
        var n1 = nums1.count
        var n2 = nums2.count
        while i1 < n1, i2 < n2 {
            if nums1[i1] == nums2[i2] {
                return nums1[i1]
            }
            if nums1[i1] < nums2[i2] {
                i1 += 1
            } else {
                i2 += 1
            }
        }
        return -1
    }
}
