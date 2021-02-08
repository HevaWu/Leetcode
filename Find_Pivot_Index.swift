/*
Given an array of integers nums, calculate the pivot index of this array.

The pivot index is the index where the sum of all the numbers strictly to the left of the index is equal to the sum of all the numbers strictly to the index's right.

If the index is on the left edge of the array, then the left sum is 0 because there are no elements to the left. This also applies to the right edge of the array.

Return the leftmost pivot index. If no such index exists, return -1.

 

Example 1:

Input: nums = [1,7,3,6,5,6]
Output: 3
Explanation:
The pivot index is 3.
Left sum = nums[0] + nums[1] + nums[2] = 1 + 7 + 3 = 11
Right sum = nums[4] + nums[5] = 5 + 6 = 11
Example 2:

Input: nums = [1,2,3]
Output: -1
Explanation:
There is no index that satisfies the conditions in the problem statement.
Example 3:

Input: nums = [2,1,-1]
Output: 0
Explanation:
The pivot index is 0.
Left sum = 0 (no elements to the left of index 0)
Right sum = nums[1] + nums[2] = 1 + -1 = 0
 

Constraints:

1 <= nums.length <= 104
-1000 <= nums[i] <= 1000

Hint 1:
We can precompute prefix sums P[i] = nums[0] + nums[1] + ... + nums[i-1]. Then for each index, the left sum is P[i], and the right sum is P[P.length - 1] - P[i] - nums[i].
*/

/*
Solution 2:
optimize, O(1) space
*/
class Solution {
    func pivotIndex(_ nums: [Int]) -> Int {
        var sum = 0

        let n = nums.count
        for i in 0..<n {
            sum += nums[i]
        }
        // print(numSum)
        
        var leftSum = 0
        for i in 0..<n {
            if leftSum == sum - leftSum - nums[i] {
                return i
            }
            leftSum += nums[i]
        }
        return -1
    }
}

/*
Solution 1

numSum[i] is nums[1]+nums[2]+...+nums[i]
for finding pivot, we can check if there is an index that
numSum[i] - nums[i] == numSum[n-1] - numSum[i]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func pivotIndex(_ nums: [Int]) -> Int {
        var numSum = nums
        
        var cur = 0
        let n = nums.count
        for i in 0..<n {
            cur += numSum[i]
            numSum[i] = cur
        }
        // print(numSum)
        
        for i in 0..<n {
            if numSum[i] - nums[i] == numSum[n-1] - numSum[i] {
                return i
            }
        }
        return -1
    }
}