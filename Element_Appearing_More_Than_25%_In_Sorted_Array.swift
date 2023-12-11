/*
Given an integer array sorted in non-decreasing order, there is exactly one integer in the array that occurs more than 25% of the time, return that integer.



Example 1:

Input: arr = [1,2,2,6,6,6,6,7,10]
Output: 6
Example 2:

Input: arr = [1,1]
Output: 1


Constraints:

1 <= arr.length <= 104
0 <= arr[i] <= 105
*/

/*
Solution 1:
iterate the sorted array, always track current elements appearance times

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findSpecialInteger(_ arr: [Int]) -> Int {
        let n = arr.count
        let limit = n/4
        var cur = 1
        for i in 1..<n {
            if arr[i] == arr[i-1] {
                cur += 1
            } else {
                if cur > limit {
                    return arr[i-1]
                }
                cur = 1
            }
        }
        if cur > limit {
            return arr[n-1]
        }
        return -1
    }
}
