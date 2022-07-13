/*
Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its level order traversal as:
[
  [3],
  [9,20],
  [15,7]
]
*/


/*
BFS
recursively push the node in pre-order
use "level" variable to control which list it should be in
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
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
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> ret = new LinkedList<>();
        Order(ret, root, 0);
        return ret;
    }

    public void Order(List<List<Integer> > ret, TreeNode root, int level){
        if(root == null){
            return;
        }

        if(ret.size() == level){
            ret.add(new LinkedList<>());
        }

        ret.get(level).add(root.val);
        Order(ret, root.left, level+1);
        Order(ret, root.right, level+1);
    }
}
