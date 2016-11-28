/*298. Binary Tree Longest Consecutive Sequence  QuestionEditorial Solution  My Submissions
Total Accepted: 15143 Total Submissions: 39265 Difficulty: Medium
Given a binary tree, find the length of the longest consecutive sequence path.

The path refers to any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The longest consecutive path need to be from parent to child (cannot be the reverse).

For example,
   1
    \
     3
    / \
   2   4
        \
         5
Longest consecutive sequence path is 3-4-5, so return 3.
   2
    \
     3
    / 
   2    
  / 
 1
Longest consecutive sequence path is 2-3,not3-2-1, so return 2.
Hide Company Tags Google
Hide Tags Tree
Hide Similar Problems (H) Longest Consecutive Sequence
*/



/*DFS
for each node, check if it current val is its parent val+1,
if it is, len should be len+1, else len should be 1
then, check the len of its left node and right node*/

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
    int longestConsecutive(TreeNode* root) {
        return nodeLength(root, nullptr, 0);
    }
    
    int nodeLength(TreeNode* root, TreeNode* parent, int len){
        if(!root) return len;
        len = (parent && root->val==parent->val+1) ? len+1 : 1;
        return max(len, 
            max(nodeLength(root->left,root,len),nodeLength(root->right,root,len)));
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
    public int longestConsecutive(TreeNode root) {
        return nodeLength(root, null, 0);
    }
    
    public int nodeLength(TreeNode root, TreeNode parent, int len){
        if(root==null) return len;
        len = (parent!=null && root.val==parent.val+1) ? len+1 : 1;
        return Math.max(len,
            Math.max(nodeLength(root.left,root,len),nodeLength(root.right,root,len) ));
    }
}
