/*199. Binary Tree Right Side View Add to List
Description  Submission  Solutions
Total Accepted: 71283
Total Submissions: 181103
Difficulty: Medium
Contributors: Admin
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

Hide Company Tags Amazon
Hide Tags Tree Depth-first Search Breadth-first Search
Hide Similar Problems (M) Populating Next Right Pointers in Each Node
*/

/*DFS
from set a level variable to control the layer of the tree we have already seen
after the right node, we see if there is a left node, if is, we pushback this node.val*/
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







