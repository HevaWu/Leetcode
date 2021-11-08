/*
Given an integer n, return the number of structurally unique BST's (binary search trees) which has exactly n nodes of unique values from 1 to n.



Example 1:


Input: n = 3
Output: 5
Example 2:

Input: n = 1
Output: 1


Constraints:

1 <= n <= 19
*/

/*
Solution 2: DP
G[n] is number of unique BST with n nodes
F(i, n) is number of unique BST with n nodes with root is i
G[n] = F(1, n) + F(2, n) + ... + F(n, n)
F(i, n) = G[i-1] * G[n-i]
ex: F(3, 7) = (1,2) unique nodes + (4,5,6,7) unique nodes
 = G[2] * G[4]

G(n) = G(0) * G(n-1) + G(1) * G(n-2) + … + G(n-1) * G(0)
Time Complexity: O(n)
Space Complexity: O(n)
 */
class Solution {
    public int numTrees(int n) {
        if (n < 2) { return 1; }
        int[] G = new int[n+1];
        G[0] = 1;
        G[1] = 1;

        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= i; j++) {
                G[i] += G[j-1] * G[i-j];
            }
        }
        return G[n];
    }
}