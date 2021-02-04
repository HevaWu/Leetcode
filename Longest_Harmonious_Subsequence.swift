/*
We define a harmonious array as an array where the difference between its maximum value and its minimum value is exactly 1.

Given an integer array nums, return the length of its longest harmonious subsequence among all its possible subsequences.

A subsequence of array is a sequence that can be derived from the array by deleting some or no elements without changing the order of the remaining elements.

 

Example 1:

Input: nums = [1,3,2,2,5,2,3,7]
Output: 5
Explanation: The longest harmonious subsequence is [3,2,2,2,3].
Example 2:

Input: nums = [1,2,3,4]
Output: 2
Example 3:

Input: nums = [1,1,1,1]
Output: 0
 

Constraints:

1 <= nums.length <= 2 * 104
-109 <= nums[i] <= 109
*/

/*
Solution 2:
optimize solution 1

we don't need to sort map.keys
only go through, and check if map[k+1] is exist is enough

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findLHS(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
        for num in nums {
            map[num, default: 0] += 1
        }
        
        var res = 0
        for k in map.keys {
            if let val = map[k+1] {
                res = max(res, map[k]! + val)
            }
        }
        return res
    }
}

/*
Solution 1
map
- key is num
- val is freq

Then iteratively check map.sorted keys
if 2 key's diff is 1, check if we need to update res

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func findLHS(_ nums: [Int]) -> Int {
        // key is num
        // val is freq
        var map = [Int: Int]()
        for n in nums {
            map[n, default: 0] += 1
        }
        
        var list = map.keys.sorted()
        var res = 0
        for i in 0..<(list.count-1) {
            if list[i+1] - list[i] == 1 {
                res = max(res, map[list[i]]! + map[list[i+1]]!)
            }
        }
        return res
    }
}