/*
You are given three integers n, m and k. Consider the following algorithm to find the maximum element of an array of positive integers:


You should build the array arr which has the following properties:

arr has exactly n integers.
1 <= arr[i] <= m where (0 <= i < n).
After applying the mentioned algorithm to arr, the value search_cost is equal to k.
Return the number of ways to build the array arr under the mentioned conditions. As the answer may grow large, the answer must be computed modulo 109 + 7.



Example 1:

Input: n = 2, m = 3, k = 1
Output: 6
Explanation: The possible arrays are [1, 1], [2, 1], [2, 2], [3, 1], [3, 2] [3, 3]
Example 2:

Input: n = 5, m = 2, k = 3
Output: 0
Explanation: There are no possible arrays that satisify the mentioned conditions.
Example 3:

Input: n = 9, m = 1, k = 1
Output: 1
Explanation: The only possible array is [1, 1, 1, 1, 1, 1, 1, 1, 1]


Constraints:

1 <= n <= 50
1 <= m <= 100
0 <= k <= n
*/

/*
Solution 1:

Let ways[i][j][k] be the number of ways to construct an array of length i with maximum element equal to j at a search cost of k.

There are two subproblems that contribute to ways[i][j][k]:

Clearly, we require ways[i][j][k] += j * ways[i - 1][j][k]. Why? Because if we have an array of length i - 1 with maximum element equal to j at a search cost of k, then we can just append any element from [1, 2, ... j] to this array, and we end up with an array of length i with maximum element equal to j at a search cost of k. Note that neither the search cost nor the maximum element change since we're only appending elements from [1,2, ..., j]. Only the length changes by one.

We also require ways[i][j][k] += SUM from x=1 to j-1 of ways[i - 1][x][k - 1] (the sum is inclusive on both ends). This is true because if we have an array of length i - 1 with maximum element (strictly) less than j at a search cost of k - 1, then we can simply append the element j to the end of this array (which adds a comparison cost of one), and we obtain a valid solution.

Now the answer is just the sum over all ways[i][x][k] from x = 1 to k because there is no constraint on what the maximum element should be.

Time Complexity: O(nmkm)
Space Complexity: O(nmk)
*/
class Solution {
    func numOfArrays(_ n: Int, _ m: Int, _ k: Int) -> Int {
        if k == 0 { return 0 }

        let mod = Int(1e9+7)

        // dp[i][j][k]
        // number of arrays with
        // len is i,
        // max element is j
        // search cost is k
        var dp = Array(
            repeating: Array(
                repeating: Array(
                    repeating: 0,
                    count: k+1
                ),
                count: m+1
            ),
            count: n+1
        )

        // build dp from bottom to up

        // base case
        // if len is 1, what ever element, the search cost will be 1
        for j in 1...m {
            dp[1][j][1] = 1
        }

        for i in 1...n {
            for j in 1...m {
                for k in 1...k {
                    var val = 0
                    // for len is i-1,
                    // can put any of 1...m at the end of array
                    val = (val + j * dp[i-1][j][k]) % mod

                    // for len is i-1,
                    // for array strictly less than j,
                    // put j to the end of array
                    for x in 1..<j {
                        val = (val + dp[i-1][x][k-1]) % mod
                    }

                    dp[i][j][k] = (dp[i][j][k] + val) % mod
                }
            }
        }

        // get all elements for x in 1...k
        // sum dp[n][x][k]
        // which is the result
        var num = 0

        for x in 1...m {
            num = (num + dp[n][x][k]) % mod
        }

        return num
    }
}