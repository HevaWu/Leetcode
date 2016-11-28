/*
Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

For example, this binary tree is symmetric:

    1
   / \
  2   2
 / \ / \
3  4 4  3
But the following is not:
    1
   / \
  2   2
   \   \
   3    3
Note:
Bonus points if you could solve it both recursively and iteratively.

confused what "{1,#,2,3}" means? > read more on how binary tree is serialized on OJ.
*/



/*BFS
Search the left node and right node at the same time
recursively check the node*/

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
    bool isSymmetric(TreeNode* root) {
        if(!root) return true;
        return CheckSymmetric(root->left, root->right);
    }
    
    bool CheckSymmetric(TreeNode* lNode, TreeNode* rNode){
        if(!lNode && !rNode) return true;  //both child is NULL, true
        else if(!lNode || !rNode) return false;  //if there is only one child is NULL, should return false
        
        if(lNode->val != rNode->val) return false;
        return CheckSymmetric(lNode->left, rNode->right) && CheckSymmetric(lNode->right, rNode->left);
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