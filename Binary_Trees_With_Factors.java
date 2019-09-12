/*
823. Binary Trees With Factors
Given an array of unique integers, each integer is strictly greater than 1.

We make a binary tree using these integers and each number may be used for any number of times.

Each non-leaf node's value should be equal to the product of the values of it's children.

How many binary trees can we make?  Return the answer modulo 10 ** 9 + 7.

Example 1:

Input: A = [2, 4]
Output: 3
Explanation: We can make these trees: [2], [4], [4, 2, 2]
Example 2:

Input: A = [2, 4, 5, 10]
Output: 7
Explanation: We can make these trees: [2], [4], [5], [10], [4, 2, 2], [10, 2, 5], [10, 5, 2].


Note:

1 <= A.length <= 1000.
2 <= A[i] <= 10 ^ 9.
*/

/*
idea: DP(Dynamic Programming)
dp[i] = sum(dp[j]*dp[i/j])
sum(dp[i])
when i,j,i/j in the list

Sort the array first,
then check if current node has leaf node,
if it has, check its (leaf node res) * (another leaf)
if it not, count 1
 */

class Solution {
    public int numFactoredBinaryTrees(int[] A) {
        if (A.length == 0) { return 0; }

        long res = 0L;
        long mod = (long)1e9 + 7;

        Arrays.sort(A);
        HashMap<Integer, Long> dp = new HashMap<>();

        for (int i = 0; i < A.length; ++i) {
            dp.put(A[i], 1L);
            for (int j = 0; j < i; ++j) {
                if (A[i] % A[j] == 0) {
                    dp.put(A[i], (dp.get(A[i]) + dp.get(A[j]) * dp.getOrDefault(A[i] / A[j], 0L)) % mod);
                }
            }
            res = (res + dp.get(A[i])) % mod;
        }

        return (int)res;
    }
}