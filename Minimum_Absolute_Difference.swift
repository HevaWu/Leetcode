/*
Given an array of distinct integers arr, find all pairs of elements with the minimum absolute difference of any two elements.

Return a list of pairs in ascending order(with respect to pairs), each pair [a, b] follows

a, b are from arr
a < b
b - a equals to the minimum absolute difference of any two elements in arr


Example 1:

Input: arr = [4,2,1,3]
Output: [[1,2],[2,3],[3,4]]
Explanation: The minimum absolute difference is 1. List all pairs with difference equal to 1 in ascending order.
Example 2:

Input: arr = [1,3,6,10,15]
Output: [[1,3]]
Example 3:

Input: arr = [3,8,-10,23,19,-4,-14,27]
Output: [[-14,-10],[19,23],[23,27]]


Constraints:

2 <= arr.length <= 10^5
-10^6 <= arr[i] <= 10^6
*/

/*
Solution 1:
Sort and iterate each pair

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func minimumAbsDifference(_ arr: [Int]) -> [[Int]] {
        var arr = arr.sorted()

        var minDiff = Int.max
        var pair = [[Int]]()

        let n = arr.count
        for i in 0..<(n-1) {
            let diff = arr[i+1] - arr[i]
            if diff < minDiff {
                pair = [[arr[i], arr[i+1]]]
                minDiff = diff
            } else if diff == minDiff {
                pair.append([arr[i], arr[i+1]])
            }
        }
        return pair
    }
}