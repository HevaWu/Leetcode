/*
Given the root of a binary tree, return the inorder traversal of its nodes' values.



Example 1:


Input: root = [1,null,2,3]
Output: [1,3,2]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [1]
Output: [1]
Example 4:


Input: root = [1,2]
Output: [2,1]
Example 5:


Input: root = [1,null,2]
Output: [1,2]


Constraints:

The number of nodes in the tree is in the range [0, 100].
-100 <= Node.val <= 100


Follow up:

Recursive solution is trivial, could you do it iteratively?
*/

/*Use Stack to store the Tree node
always push the left node of the root into the stack, then add the left into the list/vector
then push the right node */
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 * int val;
 * TreeNode left;
 * TreeNode right;
 * TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> ret = new LinkedList<>();
        TreeNode cur = root;
        Stack<TreeNode> S = new Stack<>();

        while (cur != null || !S.empty()) {
            while (cur != null) {
                S.add(cur);
                cur = cur.left;
            }
            cur = S.pop();
            ret.add(cur.val);
            cur = cur.right;
        }

        return ret;
    }
}

// use recursive
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 * int val;
 * TreeNode left;
 * TreeNode right;
 * TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> inlist = new ArrayList<>();
        if (root == null) {
            return inlist;
        }
        inorderTree(root, inlist);
        return inlist;
    }

    public void inorderTree(TreeNode root, List<Integer> inlist) {
        if (root == null)
            return;
        if (root.left != null) {
            inorderTree(root.left, inlist);
        }
        inlist.add(root.val);
        if (root.right != null) {
            inorderTree(root.right, inlist);
        }
    }
}
