/*
Given an integer array nums, return the maximum difference between two successive elements in its sorted form. If the array contains less than two elements, return 0.

You must write an algorithm that runs in linear time and uses linear extra space.



Example 1:

Input: nums = [3,6,9,1]
Output: 3
Explanation: The sorted form of the array is [1,3,6,9], either (3,6) or (6,9) has the maximum difference 3.
Example 2:

Input: nums = [10]
Output: 0
Explanation: The array contains less than 2 elements, therefore return 0.


Constraints:

1 <= nums.length <= 104
0 <= nums[i] <= 109
*/

/*
Solution 1:

Idea:
- find nums.minV and nums.maxV first
- try to put all element in nums in bucket
  - var bucketSize = max(1, (maxV-minV)/(n-1))
  - var bucketNum = (maxV-minV)/bucketSize + 1
  - bucketId = (num-minV)/bucketSize
- for now, bucketMin and bucketMax should record min or max value in each bucket
- go through them, and check if gap can be extended
  - if bucketCount[i] > 0 {
        gap = max(gap, bucketMin[i]-lastMax)
        lastMax = bucketMax[i]
    }

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maximumGap(_ nums: [Int]) -> Int {
        let n = nums.count
        if n < 2 { return 0 }
        if n == 2 { return abs(nums[0]-nums[1]) }

        var minV = nums[0]
        var maxV = nums[0]

        for num in nums {
            minV = min(minV, num)
            maxV = max(maxV, num)
        }

        var bucketSize = max(1, (maxV-minV)/(n-1))
        var bucketNum = (maxV-minV)/bucketSize + 1

        if bucketNum <= 1 { return maxV - minV }

        var bucketMax = Array(repeating: Int.min, count: bucketNum)
        var bucketMin = Array(repeating: Int.max, count: bucketNum)
        var bucketCount = Array(repeating: 0, count: bucketNum)

        var bucketId = 0
        for num in nums {
            bucketId = (num-minV)/bucketSize
            bucketCount[bucketId] += 1
            bucketMin[bucketId] = min(bucketMin[bucketId], num)
            bucketMax[bucketId] = max(bucketMax[bucketId], num)
        }

        var lastMax = minV
        var gap = Int.min
        for i in 0..<bucketNum {
            if bucketCount[i] > 0 {
                gap = max(gap, bucketMin[i]-lastMax)
                lastMax = bucketMax[i]
            }
        }

        return gap
    }
}