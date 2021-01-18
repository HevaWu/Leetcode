/*
Given a sorted integer array arr, two integers k and x, return the k closest integers to x in the array. The result should also be sorted in ascending order.

An integer a is closer to x than an integer b if:

|a - x| < |b - x|, or
|a - x| == |b - x| and a < b
 

Example 1:

Input: arr = [1,2,3,4,5], k = 4, x = 3
Output: [1,2,3,4]
Example 2:

Input: arr = [1,2,3,4,5], k = 4, x = -1
Output: [1,2,3,4]
 

Constraints:

1 <= k <= arr.length
1 <= arr.length <= 104
arr is sorted in ascending order.
-104 <= arr[i], x <= 104
*/

/*
Solution 3:
Optimize Solution 2

- after finding pos
- left = max(0, pos-k-1)
- right = min(n-1, pos+k-1)
- loop when right-left < k-1
  - if left < 0 || x-arr[left] <= arr[right]-x {
		right -= 1
	} else if right > n-1 || x-arr[left] > arr[right]-x {
		left += 1
	}
- return arr[left..<(right+1)]

Time Complexity: O(logn + k)
Space Complexity: O(k)
*/
class Solution {
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        if k == arr.count { return arr }
        if arr[0] >= x { return Array(arr[0..<k]) }
        
        let n = arr.count
        if arr[n-1] <= x { return Array(arr[(n-k)..<n])}
        
        let pos = findPos(arr, x)
        if k == 1 { 
            return pos < n-1 && x-arr[pos] > arr[pos+1]-x 
            ? [arr[pos+1]] 
            : [arr[pos]]
        }
        // print(pos)
        
        var left = max(0, pos-k-1)
        var right = min(n-1, pos+k-1)

        while right-left > k-1 {
            if left < 0 || x-arr[left] <= arr[right]-x {
                right -= 1
            } else if right > n-1 || x-arr[left] > arr[right]-x {
                left += 1
            }
        }
        return Array(arr[left..<(right+1)]) 
    }
    
    // find proper place to place x, return index where we can put x in arr
    func findPos(_ arr: [Int], _ x: Int) -> Int {
        if x < arr[0] { return 0 }
        
        var left = 0
        var right = arr.count-1
        
        // try to find leftmost closed to x
        while left+1 < right {
            let mid = left + (right - left) / 2
            if arr[mid] >= x {
                right = mid
            } else {
                left = mid
            }
        }
        
        if arr[left] == x { return left }
        if arr[right] == x { return right }
        return left
    }
}

/*
Solution 2:
binary search

- binary search find correct pos to place x
- iteratively check left and right side, then put element into res

Time Complexity: O(logn + k)
Space Complexity: O(k)
*/
class Solution {
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        if k == arr.count { return arr }
        
        let n = arr.count
        let pos = findPos(arr, x)
        if k == 1 { 
            return pos < n-1 && x-arr[pos] > arr[pos+1]-x 
            ? [arr[pos+1]] 
            : [arr[pos]]
        }
        // print(pos)
        
        var res = [arr[pos]]
        var left = pos-1
        var right = pos+1
        
        var cur = 1
        while cur < k, left >= 0, right < n {
            if x-arr[left] <= arr[right]-x {
                res.insert(arr[left], at: 0)
                left -= 1
            } else {
                res.append(arr[right])
                right += 1
            }
            cur += 1
        }
        // print(res)
        
        if cur == k { return res }
        while cur < k, left >= 0 {
            res.insert(arr[left], at: 0)
            left -= 1
            cur += 1
        }
        
        while cur < k, right < n {
            res.append(arr[right])
            right += 1
            cur += 1
        }
        return res
    }
    
    // find proper place to place x, return index where we can put x in arr
    func findPos(_ arr: [Int], _ x: Int) -> Int {
        if x < arr[0] { return 0 }
        
        var left = 0
        var right = arr.count-1
        
        // try to find leftmost closed to x
        while left+1 < right {
            let mid = left + (right - left) / 2
            if arr[mid] >= x {
                right = mid
            } else {
                left = mid
            }
        }
        
        if arr[left] == x { return left }
        if arr[right] == x { return right }
        return left
    }
}

/*
Solution 1
collection sort

sort array by distance to x,
then return first k element

Time Complexity: O(nlogn)
Space Complexity: O(k)
*/
class Solution {
    func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        if k == arr.count { return arr }
        var sortedArr: [Int] = arr.sorted(by: { first, second -> Bool in
            let res = (first == second) 
                   ? (first < second) 
                   : (abs(first-x) < abs(second-x))
            return res
        })
        return Array(sortedArr[0..<k]).sorted()
    }
}