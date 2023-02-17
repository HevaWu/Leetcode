/*
Given the root of a Binary Search Tree (BST), return the minimum difference between the values of any two different nodes in the tree.



Example 1:


Input: root = [4,2,6,1,3]
Output: 1
Example 2:


Input: root = [1,0,48,null,null,12,49]
Output: 1


Constraints:

The number of nodes in the tree is in the range [2, 100].
0 <= Node.val <= 105
*/

/*
Solution 2:
recursively check each node,
compare its left most value and right most value

Time Complexity: O(n)
Space Complexity: O(1)
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
    private int minDiff = 100001;
    public int minDiffInBST(TreeNode root) {
        checkDiff(root, -1, -1);
        return minDiff;
    }

    private void checkDiff(TreeNode node, int lMost, int rMost) {
    if (node == null) {
      return;
    }
    if (lMost != -1) {
      minDiff = Math.min(minDiff, node.val - lMost);
    }
    if (rMost != -1) {
      minDiff = Math.min(minDiff, rMost - node.val);
    }
    checkDiff(node.left, lMost, node.val);
    checkDiff(node.right, node.val, rMost);
  }
}
