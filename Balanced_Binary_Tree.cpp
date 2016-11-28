/*
Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.
*/



/*DFS
when the sub tree of the current node is balanced, return the height of the tree
otherwise return -1*/

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
    int ifbalance(TreeNode* node1) //return depth if it is the balanced, else return -1
    {
        if(!node1) return 0; 
        int lc = ifbalance(node1->left);
        int rc = ifbalance(node1->right);
        if(lc>=0 && rc>=0 && abs(lc-rc)<=1) return 1+max(lc,rc);
        else return -1;
    }
    
    bool isBalanced(TreeNode* root) {
        return ifbalance(root) >= 0;
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
    public boolean isBalanced(TreeNode root) {
        return ifBalanced(root) >= 0;
    }
    
    public int ifBalanced(TreeNode root){
        if(root==null) return 0;
        int lc = ifBalanced(root.left);
        int rc = ifBalanced(root.right);
        
        if(lc>=0 && rc>=0 && Math.abs(lc-rc)<=1) return 1+Math.max(lc,rc);
        else return -1;
    }
}