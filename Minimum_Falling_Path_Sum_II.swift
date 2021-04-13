/*
Given a square grid of integers arr, a falling path with non-zero shifts is a choice of exactly one element from each row of arr, such that no two elements chosen in adjacent rows are in the same column.

Return the minimum sum of a falling path with non-zero shifts.



Example 1:

Input: arr = [[1,2,3],[4,5,6],[7,8,9]]
Output: 13
Explanation:
The possible falling paths are:
[1,5,9], [1,5,7], [1,6,7], [1,6,8],
[2,4,8], [2,4,9], [2,6,7], [2,6,8],
[3,4,8], [3,4,9], [3,5,7], [3,5,9]
The falling path with the smallest sum is [1,5,7], so the answer is 13.


Constraints:

1 <= arr.length == arr[i].length <= 200
-99 <= arr[i][j] <= 99
*/

/*
Solution 2:
optimize solution 1's space

DP
with constant space

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func minFallingPathSum(_ arr: [[Int]]) -> Int {
        let n = arr.count

        // first init as 0,0,-1 to help make sure it will not out of Int range
        var min1 = 0
        var min2 = 0
        var index1 = -1

        for i in 0..<n {
            var tempMin1 = Int.max
            var tempMin2 = Int.max
            var tempIndex = -1

            for j in 0..<n {
                let pre = j == index1 ? min2 : min1
                if arr[i][j] + pre < tempMin1 {
                    tempMin2 = tempMin1
                    tempMin1 = arr[i][j] + pre
                    tempIndex = j
                } else {
                    tempMin2 = min(tempMin2, arr[i][j] + pre)
                }
            }
            min1 = tempMin1
            min2 = tempMin2
            index1 = tempIndex

            // print(min1, min2, index1)
        }

        return min1
    }
}

/*
Solution 1
throw strange runtime error ...

DP
1D

dp[i] - minFallingSum when final drop at i

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func minFallingPathSum(_ arr: [[Int]]) -> Int {
        let n = arr.count
        var dp = arr[0]

        var firstMin = Int.max
        var firstIndex = 0
        var secondMin = Int.max
        for i in 1..<n {
            // find minimum 2 value and its corresponding index
            // firstMin - minimum element in dp
            // secondMin - second minimum element in dp
            // [value, index]
            firstMin = Int.max
            firstIndex = 0
            secondMin = Int.max
            for j in 0..<n {
                if dp[j] < firstMin {
                    firstMin = dp[j]
                    firstIndex = j
                } else if dp[j] < secondMin {
                    secondMin = dp[j]
                }
            }

            // update dp
            // for != firstMin.index col, always add firstMin.val into it
            // for == firstMin.index col, add secondMin.val in that one
            for j in 0..<n {
                if j != firstIndex {
                    dp[j] = arr[i][j] + firstMin
                } else {
                    dp[j] = arr[i][j] + secondMin
                }
            }
            // print(dp, firstMin, secondMin)
        }
        // print(dp)

        // find minimum val in dp, which is the answer
        var minSum = dp[0]
        for i in 1..<n {
            minSum = min(minSum, dp[i])
        }
        return minSum
    }
}