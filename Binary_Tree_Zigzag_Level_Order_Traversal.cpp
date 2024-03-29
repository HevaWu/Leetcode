/*103. Binary Tree Zigzag Level Order Traversal  QuestionEditorial Solution  My
Submissions Total Accepted: 69853 Total Submissions: 230970 Difficulty: Medium
Given a binary tree, return the zigzag level order traversal of its nodes'
values. (ie, from left to right, then right to left for the next level and
alternate between).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its zigzag level order traversal as:
[
  [3],
  [20,9],
  [15,7]
]
Subscribe to see which companies asked this question*/

/*BFS
for each level, through the size of queue to control the size of vector
using a boolean variable leftToRight to control the position to fill node's
value*/
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
  vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
    if (root == NULL) {
      return vector<vector<int>>();
    }

    vector<vector<int>> ret;
    queue<TreeNode*> q;
    q.push(root);
    bool leftToRight = true;

    while (!q.empty()) {
      int size = q.size();
      //   cout << size;
      vector<int> row(size);
      for (int i = 0; i < size; i++) {
        TreeNode* node = q.front();
        q.pop();

        // find the position to fill node's value
        int index = (leftToRight) ? i : (size - 1 - i);

        row[index] = node->val;
        if (node->left) {
          q.push(node->left);
        }
        if (node->right) {
          q.push(node->right);
        }
      }
      leftToRight = !leftToRight;  // after this level
      ret.push_back(row);
    }
    return ret;
  }
};
