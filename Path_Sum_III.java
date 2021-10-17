/*
You are given a binary tree in which each node contains an integer value.

Find the number of paths that sum to a given value.

The path does not need to start or end at the root or a leaf, but it must go downwards (traveling only from parent nodes to child nodes).

The tree has no more than 1,000 nodes and the values are in the range -1,000,000 to 1,000,000.

Example:

root = [10,5,-3,3,2,null,11,3,-2,null,1], sum = 8

      10
     /  \
    5   -3
   / \    \
  3   2   11
 / \   \
3  -2   1

Return 3. The paths that sum to 8 are:

1.  5 -> 3
2.  5 -> 2 -> 1
3. -3 -> 11

*/

/*
Solution 1:
build prefixMap to help checking already checked path
preSum = [sum: how many path from root to current node has this path sum value]

Time Complexity: O(n)
Space Complexity: O(n)
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int pathSum(TreeNode root, int targetSum) {
        if (root == null) { return 0; }

        Map<Integer, Integer> preSum = new HashMap<>();
        preSum.put(0, 1);
        return check(root, targetSum, 0, preSum);
    }

    public int check(TreeNode node, int targetSum,
                     int cur, Map<Integer, Integer> preSum) {
        if (node == null) { return 0; }

        cur += node.val;
        int res = preSum.getOrDefault(cur-targetSum, 0);
        preSum.put(cur, preSum.getOrDefault(cur, 0) + 1);
        res += check(node.left, targetSum, cur, preSum) + check(node.right, targetSum, cur, preSum);
        preSum.put(cur, preSum.getOrDefault(cur, 0) - 1);
        return res;
    }
}