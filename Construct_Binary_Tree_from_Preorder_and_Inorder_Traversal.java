/*
Given inorder and postorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.

For example, given

inorder = [9,3,15,20,7]
postorder = [9,15,7,20,3]
Return the following binary tree:

    3
   / \
  9  20
    /  \
   15   7
*/

/*
Solution 1:

use indexIn, indexPost to memo where we go through from inorder and postorder
- always set newNode from postorder[indexPost]
- if inorder[indexIn] != newNode.val, this node should at newNode right part
  - newNode.right = _build(newNode)
- if node == nil || inorder[indexIn] != node.val, this node should be at newNode left side
  - newNode.left = _build(node)
return newNode
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
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        return buildTree(0, 0, inorder.length-1, preorder, inorder);
    }

    public TreeNode buildTree(int Spre, int Sin, int Ein, int[] preorder, int[] inorder){
        if(Spre>preorder.length-1 || Sin>Ein) return null;

        TreeNode root = new TreeNode(preorder[Spre]);
        int index = 0;
        for(int i = Sin; i <= Ein; i++){
            if(inorder[i] == root.val){
                index = i;
            }
        }

        root.left = buildTree(Spre+1, Sin, index-1, preorder, inorder);
        root.right = buildTree(Spre+index-Sin+1, index+1, Ein, preorder, inorder);

        return root;
    }
}