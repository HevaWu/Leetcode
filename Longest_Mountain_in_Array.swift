/*
You may recall that an array arr is a mountain array if and only if:

arr.length >= 3
There exists some index i (0-indexed) with 0 < i < arr.length - 1 such that:
arr[0] < arr[1] < ... < arr[i - 1] < arr[i]
arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
Given an integer array arr, return the length of the longest subarray, which is a mountain. Return 0 if there is no mountain subarray.



Example 1:

Input: arr = [2,1,4,7,3,2,5]
Output: 5
Explanation: The largest mountain is [1,4,7,3,2] which has length 5.
Example 2:

Input: arr = [2,2,2]
Output: 0
Explanation: There is no mountain.


Constraints:

1 <= arr.length <= 104
0 <= arr[i] <= 104


Follow up:

Can you solve it using only one pass?
Can you solve it in O(1) space?

*/

/*
Solution 1:
iterate array

always to see if we can find a `mountain`, if we can, compare it with longest
if not, extend to next area

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func longestMountain(_ A: [Int]) -> Int {
        let n = A.count
        if n == 1 { return 0 }

        var longest = 0
        var left = 0
        while left < n {
            var right = left

            if right+1 < n, A[right] < A[right+1] {
                while right+1 < n, A[right] < A[right+1] {
                    right += 1
                }
                if right+1 < n, A[right] > A[right+1] {
                    while right+1 < n, A[right] > A[right+1] {
                        right += 1
                    }
                    longest = max(longest, right-left+1)
                }
            }

            left = max(right, left+1)
        }

        return longest
    }
}