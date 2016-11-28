/*199. Binary Tree Right Side View  QuestionEditorial Solution  My Submissions
Total Accepted: 51727
Total Submissions: 141194
Difficulty: Medium
Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

For example:
Given the following binary tree,
   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---
You should return [1, 3, 4].

Credits:
Special thanks to @amrsaqr for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/





/*DFS
from set a level variable to control the layer of the tree we have already seen
after the right node, we see if there is a left node, if is, we pushback this node.val*/

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
    vector<int> rightSideView(TreeNode* root) {
        vector<int> ret;
        seeRight(root, 1, ret);
        return ret;
    }
    
    void seeRight(TreeNode *root, int level, vector<int>& ret){
        if(root == NULL){
            return;
        }
        
        if(ret.size()<level){
            ret.push_back(root->val);
        }
        
        seeRight(root->right, level + 1, ret);
        seeRight(root->left, level + 1, ret);
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
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> ret = new ArrayList<Integer>();
        seeRight(root, 1, ret);
        return ret;
    }
    
    public void seeRight(TreeNode root, int level, List<Integer> ret){
        if(root == null){
            return;
        }
        
        if(ret.size() < level){
            ret.add(root.val);
        }
        
        seeRight(root.right, level + 1, ret);
        seeRight(root.left, level + 1, ret);
    }
}