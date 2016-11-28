/*222. Count Complete Tree Nodes  QuestionEditorial Solution  My Submissions
Total Accepted: 41740
Total Submissions: 158638
Difficulty: Medium
Given a complete binary tree, count the number of nodes.

Definition of a complete binary tree from Wikipedia:
In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

Subscribe to see which companies asked this question*/



/*DFS
check the left subtree is perfect or not
start from the left node, since it is a complete tree, search from both left and right node
if the right node is null, check if the left node is null, if not
there should be some node under the left node, count these node
if the left node is null, this node is a leaf node, we can traverse the root.right*/

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
    int countNodes(TreeNode* root) {
        if(!root) return 0;
        int count = 1;
        TreeNode *curL(root->left);
        TreeNode *curR(root->left);  //both start at the left node
        while(curR){
            curL = curL->left;
            curR = curR->right;
            count = count << 1;
        }
        return count + ((!curL) ? countNodes(root->right) : countNodes(root->left));
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
    public int countNodes(TreeNode root) {
        if(root==null) return 0;
        int count = 1;
        TreeNode curL = root.left;
        TreeNode curR = root.left;
        while(curR != null){
            curL = curL.left;
            curR = curR.right;
            count = count << 1;
        }
        return count + ((curL==null) ? countNodes(root.right) : countNodes(root.left));
    }
}