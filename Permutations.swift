/*
Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

 

Example 1:

Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
Example 2:

Input: nums = [0,1]
Output: [[0,1],[1,0]]
Example 3:

Input: nums = [1]
Output: [[1]]
 

Constraints:

1 <= nums.length <= 6
-10 <= nums[i] <= 10
All the integers of nums are unique.
*/

/*
Solution 2:
BackTrack
improve by using swap to update nums
*/
class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var nums = nums
        var res = [[Int]]()
        backTrack(0, &nums, &res)
        return res
    }
    
    func backTrack(_ left: Int, _ nums: inout [Int], _ res: inout [[Int]]) {
        if left == nums.count { 
            res.append(nums)
            return
        }
        
        for i in left..<nums.count {
            nums.swapAt(left, i)
            backTrack(left+1, &nums, &res)
            nums.swapAt(left, i)
        }
    }
}

/*
Solution 1: 
BackTrack

TimeComplexity: O(n!)
SpaceComplexity: O(n!)
*/
class Solution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var nums = Array(nums)
        let n = nums.count
        var res = [[Int]]()
        var cur = [Int]()
        backTrack(&nums, n, &cur, &res)
        return res
    }
    
    func backTrack(_ nums: inout [Int], _ n: Int, _ cur: inout [Int], _ res: inout [[Int]]) {
        if cur.count == n { 
            res.append(cur)
            return
        }
        if nums.isEmpty { return }
        
        for i in 0..<nums.count {
            let val = nums[i]
            cur.append(val)
            nums.remove(at: i)
            
            backTrack(&nums, n, &cur, &res)
            
            nums.insert(val, at: i)
            cur.removeLast()
        }
    }
}