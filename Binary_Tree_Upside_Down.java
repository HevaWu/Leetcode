/*156. Binary Tree Upside Down Add to List
Description  Submission  Solutions
Total Accepted: 21881
Total Submissions: 50571
Difficulty: Medium
Contributors: Admin
Given a binary tree where all the right nodes are either leaf nodes with a sibling (a left node that shares the same parent node) or empty, flip it upside down and turn it into a tree where the original right nodes turned into left leaf nodes. Return the new root.

For example:
Given a binary tree {1,2,3,4,5},
    1
   / \
  2   3
 / \
4   5
return the root of the binary tree [4,5,2,#,#,3,1].
   4
  / \
 5   2
    / \
   3   1
confused what "{1,#,2,3}" means? > read more on how binary tree is serialized on OJ.

Hide Company Tags LinkedIn
Hide Tags Tree
Hide Similar Problems (E) Reverse Linked List
 */






/*
Solution 1 = Solution 2

Solution 1 recursive
O(1) space
Each time update the newNode of upsideDownBinaryTree(root.left)
root.left.left = root.right;
root.left.right = root;
root.left = null;
root.right = null;

Solution 2 iterative
O(n) space
set four node to help finish this function
"pre" the pre node of cur, init null
"cur" init root
"lnode" should be the left child of pre, init null
"rnode" should be the right child of pre, init null
            lnode = cur.left;
            cur.left = rnode;
            rnode = cur.right;
            cur.right = pre;
            pre = cur;
            cur = lnode;
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
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
    public TreeNode upsideDownBinaryTree(TreeNode root) {
        //we could only check one of the child node, if this child node is null, the other mush be null
        if(root == null || root.left==null) return root;

        TreeNode newNode = upsideDownBinaryTree(root.left);

        root.left.left = root.right;
        root.left.right = root;

        //update the root's child
        root.left = null;
        root.right = null;

        return newNode;
    }
}



//Solution 2
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
    public TreeNode upsideDownBinaryTree(TreeNode root) {
        if(root == null) return root;

        TreeNode pre = null;
        TreeNode cur = root;
        TreeNode next = null;
        TreeNode temp = null;
        while(cur != null){
            next = cur.left;

            //swapping node, temp to keep pre.right
            cur.left = temp;
            temp = cur.right;
            cur.right = pre;

            pre = cur;
            cur = lnode;
        }
        return pre;
    }
}
