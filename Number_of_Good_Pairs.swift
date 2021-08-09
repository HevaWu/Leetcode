/*
Given an array of integers nums.

A pair (i,j) is called good if nums[i] == nums[j] and i < j.

Return the number of good pairs.



Example 1:

Input: nums = [1,2,3,1,1,3]
Output: 4
Explanation: There are 4 good pairs (0,3), (0,4), (3,4), (2,5) 0-indexed.
Example 2:

Input: nums = [1,1,1,1]
Output: 6
Explanation: Each pair in the array are good.
Example 3:

Input: nums = [1,2,3]
Output: 0


Constraints:

1 <= nums.length <= 100
1 <= nums[i] <= 100

*/

/*
Solution 1:
map

key is num, val is number of elements in nums which is == num
check (k,v), if v > 1, we can build pair, v*(v-1) / 2

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        let n = nums.count

        // key is nums[i], val is index count which nums[index] == nums[i]
        var map = [Int: Int]()

        for num in nums {
            map[num, default: 0] += 1
        }

        var pair = 0
        for (k, v) in map {
            if v > 1 {
                pair += ((v * (v-1)) / 2)
            }
        }
        return pair
    }
}