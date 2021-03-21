/*
Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum equals to k.

 

Example 1:

Input: nums = [1,1,1], k = 2
Output: 2
Example 2:

Input: nums = [1,2,3], k = 3
Output: 2
 

Constraints:

1 <= nums.length <= 2 * 104
-1000 <= nums[i] <= 1000
-107 <= k <= 107

*/

/*
Solution 2:
map

[sum_i, number of occurrences of sum_i]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        if n == 1 {
            return nums[0] == k ? 1 : 0
        }
        
        var count = 0
        var sum = 0
        
        // [sum-k, count]
        var map = [Int: Int]()
        map[0] = 1
        
        for i in 0..<n {
            sum += nums[i]
            if let val = map[sum-k] {
                count += val
            }
            map[sum, default: 0] += 1
        }
        
        return count
    }
}

/*
Solution 1:
cumulative sum
Time limit exceeded

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        if n == 1 {
            return nums[0] == k ? 1 : 0
        }
        
        var sum = Array(repeating: 0, count: n+1)
        
        var count = 0
        for i in 1...n {
            sum[i] = sum[i-1] + nums[i-1]
        }
        
        for i in 0..<n {
            for j in (i+1)...n {
                if sum[j] - sum[i] == k {
                    count += 1
                }
            }
        }
        
        return count
    }
}