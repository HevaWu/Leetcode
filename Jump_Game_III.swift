/*
Given an array of non-negative integers arr, you are initially positioned at start index of the array. When you are at index i, you can jump to i + arr[i] or i - arr[i], check if you can reach to any index with value 0.

Notice that you can not jump outside of the array at any time.



Example 1:

Input: arr = [4,2,3,0,3,1,2], start = 5
Output: true
Explanation:
All possible ways to reach at index 3 with value 0 are:
index 5 -> index 4 -> index 1 -> index 3
index 5 -> index 6 -> index 4 -> index 1 -> index 3
Example 2:

Input: arr = [4,2,3,0,3,1,2], start = 0
Output: true
Explanation:
One possible way to reach at index 3 with value 0 is:
index 0 -> index 4 -> index 1 -> index 3
Example 3:

Input: arr = [3,0,2,1,2], start = 2
Output: false
Explanation: There is no way to reach at index 1 with value 0.


Constraints:

1 <= arr.length <= 5 * 104
0 <= arr[i] < arr.length
0 <= start < arr.length
*/

/*
Solution 1:
DFS

use visited to record where we've already jumped and put its next into stack
once jump to one index, check it, and put its next possible jump index into stack.
once find arr[index] == 0, return true
if finish jump all, and still not find 0 one, return false

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func canReach(_ arr: [Int], _ start: Int) -> Bool {
        let n = arr.count
        var visited = Array(repeating: false, count: n)

        var stack = [start]
        while !stack.isEmpty {
            let index = stack.removeLast()
            visited[index] = true
            if arr[index] == 0 { return true }

            if index + arr[index] < n, !visited[index + arr[index]] {
                stack.append(index + arr[index])
            }
            if index - arr[index] >= 0, !visited[index - arr[index]] {
                stack.append(index - arr[index])
            }
        }
        return false
    }
}