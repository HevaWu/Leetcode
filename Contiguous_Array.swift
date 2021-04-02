/*
Given a binary array, find the maximum length of a contiguous subarray with equal number of 0 and 1.

Example 1:
Input: [0,1]
Output: 2
Explanation: [0, 1] is the longest contiguous subarray with equal number of 0 and 1.
Example 2:
Input: [0,1,0]
Output: 2
Explanation: [0, 1] (or [1, 0]) is a longest contiguous subarray with equal number of 0 and 1.
Note: The length of the given binary array will not exceed 50,000.


*/

/*
Solution 2:
map

[count, index]
each time, we check if same count appears before,
if appears, means map[count] index to current i is a valid continuous subarray

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findMaxLength(_ nums: [Int]) -> Int {
        let n = nums.count
        if n <= 1 { return 0 }

        // [count, index]
        var map = [Int: Int]()
        var maxLen = 0
        var count = 0

        map[0] = -1
        for i in 0..<n {
            count += (nums[i] == 1 ? 1 : -1)
            if let val = map[count] {
                maxLen = max(maxLen, i-val)
            } else {
                map[count] = i
            }
        }

        return maxLen
    }
}

/*
Solution 1:
DP
Time limit exceeded

prepare zero & one array for recording current 0,1 count
dp[i] = max(dp[i-1], i-j)

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func findMaxLength(_ nums: [Int]) -> Int {
        let n = nums.count
        if n <= 1 { return 0 }

        var zeroPre = 0
        var zero = Array(repeating: 0, count: n+1)
        var onePre = 0
        var one = Array(repeating: 0, count: n+1)

        // dp[i] - [0..<i] max length
        var dp = Array(repeating: 0, count: n+1)
        var maxLen = 0

        for i in 1...n {
            if nums[i-1] == 0 {
                zeroPre += 1
                zero[i] = zeroPre
                one[i] = one[i-1]
            } else {
                onePre += 1
                one[i] = onePre
                zero[i] = zero[i-1]
            }

            // check from 0, to include start point
            for j in 0...i {
                if zero[i] - zero[j] == one[i] - one[j] {
                    dp[i] = max(dp[i-1], i-j)
                    break
                }
            }
            // print(zero, one, dp)
        }

        return dp[n]
    }
}
