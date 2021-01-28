/*
Given an array of integers, find out whether there are two distinct indices i and j in the array such that the absolute difference between nums[i] and nums[j] is at most t and the absolute difference between i and j is at most k.

 

Example 1:

Input: nums = [1,2,3,1], k = 3, t = 0
Output: true
Example 2:

Input: nums = [1,0,1,1], k = 1, t = 2
Output: true
Example 3:

Input: nums = [1,5,9,1,5,9], k = 2, t = 3
Output: false
 

Constraints:

0 <= nums.length <= 2 * 104
-231 <= nums[i] <= 231 - 1
0 <= k <= 104
0 <= t <= 231 - 1

Hint 1:
Time complexity O(n logk) - This will give an indication that sorting is involved for k elements.

Hint 2:
Use already existing state to evaluate next state - Like, a set of k sorted numbers are only needed to be tracked. When we are processing the next number in array, then we can utilize the existing sorted state and it is not necessary to sort next overlapping set of k numbers again.
*/

/*
Solution 2:
use set to help insert & delete nums quickly

Time Complexity: O(nk)
Space Complexity: O(k)
*/
class Solution {
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        guard !nums.isEmpty else { return false }
        var set = Set<Int>()
        let n = nums.count
        for i in 0..<n {
            if t == 0 {
                if set.contains(nums[i]) {
                    return true
                }
            } else {
                if set.contains(where: {
                    abs(nums[i] - $0) <= t
                }) {
                    return true
                }
            }
            
            set.insert(nums[i])
            if set.count == k+1 {
                set.remove(nums[i-k])
            }
        }
        return false
    }
}

/*
Solution 1:
binary search

sort first k element, 
then check if there are 2 ajacent element val <= t, 
if exist, return true

for remaining element i in 1..<(n-k)
- remove nums[i-1]
- insert nums[k+i]
- check index where insert new element if 2 ajacent element val <= t

Time Complexity: O(n logK)
Space Complexity: O(k)
*/
class Solution {
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        let n = nums.count
		// return false for all of k==0
        if k == 0 { return false }
        
		// control first tempSize
        let tempSize = k < n ? k+1 : n
        var temp = Array(nums[0..<tempSize])
        temp.sort()
                
        for i in 0..<(tempSize-1) {
            let cur = temp[i+1] - temp[i]
            if cur <= t {
                return true
            }
        }
        // print(temp)
        
        if n <= k { return false }
        
        for i in 1..<(n-k) {            
            // remove nums[i-1], and insert nums[k+i]
            remove(&temp, k, nums[i-1])
            var _index = add(&temp, k, nums[k+i])
            // print(temp)
            
            if _index > 0 {
                let dis = temp[_index] - temp[_index-1]
                if dis <= t { return true }
            }
            
            if _index < k {
                let dis = temp[_index+1] - temp[_index]
                if dis <= t { return true }
            }
        }
        return false
    }
    
    // remove val in sorted nums
    func remove(_ nums: inout [Int], _ n: Int, _ val: Int) {
        if nums[0] == val { 
            nums.removeFirst()
            return 
        }
        
        if nums[n] == val {
            nums.removeLast()
            return
        }
        
        var left = 0
        var right = n-1
        
        while left <= right {
            let mid = left + (right - left)/2
            if nums[mid] == val {
                nums.remove(at: mid)
                return
            } else if nums[mid] < val {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    
    // add val in sorted nums, return index where we insert val
    // n is nums.count
    func add(_ nums: inout [Int], _ n: Int, _ val: Int) -> Int {
        if nums[0] > val { 
            nums.insert(val, at: 0)
            return 0 
        }
        
        if nums[n-1] < val {
            nums.append(val)
            return n
        }
        
        var left = 0
        var right = n-1 
        while left < right {
            let mid = left + (right - left)/2
            if nums[mid] > val {
                right = mid
            } else {
                left = mid + 1
            }
        }
        
        nums.insert(val, at: left)
        return left
    }
}