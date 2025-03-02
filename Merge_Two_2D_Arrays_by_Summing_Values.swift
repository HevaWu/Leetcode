/*
You are given two 2D integer arrays nums1 and nums2.

nums1[i] = [idi, vali] indicate that the number with the id idi has a value equal to vali.
nums2[i] = [idi, vali] indicate that the number with the id idi has a value equal to vali.
Each array contains unique ids and is sorted in ascending order by id.

Merge the two arrays into one array that is sorted in ascending order by id, respecting the following conditions:

Only ids that appear in at least one of the two arrays should be included in the resulting array.
Each id should be included only once and its value should be the sum of the values of this id in the two arrays. If the id does not exist in one of the two arrays, then assume its value in that array to be 0.
Return the resulting array. The returned array must be sorted in ascending order by id.



Example 1:

Input: nums1 = [[1,2],[2,3],[4,5]], nums2 = [[1,4],[3,2],[4,1]]
Output: [[1,6],[2,3],[3,2],[4,6]]
Explanation: The resulting array contains the following:
- id = 1, the value of this id is 2 + 4 = 6.
- id = 2, the value of this id is 3.
- id = 3, the value of this id is 2.
- id = 4, the value of this id is 5 + 1 = 6.
Example 2:

Input: nums1 = [[2,4],[3,6],[5,5]], nums2 = [[1,3],[4,3]]
Output: [[1,3],[2,4],[3,6],[4,3],[5,5]]
Explanation: There are no common ids, so we just include each id with its value in the resulting list.


Constraints:

1 <= nums1.length, nums2.length <= 200
nums1[i].length == nums2[j].length == 2
1 <= idi, vali <= 1000
Both arrays contain unique ids.
Both arrays are in strictly ascending order by id.
*/

/*
Solution 1:
Use nums1 as base, iterate nums2 check the add, or insert

Time Complexity: O(max(n1, n2))
Space Complexity: O(1)
*/
class Solution {
    func mergeArrays(_ nums1: [[Int]], _ nums2: [[Int]]) -> [[Int]] {
        var res = nums1
        var i1 = 0
        var i2 = 0
        while i1 < res.count {
            if i2 < nums2.count {
                if res[i1][0] == nums2[i2][0] {
                    res[i1][1] += nums2[i2][1]
                    i1 += 1
                    i2 += 1
                } else if res[i1][0] < nums2[i2][0] {
                    i1 += 1
                } else if res[i1][0] > nums2[i2][0] {
                    // add nums2[i2] into res
                    res.insert(nums2[i2], at: i1)
                    // print(res)
                    i1 += 1
                    i2 += 1
                }
            } else {
                break
            }
        }
        while i2 < nums2.count {
            res.append(nums2[i2])
            i2 += 1
        }
        return res
    }
}
