/*
Given an integer array nums, your goal is to make all elements in nums equal. To complete one operation, follow these steps:

Find the largest value in nums. Let its index be i (0-indexed) and its value be largest. If there are multiple elements with the largest value, pick the smallest i.
Find the next largest value in nums strictly smaller than largest. Let its value be nextLargest.
Reduce nums[i] to nextLargest.
Return the number of operations to make all elements in nums equal.



Example 1:

Input: nums = [5,1,3]
Output: 3
Explanation: It takes 3 operations to make all elements in nums equal:
1. largest = 5 at index 0. nextLargest = 3. Reduce nums[0] to 3. nums = [3,1,3].
2. largest = 3 at index 0. nextLargest = 1. Reduce nums[0] to 1. nums = [1,1,3].
3. largest = 3 at index 2. nextLargest = 1. Reduce nums[2] to 1. nums = [1,1,1].
Example 2:

Input: nums = [1,1,1]
Output: 0
Explanation: All elements in nums are already equal.
Example 3:

Input: nums = [1,1,2,2,3]
Output: 4
Explanation: It takes 4 operations to make all elements in nums equal:
1. largest = 3 at index 4. nextLargest = 2. Reduce nums[4] to 2. nums = [1,1,2,2,2].
2. largest = 2 at index 2. nextLargest = 1. Reduce nums[2] to 1. nums = [1,1,1,2,2].
3. largest = 2 at index 3. nextLargest = 1. Reduce nums[3] to 1. nums = [1,1,1,1,2].
4. largest = 2 at index 4. nextLargest = 1. Reduce nums[4] to 1. nums = [1,1,1,1,1].


Constraints:

1 <= nums.length <= 5 * 104
1 <= nums[i] <= 5 * 104
*/

/*
Solution 2:
DP

- sort array
- if nums[i-1] > nums[i], dp[i] = dp[i-1]+i
- else, dp[i] = dp[i-1]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func reductionOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return 0 }
        var nums = nums.sorted(by: >)

        // dp[i] operations make [0...i] equal to nums[i]
        var dp = Array(repeating: 0, count: n)
        for i in 1..<n {
            if nums[i-1] > nums[i] {
                dp[i] = dp[i-1] + i
            } else {
                dp[i] = dp[i-1]
            }
        }
        // print(dp)
        return dp[n-1]
    }
 }

/*
Solution 1:
TLE
*/
class Solution {
    func reductionOperations(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return 0 }
        var nums = nums.sorted(by: >)

        var operation = 0
        while true {
            let (finded, index) = canFind(nums, n)
            if finded {
                nums[index] = nums[index+1]
                operation += 1
            } else {
                return operation
            }
        }
        return -1
    }

    // return (true, index) if can find strictly large element, and index
    // return (false, -1) if cannot find strictly large => all of element in current nums are equal to each other
    func canFind(_ nums: [Int], _ n: Int) -> (finded: Bool, index: Int) {
        for i in 0..<(n-1) {
            if nums[i] > nums[i+1] {
                return (true, i)
            }
        }
        return (false, -1)
    }
 }