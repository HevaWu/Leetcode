/*
Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

The number of elements initialized in nums1 and nums2 are m and n respectively. You may assume that nums1 has enough space (size that is equal to m + n) to hold additional elements from nums2.

 

Example 1:

Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
Output: [1,2,2,3,5,6]
Example 2:

Input: nums1 = [1], m = 1, nums2 = [], n = 0
Output: [1]
 

Constraints:

0 <= n, m <= 200
1 <= n + m <= 200
nums1.length == m + n
nums2.length == n
-109 <= nums1[i], nums2[i] <= 109

Hint 1:
You can easily solve this problem if you simply think about two elements at a time rather than two arrays. We know that each of the individual arrays is sorted. What we don't know is how they will intertwine. Can we take a local decision and arrive at an optimal solution?

Hint 2:
If you simply consider one element each at a time from the two arrays and make a decision and proceed accordingly, you will arrive at the optimal solution.
*/

/*
Solution 1:
back track

start from n+m-1
find larger one, and put it into nums1 array
loop until j >= 0 is enough, since we only need to add nums2 array into nums1

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m-1
        var j = n-1
        var index = n+m-1
        
        while j >= 0 {
            if i >= 0, nums1[i] >= nums2[j] {
                nums1[index] = nums1[i]
                i -= 1
            } else {
                nums1[index] = nums2[j]
                j -= 1
            }
            index -= 1
        }
    }
}