/*
Given an array nums of integers, return the length of the longest arithmetic subsequence in nums.

Note that:

A subsequence is an array that can be derived from another array by deleting some or no elements without changing the order of the remaining elements.
A sequence seq is arithmetic if seq[i + 1] - seq[i] are all the same value (for 0 <= i < seq.length - 1).


Example 1:

Input: nums = [3,6,9,12]
Output: 4
Explanation:  The whole array is an arithmetic sequence with steps of length = 3.
Example 2:

Input: nums = [9,4,7,2,10]
Output: 3
Explanation:  The longest arithmetic subsequence is [4,7,10].
Example 3:

Input: nums = [20,1,15,3,10,5,8]
Output: 4
Explanation:  The longest arithmetic subsequence is [20,15,10,5].


Constraints:

2 <= nums.length <= 1000
0 <= nums[i] <= 500
*/

/*
Solution 1:
DP

keep find [previous, gap] to help calculate current [num, gap] longest subarray

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func longestArithSeqLength(_ nums: [Int]) -> Int {
        // the possible difference (nums[j] - nums[i] where j > i)
        var previous = Set<Int>()
        let n = nums.count
        // key is [previousNum, gap]
        // val is the longest arithmetic subsequence with previousNum and keep gap as diff
        var map = [[Int]: Int]()
        var longest = 1

        for num in nums {
            for prevNum in previous {
                let gap = num - prevNum
                map[[num, gap]] = max(
                    map[[num, gap], default: 2],
                    map[[prevNum, gap], default: 1] + 1)
                longest = max(longest, map[[num, gap]]!)
            }
            if !previous.contains(num) {
                map[[num, 0]] = 1
            }
            previous.insert(num)
        }
        return longest
    }
}
