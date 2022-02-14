/*
Given the root of a binary tree, return its maximum depth.

A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: 3
Example 2:

Input: root = [1,null,2]
Output: 2
Example 3:

Input: root = []
Output: 0
Example 4:

Input: root = [0]
Output: 1


Constraints:

The number of nodes in the tree is in the range [0, 104].
-100 <= Node.val <= 100
*/

/*
Solution 2:
DFS use stack

Time Complexity: O(n)
Space Complexity: O(logn)
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
    public int maxDepth(TreeNode root) {
        if (root == null) { return 0; }
        Stack<SNode> stack = new Stack<>();
        stack.push(new SNode(root, 1));
        int depth = 0;
        while (!stack.isEmpty()) {
            SNode cur = stack.pop();
            if (cur.node.left == null && cur.node.right == null) {
                depth = Math.max(depth, cur.level);
            } else {
                if (cur.node.left != null) {
                    stack.push(new SNode(cur.node.left, cur.level+1));
                }
                if (cur.node.right != null) {
                    stack.push(new SNode(cur.node.right, cur.level+1));
                }
            }
        }
        return depth;
    }
}

class SNode {
    int level;
    TreeNode node;
    SNode(TreeNode node, int level) {
        this.level = level;
        this.node = node;
    }
}

/*
Solution 1:
DFS recursive
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
    public int maxDepth(TreeNode root) {
        if (root == null) { return 0; }
        return 1+Math.max(maxDepth(root.left), maxDepth(root.right));
    }
}