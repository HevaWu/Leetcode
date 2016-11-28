/*94. Binary Tree Inorder Traversal  QuestionEditorial Solution  My Submissions
Total Accepted: 144013
Total Submissions: 346392
Difficulty: Medium
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

Subscribe to see which companies asked this question*/



/*Use Stack to store the Tree node
always push the left node of the root into the stack, then add the left into the list/vector
then push the right node */

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
    vector<int> inorderTraversal(TreeNode* root) {
        vector<int> ret;
        TreeNode* cur = root;
        stack<TreeNode*> S;
        
        while(cur || !S.empty()){
            while(cur){
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
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> ret = new LinkedList<>();
        TreeNode cur = root;
        Stack<TreeNode> S = new Stack<>();
        
        while(cur!=null || !S.empty()){
            while(cur!=null){
                S.add(cur);
                cur = cur.left;
            }
            cur = S.pop();
            ret.add(cur.val);
            cur = cur.right;
        }
        
        return ret;
    }
}