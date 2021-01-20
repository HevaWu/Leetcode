/*
Given two arrays, write a function to compute their intersection.

Example 1:

Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2]
Example 2:

Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [9,4]
Note:

Each element in the result must be unique.
The result can be in any order.
*/

/*
Solution 1:
put one array into a set
then iteratively search another array element exist or not

Time Complexity: O(n+m), where n is nums1.count, m is nums2.count
Space Compelxity: O(n)
*/
class Solution {
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var set1 = Set(nums1)
        var res = [Int]()
        for n in nums2 {
            if set1.contains(n) {
                res.append(n)
                set1.remove(n)
            }
        }
        return res
    }
}