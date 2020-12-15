/*
Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.

 

Example 1:

Input: nums = [-4,-1,0,3,10]
Output: [0,1,9,16,100]
Explanation: After squaring, the array becomes [16,1,0,9,100].
After sorting, it becomes [0,1,9,16,100].
Example 2:

Input: nums = [-7,-3,2,3,11]
Output: [4,9,9,49,121]
 

Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
nums is sorted in non-decreasing order.
*/

/*
Solution 1:
brute force
for each number, get its squaring num first, then use Swift Array sort function to sort it.

Time Complexity:
O(nlogn)
*/
class Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        return nums.map { $0 * $0 }.sorted()
    }
}

/*
Solution 2:
find the first positive index first: p_i
then according to it find the non-positive index: n_i

compare nums[n_i]*nums[n_i] and nums[p_i]*nums[p_i]
push the smaller one into res array

Time Complexity:
O(n)
*/
class Solution {
    func sortedSquares(_ nums: [Int]) -> [Int] {
        if nums[0] >= 0 { return nums.map { $0 * $0 } }
        
        let n = nums.count
        var res = [Int]()
        
        // positive number index
        guard var p_i = nums.firstIndex(where: { $0 > 0 }) else {
            // no positive number, all negative, return reversed nums squared
            return stride(from: n-1, through: 0, by: -1).map { nums[$0]*nums[$0] }
        }
        
        // non-positive index
        var n_i: Int = p_i - 1
        
        // compare nums[n_i] squared and nums[p_i] squared
        // pick the smaller one and append it into res array
        while n_i >= 0 && p_i < n {
            var n_s = nums[n_i] * nums[n_i]
            var p_s = nums[p_i] * nums[p_i]
            if n_s <= p_s {
                res.append(n_s)
                n_i -= 1
            } else {
                res.append(p_s)
                p_i += 1
            }
        }
        
        while n_i >= 0 {
            res.append(nums[n_i]*nums[n_i])
            n_i -= 1
        }
        
        while p_i < n {
            res.append(nums[p_i]*nums[p_i])
            p_i += 1
        }
        
        return res
    }
}