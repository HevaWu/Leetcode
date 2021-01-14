/*
You are given an integer array nums and an integer x. In one operation, you can either remove the leftmost or the rightmost element from the array nums and subtract its value from x. Note that this modifies the array for future operations.

Return the minimum number of operations to reduce x to exactly 0 if it's possible, otherwise, return -1.

 

Example 1:

Input: nums = [1,1,4,2,3], x = 5
Output: 2
Explanation: The optimal solution is to remove the last two elements to reduce x to zero.
Example 2:

Input: nums = [5,6,7,8,9], x = 4
Output: -1
Example 3:

Input: nums = [3,2,20,1,1,3], x = 10
Output: 5
Explanation: The optimal solution is to remove the last three elements and the first two elements (5 operations in total) to reduce x to zero.
 

Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 104
1 <= x <= 109

Hint 1: 
Think in reverse; instead of finding the minimum prefix + suffix, find the maximum subarray.

Hint 2:
Finding the maximum subarray is standard and can be done greedily.
*/

/*
Solution 2:
2 window
Optimize space by use 2 pointer

- use left & right to control the sum part
- once we find cur > target, move left pointer to check if existing cur == target case, if exist, compare (right-left+1) wih current res

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minOperations(_ nums: [Int], _ x: Int) -> Int {
        // find sum-x area
        let target = nums.reduce(into: -x) { res, val in
            res += val
        }
        if target < 0 { return -1 }
        if target == 0 { return nums.count }
        
        var left = 0
        var right = 0
        
        var cur = 0
        var res = Int.min
        while right < nums.count {
            cur += nums[right]
            while cur > target, left <= right {
                cur -= nums[left]
                left += 1
            }
            if cur == target {
                res = max(res, right-left+1)
            }
            right += 1
        }
        return res == Int.min ? -1 : nums.count-res
    }
}

/*
Solution 1:
Slide window

instead of find left, right part(left+right = x), 
we can convert problem to find mid part mid=sum-x

then use 2 slide window to solve the problem
- use map to memeo left sum, and save its index
- one loop to find maximum res, if not existing, return -1

TimeComplexity: O(n)
SpaceComplexity: O(n)
*/
class Solution {
    func minOperations(_ nums: [Int], _ x: Int) -> Int {
        // find sum-x area
        let target = nums.reduce(into: -x) { res, val in
            res += val
        }
        if target < 0 { return -1 }
        if target == 0 { return nums.count }
        
		// key is cur sum
		// val is index which 0 to i sum is cur
        var map = [Int: Int]()
        map[0] = -1
        
        var cur = 0
        var res = Int.min
        for i in 0..<nums.count {
            cur += nums[i]
            if let val = map[cur-target] {
                res = max(res, i-val)
            }
            // cur is unique
            map[cur] = i
        }
        return res == Int.min ? -1 : nums.count-res
    }
}