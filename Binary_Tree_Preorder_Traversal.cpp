/*144. Binary Tree Preorder Traversal Add to List
Description  Submission  Solutions
Total Accepted: 166222
Total Submissions: 381001
Difficulty: Medium
Contributors: Admin
Given a binary tree, return the preorder traversal of its nodes' values.

For example:
Given binary tree {1,#,2,3},
   1
    \
     2
    /
   3
return [1,2,3].

Note: Recursive solution is trivial, could you do it iteratively?

Hide Tags Tree Stack
Hide Similar Problems (M) Binary Tree Inorder Traversal (M) Verify Preorder
Sequence in Binary Search Tree
*/

/*Similar to the postorder traversal
Use Stack to store the node
first, we push the root
then the right, left
and pop them one by one*/
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
  vector<int> preorderTraversal(TreeNode* root) {
    stack<TreeNode*> nodeS;
    vector<int> ret;
    if (!root) return ret;
    nodeS.push(root);
    while (!nodeS.empty()) {
      TreeNode* temp = nodeS.top();
      nodeS.pop();
      ret.push_back(temp->val);
      if (temp->right) nodeS.push(temp->right);
      if (temp->left) nodeS.push(temp->left);
    }
    return ret;
  }
};
