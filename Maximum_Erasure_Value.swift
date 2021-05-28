/*
You are given an array of positive integers nums and want to erase a subarray containing unique elements. The score you get by erasing the subarray is equal to the sum of its elements.

Return the maximum score you can get by erasing exactly one subarray.

An array b is called to be a subarray of a if it forms a contiguous subsequence of a, that is, if it is equal to a[l],a[l+1],...,a[r] for some (l,r).



Example 1:

Input: nums = [4,2,4,5,6]
Output: 17
Explanation: The optimal subarray here is [2,4,5,6].
Example 2:

Input: nums = [5,2,1,2,5,2,1,2,5]
Output: 8
Explanation: The optimal subarray here is [5,2,1] or [1,2,5].


Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 104
*/

/*
Solution 1:
2 pointer

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func maximumUniqueSubarray(_ nums: [Int]) -> Int {
        let n = nums.count

        var current = Set<Int>()
        var left = 0
        var right = 0

        var curScore = 0
        var maxScore = 0

        while right < n {
            curScore += nums[right]

            while current.contains(nums[right]), left < right {
                // shorten left until current subarray unique again
                current.remove(nums[left])
                curScore -= nums[left]
                left += 1
            }

            maxScore = max(maxScore, curScore)
            current.insert(nums[right])
            right += 1
        }

        return maxScore
    }
}