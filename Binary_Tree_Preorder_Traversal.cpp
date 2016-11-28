/*144. Binary Tree Preorder Traversal  QuestionEditorial Solution  My Submissions
Total Accepted: 137858
Total Submissions: 332406
Difficulty: Medium
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

Subscribe to see which companies asked this question*/



/*Similar to the postorder traversal
Use Stack to store the node 
first, we push the root
then the right, left
and pop them one by one*/

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
    vector<int> preorderTraversal(TreeNode* root) {
        stack<TreeNode*> nodeS;
        vector<int> ret;
        if(!root) return ret;
        nodeS.push(root);
        while(!nodeS.empty()){
            TreeNode* temp = nodeS.top();
            nodeS.pop();
            ret.push_back(temp->val);
            if(temp->right) nodeS.push(temp->right);
            if(temp->left) nodeS.push(temp->left);
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
    public List<Integer> preorderTraversal(TreeNode root) {
        Deque<TreeNode> nodeS = new ArrayDeque<>();
        List<Integer> ret = new LinkedList<>();
        if(root==null) return ret;
        nodeS.push(root);
        while(!nodeS.isEmpty()){
            TreeNode temp = nodeS.pop();
            ret.add(temp.val);
            if(temp.right!=null) nodeS.push(temp.right);
            if(temp.left!=null) nodeS.push(temp.left);
        }
        return ret;
    }
}