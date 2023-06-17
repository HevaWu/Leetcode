/*
Given two integer arrays arr1 and arr2, return the minimum number of operations (possibly zero) needed to make arr1 strictly increasing.

In one operation, you can choose two indices 0 <= i < arr1.length and 0 <= j < arr2.length and do the assignment arr1[i] = arr2[j].

If there is no way to make arr1 strictly increasing, return -1.



Example 1:

Input: arr1 = [1,5,3,6,7], arr2 = [1,3,2,4]
Output: 1
Explanation: Replace 5 with 2, then arr1 = [1, 2, 3, 6, 7].
Example 2:

Input: arr1 = [1,5,3,6,7], arr2 = [4,3,1]
Output: 2
Explanation: Replace 5 with 3 and then replace 3 with 4. arr1 = [1, 3, 4, 6, 7].
Example 3:

Input: arr1 = [1,5,3,6,7], arr2 = [1,6,3,3]
Output: -1
Explanation: You can't make arr1 strictly increasing.


Constraints:

1 <= arr1.length, arr2.length <= 2000
0 <= arr1[i], arr2[i] <= 10^9

*/


/*
Solution 1:
backtrack

find the min swap for arr1[index...] with previous element as pre
2 option,
if arr1[index] > pre, then can choose to keep the element, keep search "arr[index+1...] with previous element as arr1[index]"
if can find a larger element in arr2, which can > pre, replace with the next larger element in arr2, keep search "arr[index+1...] with previous element as arr2[pos]"

Time Complexity: O(n1 * (n1+n2))
Space Complexity: O(n1 * (n1+n2))
*/
class Solution {
    func makeArrayIncreasing(_ arr1: [Int], _ arr2: [Int]) -> Int {
        let n1 = arr1.count
        let n2 = arr2.count
        var arr2 = arr2.sorted()
        var cache = Array(repeating: [Int: Int](), count: n1)
        let res = check(0, -1, arr1, arr2, n1, n2, &cache)
        return res == n1+n2+1 ? -1 : res
    }

    // return the minimum swap at arr1[index...], with previous element is pre
    func check(_ index: Int, _ pre: Int, _ arr1: [Int], _ arr2: [Int], _ n1: Int, _ n2: Int, _ cache: inout [[Int: Int]]) -> Int {
        guard index < n1 else { return 0 }
        // print(index, pre, cache)
        if let val = cache[index][pre] { return val }
        var val = n1+n2+1
        if arr1[index] > pre {
            // not replace
            val = check(index+1, arr1[index], arr1, arr2, n1, n2, &cache)
        }

        let pos = findNextLarger(pre, arr2, n2)
        if pos < n2 {
            // replace it with arr2[pos]
            // print(arr2[pos], index)
            val = min(val, 1+check(index+1, arr2[pos], arr1, arr2, n1, n2, &cache))
        }
        cache[index][pre] = val
        return val
    }

    // find next larger element in sorted arr, return the next larger element index
    func findNextLarger(_ target: Int, _ arr: [Int], _ n: Int) -> Int {
        if n == 0 { return n }
        if target > arr[n-1] { return n }
        var l = 0
        var r = n-1
        while l < r {
            let mid = l + (r-l)/2
            if arr[mid] <= target {
                l = mid+1
            } else {
                r = mid
            }
        }
        return arr[l] <= target ? l+1 : l
    }
}
