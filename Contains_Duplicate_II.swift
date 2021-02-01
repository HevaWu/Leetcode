/*
Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the absolute difference between i and j is at most k.

Example 1:

Input: nums = [1,2,3,1], k = 3
Output: true
Example 2:

Input: nums = [1,0,1,1], k = 1
Output: true
Example 3:

Input: nums = [1,2,3,1,2,3], k = 2
Output: false
*/

/*
Solution 3:
set

always keep k element in set
Time Complexity: O(n)
Space Complexity: O(k)
*/
class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        if nums.isEmpty { return false }
        
        let n = nums.count
        var set = Set<Int>()
        
        for i in 0...min(k, n-1) {
            if set.contains(nums[i]) {
                return true
            }
            set.insert(nums[i])
        }
        
        if n-1 <= k { return false }
        
        for i in 1...(n-1-k) {
            set.remove(nums[i-1])
            if set.contains(nums[k+i]) {
                return true
            }
            set.insert(nums[k+i])
        }
        
        return false
    }
}

/*
Solution 1:
map 
key is num
value is latest appeared index

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        if nums.isEmpty { return false }
        
        // key is num
        // value is latest appeared index
        var map = [Int: Int]()
        
        for i in nums.indices {
            if let val = map[nums[i]] {
                if i-val <= k {
                    return true
                }
            }
            
            map[nums[i]] = i
        }
        
        return false
    }
}

/*
Solution 1:
map 

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        // key is num
        // value is index array
        var map = [Int: [Int]]()
        
        for i in nums.indices {
            map[nums[i], default: [Int]()].append(i)
        }
        
        for key in map.keys {
            let list = map[key]!
            let n = list.count

            if n > 1 {
                for i in 0..<n-1 {
                    if list[i+1] - list[i] <= k {
                        return true
                    }
                }
            }
        }
        return false
    }
}