/*124. Binary Tree Maximum Path Sum Add to List
Description  Submission  Solutions
Total Accepted: 88554
Total Submissions: 349937
Difficulty: Hard
Contributors: Admin
Given a binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting
node to any node in the tree along the parent-child connections. The path must
contain at least one node and does not need to go through the root.

For example:
Given the below binary tree,

       1
      / \
     2   3
Return 6.

Hide Company Tags Microsoft Baidu
Hide Tags Tree Depth-first Search
Hide Similar Problems (E) Path Sum (M) Sum Root to Leaf Numbers
*/

/*A recursive method maxPath(TreeNode node)
(1) computes the maximum path sum with highest node is the input node, update
maximum if necessary (2) returns the maximum sum of the path that can be
extended to input node's parent.*/

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
    maxValue = INT_MIN;  // return the minvalue of the integer
    maxPath(root);
    return maxValue;
  }

  int maxPath(TreeNode* root) {
    if (!root) return 0;
    int left = max(0, maxPath(root->left));
    int right = max(0, maxPath(root->right));
    maxValue = max(maxValue, left + right + root->val);
    return max(left, right) + root->val;
  }
};
