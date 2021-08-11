/*
Given an array of integers arr of even length, return true if and only if it is possible to reorder it such that arr[2 * i + 1] = 2 * arr[2 * i] for every 0 <= i < len(arr) / 2.



Example 1:

Input: arr = [3,1,3,6]
Output: false
Example 2:

Input: arr = [2,1,2,6]
Output: false
Example 3:

Input: arr = [4,-2,2,-4]
Output: true
Explanation: We can take two groups, [-2,-4] and [2,4] to form [-2,-4,2,4] or [2,4,-2,-4].
Example 4:

Input: arr = [1,2,4,16,8,4]
Output: false


Constraints:

0 <= arr.length <= 3 * 104
arr.length is even.
-105 <= arr[i] <= 105
*/

/*
Solution 1:
binary search

1. sort the array, for easy handle in later searchings
2. for each element, try to see if we can find corresponding pair
--> num < 0, check num/2 (note: num%2 == 0)
--> num >= 0, check num*2 exist or not

Time Complexity: O(n/2 * log(n))
Space Complexity: O(n)
*/
class Solution {
    func canReorderDoubled(_ arr: [Int]) -> Bool {
        if arr.isEmpty { return true }

        let n = arr.count
        var arr = arr.sorted()

        for i in 0..<(n/2) {
            let cur = arr.removeFirst()
            // -4, -2 is okay

            var index = -1
            if cur < 0, cur % 2 == 0 {
                index = findPair(cur/2, arr)
            } else if cur >= 0 {
                // 0 also can try to match
                index = findPair(cur*2, arr)
            }

            // print(2*cur, index, arr)
            if index == -1 {
                return false
            }
            arr.remove(at: index)
        }
        return true
    }

    // return index of target if arr[index] == target
    func findPair(_ target: Int, _ arr: [Int]) -> Int {
        if arr.isEmpty { return -1 }

        var left = 0
        var right = arr.count-1
        while left <= right {
            let mid = left + (right-left)/2
            if arr[mid] == target {
                return mid
            } else if arr[mid] < target {
                left = mid+1
            } else {
                right = mid-1
            }
        }
        return -1
    }
}