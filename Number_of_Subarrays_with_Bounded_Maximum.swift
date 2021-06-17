/*
We are given an array nums of positive integers, and two positive integers left and right (left <= right).

Return the number of (contiguous, non-empty) subarrays such that the value of the maximum array element in that subarray is at least left and at most right.

Example:
Input:
nums = [2, 1, 4, 3]
left = 2
right = 3
Output: 3
Explanation: There are three subarrays that meet the requirements: [2], [2, 1], [3].
Note:

left, right, and nums[i] will be an integer in the range [0, 109].
The length of nums will be in the range of [1, 50000].
*/

/*
Solution 2:
only keep 2 record
- lastInLR index
- lastLargerThanR index

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func numSubarrayBoundedMax(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
        var lastInLR = -1
        var lastLargerThanR = -1

        let n = nums.count
        var count = 0

        for i in 0..<n {
            if nums[i] > right {
                lastLargerThanR = i
            } else if nums[i] < left {
                if lastInLR >= 0 && lastInLR > lastLargerThanR {
                    count += lastInLR - lastLargerThanR
                }
            } else {
                lastInLR = i
                count += (i-lastLargerThanR)
            }
        }
        return count
    }
}

/*
Solution 1:
iterate nums

keep bellow record
- lessLeft: how many element less left
- inLR: how many element in [left, right]
- curMax: current max value in this subarray
- countinuousLessLeft: how many num keep less left until now

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func numSubarrayBoundedMax(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
        var count = 0

        var lessLeft = 0
        var inLR = 0
        var curMax = -1
        var countinuousLessLeft = 0

        for num in nums {
            if num > right {
                lessLeft = 0
                inLR = 0
                curMax = -1
                countinuousLessLeft = 0
            } else {
                curMax = max(num, curMax)
                if num < left {
                    lessLeft += 1
                    countinuousLessLeft += 1
                    if curMax >= left, curMax <= right {
                        count += (lessLeft + inLR - countinuousLessLeft)
                    }
                } else {
                    inLR += 1
                    count += (lessLeft + inLR)
                    countinuousLessLeft = 0
                }
            }
        }

        return count
    }
}