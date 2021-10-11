/*
Given the root of a binary tree, return the length of the diameter of the tree.

The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

The length of a path between two nodes is represented by the number of edges between them.



Example 1:


Input: root = [1,2,3,4,5]
Output: 3
Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].
Example 2:

Input: root = [1,2]
Output: 1


Constraints:

The number of nodes in the tree is in the range [1, 104].
-100 <= Node.val <= 100
*/

/* Solution 1:
dfs
check pathe left & right node
if final maxD == 0, return 0, otherwise, return maxD-1

Time Complexity: O(N). We visit every node once.
Space Complexity: O(N)O(N), the size of our implicit call stack during our depth-first search.
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
    // number of node in longest path
    int maxD = 0;
    public int diameterOfBinaryTree(TreeNode root) {
        check(root);
        return Math.max(0, maxD-1);
    }

    public int check(TreeNode root) {
        if (root == null) { return 0; }
        int left = check(root.left);
        int right = check(root.right);
        maxD = Math.max(maxD, left+right+1);
        return 1+Math.max(left, right);
    }
}