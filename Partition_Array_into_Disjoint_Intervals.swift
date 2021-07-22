/*
Given an array nums, partition it into two (contiguous) subarrays left and right so that:

Every element in left is less than or equal to every element in right.
left and right are non-empty.
left has the smallest possible size.
Return the length of left after such a partitioning.  It is guaranteed that such a partitioning exists.



Example 1:

Input: nums = [5,0,3,8,6]
Output: 3
Explanation: left = [5,0,3], right = [8,6]
Example 2:

Input: nums = [1,1,1,0,6,12]
Output: 4
Explanation: left = [1,1,1,0], right = [6,12]


Note:

2 <= nums.length <= 30000
0 <= nums[i] <= 106
It is guaranteed there is at least one way to partition nums as described.
*/

/*
Solution 2:
make 2 array for maxLeft, minRight
Then maxLeft[i] and minRight[i+1]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func partitionDisjoint(_ nums: [Int]) -> Int {
        let n = nums.count

        var maxLeft = Array(repeating: 0, count: n)
        var minRight = Array(repeating: 0, count: n)

        maxLeft[0] = nums[0]
        minRight[n-1] = nums[n-1]

        for i in 1..<n {
            maxLeft[i] = max(maxLeft[i-1], nums[i])
        }

        for i in stride(from: n-2, through: 0, by: -1) {
            minRight[i] = min(minRight[i+1], nums[i])
        }

        // print(maxLeft, minRight)

        for i in 0..<(n-1) {
            // for ith position, compare [0...i] and [i+1 ...]
            if maxLeft[i] <= minRight[i+1] {
                return i+1
            }
        }
        return -1
    }
}

/*
Solution 1:
iterate whole nums array

TLE

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func partitionDisjoint(_ nums: [Int]) -> Int {
        let n = nums.count

        for i in 1..<n {
            if canPartition(i, nums, n) {
                return i
            }
        }
        return -1
    }

    func canPartition(_ index: Int, _ nums: [Int], _ n: Int) -> Bool {
        var maxVal = -1
        for i in 0..<index {
            maxVal = max(maxVal, nums[i])
        }

        for i in index..<n {
            if nums[i] < maxVal {
                return false
            }
        }
        return true
    }
}