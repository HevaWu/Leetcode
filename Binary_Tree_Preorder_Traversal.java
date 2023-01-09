/*
Given the root of a binary tree, return the preorder traversal of its nodes' values.



Example 1:


Input: root = [1,null,2,3]
Output: [1,2,3]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [1]
Output: [1]
Example 4:


Input: root = [1,2]
Output: [1,2]
Example 5:


Input: root = [1,null,2]
Output: [1,2]


Constraints:

The number of nodes in the tree is in the range [0, 100].
-100 <= Node.val <= 100


Follow up:

Recursive solution is trivial, could you do it iteratively?
*/

/*Similar to the postorder traversal
Use Stack to store the node
first, we push the root
then the right, left
and pop them one by one*/
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
    public List<Integer> preorderTraversal(TreeNode root) {
        Deque<TreeNode> nodeS = new ArrayDeque<>();
        List<Integer> ret = new LinkedList<>();
        if(root==null) return ret;
        nodeS.push(root);
        while(!nodeS.isEmpty()){
            TreeNode temp = nodeS.pop();
            ret.add(temp.val);
            if(temp.right!=null) nodeS.push(temp.right); //first push right, then push left
            if(temp.left!=null) nodeS.push(temp.left);
        }
        return ret;
    }
}
