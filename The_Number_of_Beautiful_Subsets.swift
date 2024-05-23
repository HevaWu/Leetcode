/*
You are given an array nums of positive integers and a positive integer k.

A subset of nums is beautiful if it does not contain two integers with an absolute difference equal to k.

Return the number of non-empty beautiful subsets of the array nums.

A subset of nums is an array that can be obtained by deleting some (possibly none) elements from nums. Two subsets are different if and only if the chosen indices to delete are different.



Example 1:

Input: nums = [2,4,6], k = 2
Output: 4
Explanation: The beautiful subsets of the array nums are: [2], [4], [6], [2, 6].
It can be proved that there are only 4 beautiful subsets in the array [2,4,6].
Example 2:

Input: nums = [1], k = 1
Output: 1
Explanation: The beautiful subset of the array nums is [1].
It can be proved that there is only 1 beautiful subset in the array [1].


Constraints:

1 <= nums.length <= 20
1 <= nums[i], k <= 1000
*/

/*
Solution 1:
backtrack

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func beautifulSubsets(_ nums: [Int], _ k: Int) -> Int {
        var map = [Int: Int]()
        return check(nums, 0, k, &map) - 1
    }

    func check(_ nums: [Int], _ index: Int, _ k: Int, _ map: inout [Int: Int]) -> Int {
        if index == nums.count { return 1 }
        var take = 0
        if map[nums[index] - k, default: 0] == 0,
        map[nums[index] + k, default: 0] == 0 {
            map[nums[index], default: 0] += 1
            take = check(nums, index+1, k, &map)
            map[nums[index], default: 0] -= 1
        }
        var notTake = check(nums, index+1, k, &map)
        return take + notTake
    }
}
