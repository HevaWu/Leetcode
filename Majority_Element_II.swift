/*
Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times.



Example 1:

Input: nums = [3,2,3]
Output: [3]
Example 2:

Input: nums = [1]
Output: [1]
Example 3:

Input: nums = [1,2]
Output: [1,2]


Constraints:

1 <= nums.length <= 5 * 104
-109 <= nums[i] <= 109


Follow up: Could you solve the problem in linear time and in O(1) space?
*/


/*
Solution 1:
map

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func majorityElement(_ nums: [Int]) -> [Int] {
        let n = nums.count
        let size = n/3
        var map = [Int: Int]()
        for num in nums {
            map[num, default: 0] += 1
        }

        var res = [Int]()
        for (k,v) in map {
            if v > size {
                res.append(k)
            }
        }
        return res
    }
}
