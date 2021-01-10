/*
Given an array of integers nums, sort the array in ascending order.

 

Example 1:

Input: nums = [5,2,3,1]
Output: [1,2,3,5]
Example 2:

Input: nums = [5,1,1,2,0,0]
Output: [0,0,1,1,2,5]
 

Constraints:

1 <= nums.length <= 50000
-50000 <= nums[i] <= 50000
*/

/*
Solution 2:
merge sort
top-down

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        if nums.count <= 1 { return nums }
        
        let pivot = nums.count/2
        let left = sortArray(Array(nums[0..<pivot]))
        let right = sortArray(Array(nums[pivot..<nums.count]))
        return merge(left, right)
    }
    
    // merge 2 sorted list
    func merge(_ a1: [Int], _ a2: [Int]) -> [Int] {
        var i = 0
        var j = 0
        var res = [Int]()
        while i < a1.count, j < a2.count {
            if a1[i] <= a2[j] {
                res.append(a1[i])
                i += 1
            } else {
                res.append(a2[j])
                j += 1
            }
        }
        while i < a1.count {
            res.append(a1[i])
            i += 1
        }
        while j < a2.count {
            res.append(a2[j])
            j += 1
        }
        return res
    }
}

/*
Solution 3:
merge sort: bottom up

*/
class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        if nums.count <= 1 { return nums }
        
        let n = nums.count
        
        // cache[read] for reading
        // cache[1-read] for writing
        var cache = [nums, nums]
        var read = 0 // either 0 or 1
        
        var width = 1
        while width < n {
            var i = 0
            while i < n {
                var j = i
                var l = i
                var r = i + width
                
                let lmax = min(l+width, n)
                let rmax = min(r+width, n)
                
                while l < lmax, r < rmax {
                    if cache[read][l] <= cache[read][r] {
                        cache[1-read][j] = cache[read][l]
                        l += 1
                    } else {
                        cache[1-read][j] = cache[read][r]
                        r += 1
                    }
                    j += 1
                }
                
                while l < lmax {
                    cache[1-read][j] = cache[read][l]
                    l += 1
                    j += 1
                }
                
                while r < rmax {
                    cache[1-read][j] = cache[read][r]
                    r += 1
                    j += 1
                }
                
                i += width * 2
            }
            
            // update width & read for new merge
            width *= 2
            read = 1 - read
        }
        
        return cache[read]
    }
}

/*
Solution 1: 
use swift provided sorted() function
*/
class Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        return nums.sorted()
    }
}