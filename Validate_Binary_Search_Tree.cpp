/*98. Validate Binary Search Tree  QuestionEditorial Solution  My Submissions
Total Accepted: 107794
Total Submissions: 500597
Difficulty: Medium
Given a binary tree, determine if it is a valid binary search tree (BST).

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.
Example 1:
    2
   / \
  1   3
Binary tree [2,1,3], return true.
Example 2:
    1
   / \
  2   3
Binary tree [1,2,3], return false.*/



/*Set the min_value and max_value
the left child should always less than the root.val
the right child should always larger than the root.val
update the min_value and max_value after each recursive
when check the left child, we set the max value as root.val
when check the right child, we set the min value as root.val*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    bool isValidBST(TreeNode* root) {
        return isValid(root, LONG_MIN, LONG_MAX);
    }
    
    bool isValid(TreeNode* root, long min, long max){ // should be "long"
        if(!root) return true;
        if(root->val>=max || root->val<=min) return false;
        // cout << root->val;
        return isValid(root->left, min, root->val) && isValid(root->right, root->val, max);
    }
};





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
    public boolean isValidBST(TreeNode root) {
        return isValid(root, Long.MIN_VALUE, Long.MAX_VALUE);
    }
    
    public boolean isValid(TreeNode root, long min, long max){
        if(root==null) return true;
        if(root.val>=max || root.val<=min) return false;
        return isValid(root.left, min, root.val) && isValid(root.right, root.val, max);
    }
}