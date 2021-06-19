/*
For an integer array nums, an inverse pair is a pair of integers [i, j] where 0 <= i < j < nums.length and nums[i] > nums[j].

Given two integers n and k, return the number of different arrays consist of numbers from 1 to n such that there are exactly k inverse pairs. Since the answer can be huge, return it modulo 109 + 7.



Example 1:

Input: n = 3, k = 0
Output: 1
Explanation: Only the array [1,2,3] which consists of numbers from 1 to 3 has exactly 0 inverse pairs.
Example 2:

Input: n = 3, k = 1
Output: 2
Explanation: The array [1,3,2] and [2,1,3] have exactly 1 inverse pair.


Constraints:

1 <= n <= 1000
0 <= k <= 1000
*/

/*
Solution 4:
optimize solution 3
recursive with memoization

Time Complexity: O(n*k)
Space Complexity: O(nk)
*/
class Solution {
    func kInversePairs(_ n: Int, _ k: Int) -> Int {
        if k == 0 { return 1 }
        if n == 0 { return 0 }

        let mod = Int(1e9+7)

        var memo: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: k+1),
            count: n+1
        )

        memo[0] = Array(repeating: 0, count: k+1)
        memo[1] = Array(repeating: 0, count: k+1)
        memo[1][0] = 1

        return check(n, k, mod, &memo)
    }

    func check(_ n: Int, _ k: Int, _ mod: Int,
               _ memo: inout [[Int?]]) -> Int {
        if n == 0 { return 0 }
        if k == 0 { return 1 }
        if let val = memo[n][k] { return val }

        var val = (check(n, k-1, mod, &memo) + check(n-1, k, mod, &memo) - (k >= n ? check(n-1, k-n, mod, &memo) : 0)) % mod
        memo[n][k] = val < 0 ? val + mod : val
        return memo[n][k]!
    }
}

/*
Solution 3:
DP

dp[i][j]=dp[i−1][j]−dp[i−1][j−i]+dp[i−1][j]

The maximum number of inverse pairs for any arbitrary n occur only when the array is sorted in descending order leading to [n,n-1,....,3,2,1] as the arrangement.

This arrangement has a total of n*(n-1)/2 inverse pairs. Thus, for an array with ii as the number of elements, the maximum number of inverse pairs possible is i*(i-1)/2 only. Thus, for fillling in the i^{th} row of dp, we can place this limit on jj's value.

Time Complexity: O(n*k)
Space Complexity: O(nk)
*/
class Solution {
    func kInversePairs(_ n: Int, _ k: Int) -> Int {
        if k == 0 { return 1 }
        if n == 0 { return 0 }

        let mod = Int(1e9+7)

        var memo: [[Int]] = Array(
            repeating: Array(repeating: 0, count: k+1),
            count: n+1
        )

        memo[0] = Array(repeating: 0, count: k+1)
        memo[1][0] = 1
        guard n >= 2 else { return memo[n][k] }

        for i in 2...n {
            memo[i][0] = 1
            for j in 1...min(k, i*(i-1)/2) {
                memo[i][j] = (memo[i][j-1] + memo[i-1][j] - (j >= i ? memo[i-1][j-i] : 0)) % mod
            }
        }

        return memo[n][k] < 0 ? memo[n][k] + mod : memo[n][k]
    }
}

/*
Solution 2:
DP

dp[i][j] is used to store the number of arrangements with i elements and exactly j inverse pairs.

- If n=0, no inverse pairs exist. Thus, dp[0][k]=0.
- If k=0, only one arrangement is possible, which is all numbers sorted in ascending order. Thus, dp[n][0]=1.
- Otherwise, dp[i,j]=∑ p=0 min(j,i−1) count(i−1,j−p).

dp -> we fill the cumulative sum upto the current element in a row in any dp entry
-> dp[i][j], i elements with (0+1+2+...+j) reverse pairs

=> we need to traverse back to some limit in the previous row of the dp array to fill in the current dp entry. Instead of doing this traversal to find the sum of the required elements, we can ease the process if we fill the cumulative sum upto the current element in a row in any dp entry, instead of the actual value.
=> dp[i][j]=count(i,j)+∑ k=0 j−1 dp[i][k].

to obtain the sum of elements from dp[i−1][j−i+1] to dp[i−1][j](including both), we can directly use dp[i-1][j] - dp[i-1][j-i].

dp[i][j] = dp[i][j-1] + (dp[i-1][j] - dp[i-1][j-i])

At the end, while returning the result, we need to return dp[n][k]-dp[n][k-1] to obtain the required result from the cumulative sums.

Time Complexity: O(n*k)
Space Complexity: O(nk)
*/
class Solution {
    func kInversePairs(_ n: Int, _ k: Int) -> Int {
        if k == 0 { return 1 }
        if n == 0 { return 0 }

        let mod = Int(1e9+7)

        var memo: [[Int]] = Array(
            repeating: Array(repeating: 0, count: k+1),
            count: n+1
        )

        memo[0] = Array(repeating: 0, count: k+1)
        for i in 1...n {
            memo[i][0] = 1
            for j in 1...k {
                memo[i][j] = (memo[i][j-1] + memo[i-1][j] - (j >= i ? memo[i-1][j-i] : 0)) % mod
            }
        }

        var res = memo[n][k] - memo[n][k-1]
        return res < 0 ? res + mod : res
    }
}

/*
Solution 1:
recursive with memoization
Time Limit Exceeded

- whenever a number is shifted y times towards the left starting from the array a_0, after the shift, y numbers smaller than it lie towards its right, giving a total of y inverse pairs.
- suppose we know the number of arrangements of an array with n-1 elements, with the number of inverse pairs being 0, 1, 2,..., k, let's say being equal to count_0, count_1, count_2,.., count_k. Now, we can determine the number of arrangements of an array with n elements with exactly k inverse pairs easily.
- To generate the arrangements with exactly k inverse pairs and n elements, we can add the new number n to all the arrangements with k inverse pairs at the last position. For the arrangements with k-1 inverse pairs , we can add n at a position 1 step from the right.
- Similarly, for an element with k−i number of inverse pairs, we can add this new number n at a position i steps from the right. Each of these updations to the arrays leads to a new arrangement, each with the number of inverse pairs being equal to k.

Idea:
- Let's say count(i,j) represents the number of arrangements with i elements and exactly j inverse pairs.
- If n=0, no inverse pairs exist. Thus, count(0,k)=0.
- If k=0, only one arrangement is possible, which is all numbers sorted in ascending order. Thus, count(n,0)=1.
- Otherwise, count(n,k)=∑ i=0 min(k,n−1) count(n−1,k−i).

Time Complexity: O(n^2 * k)
Space Complexity: O(n)
*/
class Solution {
    func kInversePairs(_ n: Int, _ k: Int) -> Int {
        if k == 0 { return 1 }
        if n == 0 { return 0 }

        let mod = Int(1e9+7)

        var memo: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: k+1),
            count: n+1
        )

        return check(n, k, mod, &memo)
    }

    func check(_ n: Int, _ k: Int, _ mod: Int,
               _ memo: inout [[Int?]]) -> Int {
        if n == 0 { return 0 }
        if k == 0 { return 1 }
        if let val = memo[n][k] { return val }
        var val = 0
        for i in 0...min(k, n-1) {
            val = (val + check(n-1, k-i, mod, &memo)) % mod
        }
        memo[n][k] = val
        return val
    }
}