/*
Given a binary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
*/




/*If this node is a leaf node, return 0
else return the max depth of the left child and right child*/

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
    int maxDepth(TreeNode* root) {
        if(!root) return 0;  //mention that if the root == NULL, need to consider this simulation
        int lt = maxDepth(root->left);
        int rt = maxDepth(root->right);
        if(lt>=0 && rt>=0) return 1+max(lt,rt);
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
    public int maxDepth(TreeNode root) {
        if(root==null) return 0;
        int lt = maxDepth(root.left);
        int rt = maxDepth(root.right);
        return Math.max(lt,rt)+1;
    }
}