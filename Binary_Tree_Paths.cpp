/*
Given a binary tree, return all root-to-leaf paths.

For example, given the following binary tree:

   1
 /   \
2     3
 \
  5
All root-to-leaf paths are:

["1->2->5", "1->3"]
*/





/*DFS*/
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
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> rootToLeaf;
        if(!root) return rootToLeaf;
        
        RootToLeafPaths(root, rootToLeaf, to_string(root->val));   //using to_string to transfer integer
        return rootToLeaf;
    }
    
    void RootToLeafPaths(TreeNode *root, vector<string>& rootToLeaf, string path1)  //do not forget "&"
    {
        if(!root->left && !root->right)
        {
            rootToLeaf.push_back(path1);  //using push_back
            return;
        }
        
        if(root->left) RootToLeafPaths(root->left, rootToLeaf, path1+"->"+to_string(root->left->val));
        if(root->right) RootToLeafPaths(root->right, rootToLeaf, path1+"->"+to_string(root->right->val));
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
    public List<String> binaryTreePaths(TreeNode root) {
        List<String> ret = new LinkedList<>();
        if(root != null){
            rootToString(ret, root, "");
        }
        
        return ret;
    }
    
    public void rootToString(List<String> ret, TreeNode root, String path){
        if(root.left == null && root.right == null){
            ret.add(path + root.val);
        }
        if(root.left != null){
            rootToString(ret, root.left, path + root.val + "->");
        }
        if(root.right != null){
            rootToString(ret, root.right, path + root.val + "->");
        }
    }
}