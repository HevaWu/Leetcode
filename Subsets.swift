/*
Given an integer array nums of unique elements, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.

 

Example 1:

Input: nums = [1,2,3]
Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
Example 2:

Input: nums = [0]
Output: [[],[0]]
 

Constraints:

1 <= nums.length <= 10
-10 <= nums[i] <= 10
All the numbers of nums are unique.
*/

/*
Solution 2
lexicographc(binay sorted) subset
bitmask

The idea is that we map each subset to a bitmask of length n, where 1 on the ith position in bitmask means the presence of nums[i] in the subset, and 0 means its absence.

use 2^n ... 2^(n+1) to generate bitmask
always check mask[j+1] then append nums[j]

Time Complexity: O(n*2^n)
Space Complexity: O(n* 2^n)
*/
class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var res = [[Int]]()
        let n = nums.count
        
        for i in Int(pow(Double(2), Double(n)))..<Int(pow(Double(2), Double(n+1))) {
            let mask = Array(String(i, radix: 2))
            // print(mask)
            
            var cur = [Int]()
            for j in 0..<n {
                if mask[j+1] == "1" {
                    cur.append(nums[j])
                }
            }
            res.append(cur)
        }
        return res
    }
}

/*
Solution 1
backTrack

use left, n to control current remain nums

Time Complexity: O(n*2^n)
Space Complexity: O(1)
*/
class Solution {
    func subsets(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        var nums = nums
        var res: [[Int]] = [[]]
        backTrack(&nums, 0, n, &res)
        return res
    }
    
    func backTrack(_ nums: inout [Int], _ left: Int, _ n: Int, _ res: inout [[Int]]) {
        if n == 0 { return }
        
        if nums.count == n { 
            res.append(nums)
        }
        
        for i in left..<n {
            let val = nums[i]
            nums.remove(at: i)
            backTrack(&nums, i, n-1, &res)
            nums.insert(val, at: i)
        }
    }
}
