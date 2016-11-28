/*106. Construct Binary Tree from Inorder and Postorder Traversal  QuestionEditorial Solution  My Submissions
Total Accepted: 63446
Total Submissions: 211299
Difficulty: Medium
Given inorder and postorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.

Subscribe to see which companies asked this question*/




/*use two index point to the two array
start from the back of the array 
if the back of the inorder array is same to the back of the postorder array, this node has not right child, else, we need to build the right node
each time we pass the current node into the function, if currentnode.val != the back of inorder array, we should build the left subtree for this tree*/

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
private:
    int indexIn;
    int indexPost;
    
public:
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
        indexIn = inorder.size() - 1;
        indexPost = postorder.size() - 1;
        return buildTree(inorder, postorder, NULL);
    }
    
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder, TreeNode* cur){
        if(indexPost < 0) return NULL;
        
        TreeNode* newNode = new TreeNode(postorder[indexPost--]);
        if(inorder[indexIn] != newNode->val){
            newNode->right = buildTree(inorder, postorder, newNode);
        }
        
        indexIn--;
        
        if(!cur || inorder[indexIn] != cur->val){
            newNode->left = buildTree(inorder, postorder, cur);
        }
        
        return newNode;
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
    private int indexIn;
    private int indexPost;
    
    public TreeNode buildTree(int[] inorder, int[] postorder) {
        indexIn = inorder.length - 1;
        indexPost = postorder.length - 1;
        
        return buildTree(inorder, postorder, null);
    }
    
    public TreeNode buildTree(int[] inorder, int[] postorder, TreeNode cur){
        if(indexPost < 0) return null;
        
        TreeNode newNode = new TreeNode(postorder[indexPost--]);
        if(inorder[indexIn] != newNode.val){
            newNode.right = buildTree(inorder, postorder, newNode);
        }
        
        indexIn--;
        
        if(cur==null || inorder[indexIn]!=cur.val){
            newNode.left = buildTree(inorder, postorder, cur);
        }
        
        return newNode;
    }
}