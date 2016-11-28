/*145. Binary Tree Postorder Traversal  QuestionEditorial Solution  My Submissions
Total Accepted: 109426
Total Submissions: 296779
Difficulty: Hard
Given a binary tree, return the postorder traversal of its nodes' values.

For example:
Given binary tree {1,#,2,3},
   1
    \
     2
    /
   3
return [3,2,1].

Note: Recursive solution is trivial, could you do it iteratively?

Subscribe to see which companies asked this question*/



/*Use stack to store the node
push the node according to the order root-right-left, then reverse it
postorder: left-right-root
first, we push the root node
then, push the left node, then the right node
at the last, reverse the output*/

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
    vector<int> postorderTraversal(TreeNode* root) {
        stack<TreeNode*> nodeS;
        vector<int> ret;
        
        if(!root) return ret;
        nodeS.push(root);
        while(!nodeS.empty()){
            TreeNode *temp = nodeS.top();
            nodeS.pop();
            ret.push_back(temp->val);
            if(temp->left) nodeS.push(temp->left);
            if(temp->right) nodeS.push(temp->right);
        }
        reverse(ret.begin(), ret.end());
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
    public List<Integer> postorderTraversal(TreeNode root) {
        Deque<TreeNode> nodeS = new ArrayDeque<TreeNode>();
        List<Integer> ret = new LinkedList<>();
        if(root==null) return ret;
        nodeS.push(root);
        while(!nodeS.isEmpty()){
            TreeNode temp = nodeS.pop();
            ret.add(temp.val);
            if(temp.left!=null) nodeS.push(temp.left);
            if(temp.right!=null) nodeS.push(temp.right);
        }
        Collections.reverse(ret);//use collection.reverse to reverse the list
        return ret;
    }
}