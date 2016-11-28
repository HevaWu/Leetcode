/*124. Binary Tree Maximum Path Sum  QuestionEditorial Solution  My Submissions
Total Accepted: 72211
Total Submissions: 299805
Difficulty: Hard
Given a binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path does not need to go through the root.

For example:
Given the below binary tree,

       1
      / \
     2   3
Return 6.

Subscribe to see which companies asked this question*/



/*A recursive method maxPath(TreeNode node) (1) computes the maximum path sum with highest node is the input node, update maximum if necessary (2) returns the maximum sum of the path that can be extended to input node's parent.*/

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
    int maxValue;
public:
    int maxPathSum(TreeNode* root) {
        maxValue = INT_MIN; //return the minvalue of the integer
        maxPath(root);
        return maxValue;
    }
    
    int maxPath(TreeNode* root){
        if(!root) return 0;
        int left = max(0, maxPath(root->left));
        int right = max(0, maxPath(root->right));
        maxValue = max(maxValue, left+right+root->val);
        return max(left, right) + root->val;
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
    private int maxValue;
    
    public int maxPathSum(TreeNode root) {
        maxValue = Integer.MIN_VALUE;
        maxPath(root);
        return maxValue;
    }
    
    public int maxPath(TreeNode root){
        if(root == null) return 0;
        int left = Math.max(0, maxPath(root.left));
        int right = Math.max(0, maxPath(root.right));
        maxValue = Math.max(maxValue, left + right + root.val);
        return Math.max(left, right) + root.val;
    }
}