/*
You are given an integer n. An array nums of length n + 1 is generated in the following way:

nums[0] = 0
nums[1] = 1
nums[2 * i] = nums[i] when 2 <= 2 * i <= n
nums[2 * i + 1] = nums[i] + nums[i + 1] when 2 <= 2 * i + 1 <= n
Return the maximum integer in the array nums​​​.

 

Example 1:

Input: n = 7
Output: 3
Explanation: According to the given rules:
  nums[0] = 0
  nums[1] = 1
  nums[(1 * 2) = 2] = nums[1] = 1
  nums[(1 * 2) + 1 = 3] = nums[1] + nums[2] = 1 + 1 = 2
  nums[(2 * 2) = 4] = nums[2] = 1
  nums[(2 * 2) + 1 = 5] = nums[2] + nums[3] = 1 + 2 = 3
  nums[(3 * 2) = 6] = nums[3] = 2
  nums[(3 * 2) + 1 = 7] = nums[3] + nums[4] = 2 + 1 = 3
Hence, nums = [0,1,1,2,1,3,2,3], and the maximum is 3.
Example 2:

Input: n = 2
Output: 1
Explanation: According to the given rules, the maximum between nums[0], nums[1], and nums[2] is 1.
Example 3:

Input: n = 3
Output: 2
Explanation: According to the given rules, the maximum between nums[0], nums[1], nums[2], and nums[3] is 2.
 

Constraints:

0 <= n <= 100

Hint 1:
Try generating the array.

Hint 2:
Make sure not to fall in the base case of 0.
*/

/*
Solution 2:
DP

start from 1, go through it by 2 steps each time

TimeComplexity: O(n)
SpaceComplexity: O(n)
*/
class Solution {
    func getMaximumGenerated(_ n: Int) -> Int {
        if n <= 1 { return n }
        
        var nums = Array(repeating: -1, count: n+1)
        nums[0] = 0
        nums[1] = 1
        
        var res = 0
        for i in 0...(n/2) {
            if i*2+1 > n { break }
            nums[i*2] = nums[i]
            nums[i*2+1] = nums[i] + nums[i+1]
            res = max(res, max(nums[i*2], nums[i*2+1]))
        }
        return res
    }
}

/*
Solution 1:
generate nums from n to 2
then find the largest one and return it

Time Complexity: O(n)
Space Complexity: O(n+1)
*/
class Solution {
    func getMaximumGenerated(_ n: Int) -> Int {
        if n <= 1 { return n }
        
        var nums = Array(repeating: -1, count: n+1)
        nums[0] = 0
        nums[1] = 1
        
        var res = 0
        for i in stride(from: n, through: 2, by: -1) {
            res = max(res, getNums(i, &nums))
        }
        return res
    }
    
    /// Return nums[i]
    func getNums(_ i: Int, _ nums: inout [Int]) -> Int {
        if nums[i] != -1 { return nums[i] }
        if i % 2 == 0 {
            nums[i] = getNums(i/2, &nums)
        } else {
            nums[i] = getNums(i/2, &nums) + getNums(i/2+1, &nums)
        }
        return nums[i]
    }
}