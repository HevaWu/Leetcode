/*102. Binary Tree Level Order Traversal Add to List
Description  Submission  Solutions
Total Accepted: 156005
Total Submissions: 413098
Difficulty: Medium
Contributors: Admin
Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its level order traversal as:
[
  [3],
  [9,20],
  [15,7]
]
Hide Company Tags LinkedIn Facebook Amazon Microsoft Apple Bloomberg
Hide Tags Tree Breadth-first Search
Hide Similar Problems (M) Binary Tree Zigzag Level Order Traversal (E) Binary Tree Level Order Traversal II (E) Minimum Depth of Binary Tree (M) Binary Tree Vertical Order Traversal
*/






/*BFS*/
/*recursively push the node in pre-order*/

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
    private:
    vector<vector<int>> orderTraversal;
public:
    vector<vector<int>> levelOrder(TreeNode* root) {
        LevelOrder(root,0);
        return orderTraversal;
    }

    void LevelOrder(TreeNode* root, int level)
    {
        if(!root) return;
        if(orderTraversal.size() == level) orderTraversal.push_back(vector<int>() );

        orderTraversal[level].push_back(root->val);
        LevelOrder(root->left, level+1);
        LevelOrder(root->right, level+1);
    }

};






/*
BFS
recursively push the node in pre-order
use "level" variable to control which list it should be in
 */

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
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> ret = new LinkedList<>();
        Order(ret, root, 0);
        return ret;
    }

    public void Order(List<List<Integer> > ret, TreeNode root, int level){
        if(root == null){
            return;
        }

        if(ret.size() == level){
            ret.add(new LinkedList<>());
        }

        ret.get(level).add(root.val);
        Order(ret, root.left, level+1);
        Order(ret, root.right, level+1);
    }
}
