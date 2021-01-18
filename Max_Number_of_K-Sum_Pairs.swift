/*
You are given an integer array nums and an integer k.

In one operation, you can pick two numbers from the array whose sum equals k and remove them from the array.

Return the maximum number of operations you can perform on the array.

 

Example 1:

Input: nums = [1,2,3,4], k = 5
Output: 2
Explanation: Starting with nums = [1,2,3,4]:
- Remove numbers 1 and 4, then nums = [2,3]
- Remove numbers 2 and 3, then nums = []
There are no more pairs that sum up to 5, hence a total of 2 operations.
Example 2:

Input: nums = [3,1,3,4,3], k = 6
Output: 1
Explanation: Starting with nums = [3,1,3,4,3]:
- Remove the first two 3's, then nums = [1,4,3]
There are no more pairs that sum up to 6, hence a total of 1 operation.
 

Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 109
1 <= k <= 109

Hint 1: 
The abstract problem asks to count the number of disjoint pairs with a given sum k.

Hint 2: 
For each possible value x, it can be paired up with k - x.

Hint 3:
The number of such pairs equals to min(count(x), count(k-x)), unless that x = k / 2, where the number of such pairs will be floor(count(x) / 2).
*/

/*
Solution 2:
optimize solution 1 by only checking nums once

- go through nums
- if map[k-nums[i]] appears before, res+=1, update map[k-nums[i]]-1
- if not, put num into map, map[nums[i]] += 1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maxOperations(_ nums: [Int], _ k: Int) -> Int {
        // key is num
        // val is appear count
        var map = [Int: Int]()
        var res = 0
        for i in 0..<nums.count {
            if let val = map[k-nums[i]] {
                map[k-nums[i]] = val == 1 ? nil : val-1
                res += 1
            } else {
                map[nums[i], default: 0] += 1
            }
        }
        
        return res
    }
}

/*
Solution 1:
- put nums in map, key is num, value is appears count
- find 2 cases:
	- if key*2 == k, res += map[key]/2
	- if both key, k-key appears, res += min(map[key], map[k-key])
- use visited to control visiting num

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maxOperations(_ nums: [Int], _ k: Int) -> Int {
        // key is num
        // val is appear count
        var map = [Int: Int]()
        for n in nums {
            map[n, default: 0] += 1
        }
        
        var visited = Set<Int>()
        var res = 0
        for key in map.keys {
            if visited.contains(key) {
                continue
            }
            visited.insert(key)
            
            if key*2 == k {
                res += (map[key]!/2)
            } else if let val = map[k-key] {
                res += min(map[key]!, val)
                visited.insert(k-key)
            }
        }
        
        return res
    }
}
