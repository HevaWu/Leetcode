/*
Given a binary array, find the maximum number of consecutive 1s in this array.

Example 1:
Input: [1,1,0,1,1,1]
Output: 3
Explanation: The first two digits or the last three digits are consecutive 1s.
    The maximum number of consecutive 1s is 3.
Note:

The input array will only contain 0 and 1.
The length of input array is a positive integer and will not exceed 10,000

Hint 1:
You need to think about two things as far as any window is concerned. One is the starting point for the window. How do you detect that a new window of 1s has started? The next part is detecting the ending point for this window. How do you detect the ending point for an existing window? If you figure these two things out, you will be able to detect the windows of consecutive ones. All that remains afterward is to find the longest such window and return the size.
*/

/*
Solution 2:
optimize solution 1

Time Complexity: O(n)
Space ComplexityL O(1)
*/
class Solution {
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        let n = nums.count
        var res = 0
        var cur = 0
        
        for num in nums {
            if num == 0 {
                res = max(res, cur)
                cur = 0
            } else {
                cur += 1
            }
        }
        return max(res, cur)
    }
}

/*
Solution 1:
iterative

check if cur index == 1, if so, check consecutive 1s now, and update res

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        let n = nums.count
        var res = 0
        
        var index = 0
        while index < n {
            if nums[index] == 1 {
                let cur = index
                while index < n, nums[index] == 1 {
                    index += 1
                }
                res = max(res, index-cur)
            } else {
                index += 1
            }
        }
        return res
    }
}