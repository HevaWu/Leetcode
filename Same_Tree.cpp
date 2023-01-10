/*
Given two binary trees, write a function to check if they are equal or not.

Two binary trees are considered equal if they are structurally identical and the
nodes have the same value.
*/

/*
Solution 2:
iterative

use pQueue qQueue to help memo current checking one

Time Complexity: O(n)
Space Complexity:
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
*/
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode() : val(0), left(nullptr), right(nullptr) {}
 *     TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 *     TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left),
 * right(right) {}
 * };
 */
class Solution {
 public:
  bool isSameTree(TreeNode* p, TreeNode* q) {
    queue<TreeNode*> pQueue;
    pQueue.push(p);

    queue<TreeNode*> qQueue;
    qQueue.push(q);
    while (!pQueue.empty() && !qQueue.empty()) {
      TreeNode* curP = pQueue.front();
      pQueue.pop();
      TreeNode* curQ = qQueue.front();
      qQueue.pop();

      if (curP == nullptr && curQ == nullptr) {
        continue;
      }
      if (curP == nullptr || curQ == nullptr) {
        return false;
      }

      if (curP->val != curQ->val) {
        return false;
      }
      pQueue.push(curP->left);
      pQueue.push(curP->right);

      qQueue.push(curQ->left);
      qQueue.push(curQ->right);
    }
    return pQueue.empty() && qQueue.empty();
  }
};

/*compare each node.val at the same position of two trees*/

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
  bool isSameTree(TreeNode* p, TreeNode* q) {
    if (p == NULL || q == NULL) return (p == q);  // using || rather than &&
    return (p->val == q->val && isSameTree(p->left, q->left) &&
            isSameTree(p->right, q->right));
  }
};
