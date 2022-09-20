/*
 * You are given n pairs of numbers. In every pair, the first number is always
 * smaller than the second number.
 *
 * Now, we define a pair (c, d) can follow another pair (a, b) if and only if b
 * < c. Chain of pairs can be formed in this fashion.
 *
 * Given a set of pairs, find the length longest chain which can be formed. You
 * needn't use up all the given pairs. You can select pairs in any order.
 *
 * Example 1:
 * Input: [[1,2], [2,3], [3,4]]
 * Output: 2
 * Explanation: The longest chain is [1,2] -> [3,4]
 * Note:
 * The number of given pairs will be in the range [1, 1000].
 */

/*
 * Solution 1
 * DP
 *
 * let dp[i][j] be the longest common prefix of A[i:] and B[j:]. Whenever A[i]
 * == B[j], we know dp[i][j] = dp[i+1][j+1] + 1. Also, the answer is
 * max(dp[i][j]) over all i, j.
 *
 * We can perform bottom-up dynamic programming to find the answer based on this
 * recurrence. Our loop invariant is that the answer is already calculated
 * correctly and stored in dp for any larger i, j.
 *
 * Time Complexity: O(M*N), where M,N are the lengths of A, B.
 * Space Complexity: O(M*N), the space used by dp.
 */
class Solution {
    public int findLength(int[] nums1, int[] nums2) {
        int m = nums1.length;
        int n = nums2.length;

        int[][] dp = new int[m + 1][n + 1];
        int len = 0;
        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (nums1[i] == nums2[j]) {
                    dp[i][j] = dp[i + 1][j + 1] + 1;
                    len = Math.max(len, dp[i][j]);
                }
            }
        }
        return len;
    }
}
