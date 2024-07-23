/*
Given an array of integers nums, sort the array in increasing order based on the frequency of the values. If multiple values have the same frequency, sort them in decreasing order.

Return the sorted array.



Example 1:

Input: nums = [1,1,2,2,2,3]
Output: [3,1,1,2,2,2]
Explanation: '3' has a frequency of 1, '1' has a frequency of 2, and '2' has a frequency of 3.
Example 2:

Input: nums = [2,3,1,3,2]
Output: [1,3,3,2,2]
Explanation: '2' and '3' both have a frequency of 2, so they are sorted in decreasing order.
Example 3:

Input: nums = [-1,1,-6,4,5,-6,1,4,1]
Output: [5,-1,4,4,-6,-6,1,1,1]


Constraints:

1 <= nums.length <= 100
-100 <= nums[i] <= 100

*/

/*
Solution 1:
build frequency map, then sort it and regenerate the new nums array

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func frequencySort(_ nums: [Int]) -> [Int] {
        var freq = [Int: Int]()
        for num in nums {
            freq[num, default: 0] += 1
        }

        var sortedFreq = freq.sorted {
            n1, n2 -> Bool in
            return n1.1 == n2.1 ? n1.0 > n2.0 : n1.1 < n2.1
        }
        var newNums = [Int]()
        for (k, v) in sortedFreq {
            newNums.append(contentsOf: Array(repeating: k, count: v))
        }
        return newNums
    }
}
