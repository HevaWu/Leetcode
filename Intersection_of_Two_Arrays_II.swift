/*
Given two arrays, write a function to compute their intersection.

Example 1:

Input: nums1 = [1,2,2,1], nums2 = [2,2]
Output: [2,2]
Example 2:

Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
Output: [4,9]
Note:

Each element in the result should appear as many times as it shows in both arrays.
The result can be in any order.
Follow up:

What if the given array is already sorted? How would you optimize your algorithm?
What if nums1's size is small compared to nums2's size? Which algorithm is better?
What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?
*/

/*
Solution 2:
no sort
use map to memo element appear before

Time Complexity: O(n+m)
Space Complexity: O(min(m+n))
*/
class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.count > nums2.count { return intersect(nums2, nums1) }
        
        var map = [Int: Int]()
        for n in nums1 {
            map[n, default: 0] += 1
        }
        
        var res = [Int]()
        for n in nums2 {
            if let val = map[n] {
                map[n] = (val == 1 ? nil : val - 1)
                res.append(n)
            }
        }
        return res
    }
}

/*
Solution 1:
sort 2 array first
binary search if element in arr1 also exist in arr2

Time Complexity: O(nlogn + mlogm)
Space Complexity: O(n+m)
*/
class Solution {
    var map1 = [Int: Int]()
    var map2 = [Int: Int]()
    
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        for n in nums1 {
            map1[n, default: 0] += 1
        }
        
        for n in nums2 {
            map2[n, default: 0] += 1
        }
        
        let arr1 = map1.keys.sorted()
        let arr2 = map2.keys.sorted()
        
        if arr1.count < arr2.count {
            return _inter(arr1, arr2)
        } else {
            return _inter(arr2, arr1)
        }
    }
    
    func _inter(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        var res = [Int]()
 
        for i in arr1 {
            if canSearch(i, in: arr2) {
                res.append(contentsOf: Array(repeating: i, 
                                             count: min(map1[i]!, map2[i]!)))
            }
        }
        return res
    }
    
    func canSearch(_ num: Int, in arr: [Int]) -> Bool {
        var left = 0
        var right = arr.count-1
        while left <= right {
            let mid = left + (right-left)/2
            if arr[mid] == num {
                return true
            } else if arr[mid] < num {
                left = mid+1
            } else {
                right = mid-1
            }
        }
        return false
    }
}