/*129. Sum Root to Leaf Numbers  QuestionEditorial Solution  My Submissions
Total Accepted: 85895
Total Submissions: 253504
Difficulty: Medium
Given a binary tree containing digits from 0-9 only, each root-to-leaf path could represent a number.

An example is the root-to-leaf path 1->2->3 which represents the number 123.

Find the total sum of all root-to-leaf numbers.

For example,

    1
   / \
  2   3
The root-to-leaf path 1->2 represents the number 12.
The root-to-leaf path 1->3 represents the number 13.

Return the sum = 12 + 13 = 25.

Subscribe to see which companies asked this question*/



/*Once find one leaf node, current num value *10+ node.value
if this node is not a leaf node, recursively do sumTree(root, num*10+root.val) until find the leaf node*/
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
    int sumNumbers(TreeNode* root) {
        return sumTree(root, 0);
    }

    int sumTree(TreeNode* root, int num){
        if(!root) return 0;
        if(!root->left && !root->right){
            return num*10+root->val;
        }
        return sumTree(root->left, num*10+root->val) + sumTree(root->right, num*10+root->val);
    }
};





