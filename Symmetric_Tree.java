/*
Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

For example, this binary tree [1,2,2,3,4,4,3] is symmetric:

    1
   / \
  2   2
 / \ / \
3  4 4  3


But the following [1,2,2,null,3,null,3] is not:

    1
   / \
  2   2
   \   \
   3    3


Follow up: Solve it both recursively and iteratively.
*/

/*
Solution 1: Top down
recursively check if
- first.left == second.right
- first.right == second.left
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public boolean isSymmetric(TreeNode root) {
        if(root == null){
            return true;
        }

        return CheckSymmetric(root.left, root.right);
    }

    public boolean CheckSymmetric(TreeNode left, TreeNode right){
        if(left==null && right==null){
            return true;
        } else if(left==null || right==null){
            return false;
        }

        if(left.val != right.val){
            return false;
        }

        return CheckSymmetric(left.left,right.right) && CheckSymmetric(left.right, right.left);
    }
}
