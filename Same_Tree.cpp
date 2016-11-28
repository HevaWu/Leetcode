/*
Given two binary trees, write a function to check if they are equal or not.

Two binary trees are considered equal if they are structurally identical and the nodes have the same value.
*/





/*compare each node.val at the same position of two trees*/

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
    bool isSameTree(TreeNode* p, TreeNode* q) {
        if(p == NULL || q == NULL) return (p == q);   //using || rather than &&
        return (p->val == q->val && isSameTree(p->left,q->left) && isSameTree(p->right,q->right));
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
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if(p==null || q==null) return(p==q);
        return (q.val==p.val && isSameTree(p.left, q.left) && isSameTree(p.right, q.right));
    }
}