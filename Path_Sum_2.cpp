/*113. Path Sum II  QuestionEditorial Solution  My Submissions
Total Accepted: 92402
Total Submissions: 311963
Difficulty: Medium
Given a binary tree and a sum, find all root-to-leaf paths where each path's sum equals the given sum.

For example:
Given the below binary tree and sum = 22,
              5
             / \
            4   8
           /   / \
          11  13  4
         /  \    / \
        7    2  5   1
return
[
   [5,4,11,2],
   [5,8,4,5]
]
Subscribe to see which companies asked this question*/



/*backtracking
from the root to the leaf node, each time sum-node.val, if the end node.val == sum, then we push this path into the ret
*/

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
    vector<vector<int>> pathSum(TreeNode* root, int sum) {
        vector<vector<int> > ret;
        vector<int> path;
        findPathSum(root, sum, path, ret);
        return ret;
    }
    
    void findPathSum(TreeNode* node, int sum, vector<int>& path, vector<vector<int> >& ret){
        if(!node) return;
        path.push_back(node->val);
        if(!(node->left) && !(node->right) && sum==node->val){
            ret.push_back(path);
        }
        
        findPathSum(node->left, sum-node->val, path, ret);
        findPathSum(node->right, sum-node->val, path, ret);
        path.pop_back(); //pop the last element
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
    public List<List<Integer>> pathSum(TreeNode root, int sum) {
        List<List<Integer> > ret = new LinkedList<>();
        List<Integer> path = new LinkedList<>();
        findPathSum(root, sum, path, ret);
        return ret;
    }
    
    public void findPathSum(TreeNode root, int sum, List<Integer> path, List<List<Integer>> ret){
        if(root==null) return;
        path.add(root.val);
        if(root.left==null && root.right==null && sum==root.val){
            ret.add(new LinkedList(path));  //add the new LinkedList(path)
        }
        findPathSum(root.left, sum-root.val, path, ret);
        findPathSum(root.right, sum-root.val, path, ret);
        path.remove(path.size()-1);
    }
}