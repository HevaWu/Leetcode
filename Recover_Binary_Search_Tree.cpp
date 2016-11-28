/*99. Recover Binary Search Tree  QuestionEditorial Solution  My Submissions
Total Accepted: 58204
Total Submissions: 210660
Difficulty: Hard
Two elements of a binary search tree (BST) are swapped by mistake.

Recover the tree without changing its structure.

Note:
A solution using O(n) space is pretty straight forward. Could you devise a constant space solution?*/



/*first of all, traverse the tree find the two elements which need to swap
then swap the values of two nodes
during traverse, we use three TreeNode to help find two nodes
to the first element, firstelement larger than the next one
the second element always smaller than the previous one*/

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
    TreeNode* first;
    TreeNode* second;
    TreeNode* pre = new TreeNode(INT_MIN);
    
public:
    void recoverTree(TreeNode* root) {
        traverse(root);
        
        int temp = first->val;
        first->val = second->val;
        second->val = temp;
    }
    
    void traverse(TreeNode* root){
        if(!root) return;
        
        traverse(root->left);
        if(!first && pre->val>=root->val){
            first = pre;
        }
        
        if(first && pre->val>=root->val){
            second = root;
        }
        
        pre = root; //remember update the pre
        traverse(root->right);
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
    private TreeNode first = null;
    private TreeNode second = null;
    private TreeNode pre = new TreeNode(Integer.MIN_VALUE); //initialzie to avoid null pointer exception in the first comparison
    
    public void recoverTree(TreeNode root) {
        traverse(root);  //traverse the tree, find two elements
        
        //swap the value of two elements
        int temp = first.val;
        first.val = second.val;
        second.val = temp;
    }
    
    public void traverse(TreeNode root){
        if(root==null) return;
        
        traverse(root.left);
        
        if(first==null && pre.val>=root.val){
            first = pre;
        }
        
        if(first!=null && pre.val>=root.val){
            second = root;
        }
        
        pre = root;
        traverse(root.right);
    }
}