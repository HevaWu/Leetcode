/*94. Binary Tree Inorder Traversal Add to List
Description  Submission  Solutions
Total Accepted: 182020
Total Submissions: 408092
Difficulty: Medium
Contributors: Admin
Given a binary tree, return the inorder traversal of its nodes' values.

For example:
Given binary tree [1,null,2,3],
   1
    \
     2
    /
   3
return [1,3,2].

Note: Recursive solution is trivial, could you do it iteratively?

Hide Company Tags Microsoft
Hide Tags Tree Hash Table Stack
Hide Similar Problems (M) Validate Binary Search Tree (M) Binary Tree Preorder Traversal (H) Binary Tree Postorder Traversal (M) Binary Search Tree Iterator (M) Kth Smallest Element in a BST (H) Closest Binary Search Tree Value II (M) Inorder Successor in BST
*/

/*Use Stack to store the Tree node
always push the left node of the root into the stack, then add the left into the list/vector
then push the right node */
// C++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution
{
public:
    vector<int> inorderTraversal(TreeNode *root)
    {
        vector<int> ret;
        TreeNode *cur = root;
        stack<TreeNode *> S;

        while (cur || !S.empty())
        {
            while (cur)
            {
                S.push(cur);
                cur = cur->left;
            }
            cur = S.top();
            S.pop();
            ret.push_back(cur->val);
            cur = cur->right;
        }

        return ret;
    }
};
