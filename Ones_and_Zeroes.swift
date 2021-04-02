/*
You are given an array of binary strings strs and two integers m and n.

Return the size of the largest subset of strs such that there are at most m 0's and n 1's in the subset.

A set x is a subset of a set y if all elements of x are also elements of y.



Example 1:

Input: strs = ["10","0001","111001","1","0"], m = 5, n = 3
Output: 4
Explanation: The largest subset with at most 5 0's and 3 1's is {"10", "0001", "1", "0"}, so the answer is 4.
Other valid but smaller subsets include {"0001", "1"} and {"10", "1", "0"}.
{"111001"} is an invalid subset because it contains 4 1's, greater than the maximum of 3.
Example 2:

Input: strs = ["10","0","1"], m = 1, n = 1
Output: 2
Explanation: The largest subset is {"0", "1"}, so the answer is 2.


Constraints:

1 <= strs.length <= 600
1 <= strs[i].length <= 100
strs[i] consists only of digits '0' and '1'.
1 <= m, n <= 100s
*/

/*
Solution 2:
DP

dp[i][j]
element with i's 0, j's 1 max count
dp[i][j] = max(dp[i][j], dp[i - curStr's zero][j - curStr's one] + 1)

Time Complexity: O(m * n * strs.count)
Space Complexity: O(m * n)
*/
class Solution {
    func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
        var dp = Array(
            repeating: Array(repeating: 0, count: n+1),
            count: m+1
        )

        for str in strs {
            let (zero, one) = getZeroOne(str)

            // dp[i][j] -> max number of strings that can be formed with i 0's and j 1's
            for i in stride(from: m, through: zero, by: -1) {
                for j in stride(from: n, through: one, by: -1) {
                    dp[i][j] = max(dp[i][j], dp[i-zero][j-one] + 1)
                }
            }
            // print(dp)
        }

        return dp[m][n]
    }

    func getZeroOne(_ str: String) -> (zero: Int, one: Int) {
        var zero = 0
        let n = str.count
        for c in str {
            if c == "0" {
                zero += 1
            }
        }
        return (zero, n-zero)
    }
}

/*
Solution 1:
brute force
Time Limit Exceeded

for each str, check if we can pick it or not

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
        var arr = strs.map { getZeroOne($0) }
        let size = strs.count

        var res = 0
        check(arr, 0, size, m, n, 0, &res)
        return res
    }

    func check(_ arr: [(zero: Int, one: Int)],
               _ index: Int, _ size: Int,
               _ m: Int, _ n: Int,
               _ cur: Int, _ res: inout Int) {
        // print(m, n, index, cur)
        if m >= 0, n >= 0 {
            res = max(res, cur)
        }

        if m < 0 || n < 0 || index >= size { return }
        check(arr, index+1, size, m-arr[index].zero, n-arr[index].one, cur+1, &res)
        check(arr, index+1, size, m, n, cur, &res)
    }

    func getZeroOne(_ str: String) -> (zero: Int, one: Int) {
        var zero = 0
        let n = str.count
        for c in str {
            if c == "0" {
                zero += 1
            }
        }
        return (zero, n-zero)
    }
}
