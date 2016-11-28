/*105. Construct Binary Tree from Preorder and Inorder Traversal  QuestionEditorial Solution  My Submissions
Total Accepted: 73485
Total Submissions: 246725
Difficulty: Medium
Given preorder and inorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.*/




/*the first node of preorder is the root node,
we can find the root node in inorder array, 
the left side of the root node is the left node
the right side of the root node is the right node
recursively do this, can build a tree*/

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
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        int size = inorder.size() - 1;
        return buildTree(0, 0, size, preorder, inorder);  //transfer from vector<int>::size_type to int type
    }
    
    TreeNode* buildTree(int Spre, int Sin, int Ein, vector<int>& preorder, vector<int>& inorder){
        if(Spre>preorder.size()-1 || Sin>Ein) return NULL;
        
        TreeNode* root = new TreeNode(preorder[Spre]);
        int index = 0;//mark the index of the current root in inorder array
        for(int i = Sin; i <= Ein; i++){
            if(inorder[i] == root->val){
                index = i;
            }
        }
        
        root->left = buildTree(Spre+1, Sin, index-1, preorder, inorder);
        root->right = buildTree(Spre + index - Sin + 1, index + 1, Ein, preorder, inorder);
        
        return root;
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