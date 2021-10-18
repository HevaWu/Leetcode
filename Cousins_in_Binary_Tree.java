/*
Given the root of a binary tree with unique values and the values of two different nodes of the tree x and y, return true if the nodes corresponding to the values x and y in the tree are cousins, or false otherwise.

Two nodes of a binary tree are cousins if they have the same depth with different parents.

Note that in a binary tree, the root node is at the depth 0, and children of each depth k node are at the depth k + 1.



Example 1:


Input: root = [1,2,3,4], x = 4, y = 3
Output: false
Example 2:


Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
Output: true
Example 3:


Input: root = [1,2,3,null,4], x = 2, y = 3
Output: false


Constraints:

The number of nodes in the tree is in the range [2, 100].
1 <= Node.val <= 100
Each node has a unique value.
x != y
x and y are exist in the tree.
*/

/*
Solution 2:
BFS check same depth node

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
    public boolean isCousins(TreeNode root, int x, int y) {
        if (root == null) { return false; }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            int size = queue.size();

            boolean findX = false;
            boolean findY = false;
            for (int i = 0; i < size; i++) {
                TreeNode cur = queue.poll();
                if (cur.val == x) {
                    findX = true;
                }
                if (cur.val == y) {
                    findY = true;
                }

                // check children to see if it is possible have same parent
                if (cur.left != null && cur.right != null) {
                    if ((cur.left.val == x && cur.right.val == y)
                        || (cur.left.val == y && cur.right.val == x)) {
                        return false;
                    }
                }

                if (cur.left != null) {
                    queue.offer(cur.left);
                }
                if (cur.right != null) {
                    queue.offer(cur.right);
                }
            }

            if (findX && findY) { return true; }
            if (findX || findY) { return false; }
        }

        return false;
    }
}

/*
Solution 1:
use dx, dy, isSameParent to track status when go through the tree

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
    int dx = -1;
    int dy = -1;
    boolean isSameParent = false;

    public boolean isCousins(TreeNode root, int x, int y) {
        if (root == null) { return false; }

        check(root, x, y, 0);

        return ((dx == dy) && (dx != -1) && (isSameParent == false));
    }

    public void check(TreeNode node, int x, int y, int depth) {
        if (node == null) { return; }

        if ((node.left != null) && (node.left.val == x)) {
            isSameParent = ((node.right != null) && (node.right.val == y));
            dx = depth+1;
        } else if ((node.left != null) && (node.left.val == y)) {
            isSameParent = ((node.right != null) && (node.right.val == x));
            dy = depth+1;
        } else if ((node.right != null) && (node.right.val == x)) {
            isSameParent = ((node.left != null) && (node.left.val == y));
            dx = depth+1;
        } else if ((node.right != null) && (node.right.val == y)) {
            isSameParent = ((node.left != null) && (node.left.val == x));
            dy = depth+1;
        }

        if ((dx != -1) && (dy != -1)) {
            return ;
        } else {
            check(node.left, x, y, depth+1);
            check(node.right, x, y, depth+1);
        }
    }
}