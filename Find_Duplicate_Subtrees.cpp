/*
Given the root of a binary tree, return all duplicate subtrees.

For each kind of duplicate subtrees, you only need to return the root node of
any one of them.

Two trees are duplicate if they have the same structure with the same node
values.



Example 1:


Input: root = [1,2,3,4,null,2,4,null,null,4]
Output: [[2,4],[4]]
Example 2:


Input: root = [2,1,1]
Output: [[1]]
Example 3:


Input: root = [2,2,2,3,null,3,null]
Output: [[2,3],[3]]


Constraints:

The number of the nodes in the tree will be in the range [1, 10^4]
-200 <= Node.val <= 200
*/

/*
Solution 1:
map, dfs
serialize tree by "1,2,3,#,#" unique representation

when we found there are 2 subtree there, push node into res
Time Complexity: O(n^2) -> n is node number, each creation of cur, take O(n)
time Space Complexity: O(n^2) -> size of map
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
 private:
  unordered_map<string, int> map;
  vector<TreeNode*> res;

 public:
  vector<TreeNode*> findDuplicateSubtrees(TreeNode* root) {
    buildMap(root);
    return res;
  }

  string buildMap(TreeNode* node) {
    if (node == NULL) {
      return "#";
    }
    string cur = to_string(node->val);
    cur += ",";
    cur += buildMap(node->left);
    cur += ",";
    cur += buildMap(node->right);
    map[cur] += 1;
    if (map[cur] == 2) {
      res.push_back(node);
      // cout << cur << endl;
    }
    return cur;
  }
};
