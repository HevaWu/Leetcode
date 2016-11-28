/*
Given a binary tree, return the bottom-up level order traversal of its nodes' values. (ie, from left to right, level by level from leaf to root).

For example:
Given binary tree {3,9,20,#,#,15,7},
    3
   / \
  9  20
    /  \
   15   7
return its bottom-up level order traversal as:
[
  [15,7],
  [9,20],
  [3]
]
confused what "{1,#,2,3}" means? > read more on how binary tree is serialized on OJ.
*/

/*BFS*/
/*Method 1*/
/*recursively push the node,  pre-order traversal the tree
first push the root, then pusht the left child, then the right child
finally reverse the vector, and return it*/
/*Method 2
first push the left child, and right child
then push the root, remember ret.get(ret.size()-level-1).add(root.val)*/

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
    vector<vector<int> > levelTraversal;
public:
    vector<vector<int>> levelOrderBottom(TreeNode* root) {
        OrderTraversal(root, 0);
        reverse(levelTraversal.begin(), levelTraversal.end());
        return levelTraversal;
    }
    
    void OrderTraversal(TreeNode* root, int level)
    {
        if(!root) return;
        if(levelTraversal.size() == level) levelTraversal.push_back(vector<int>());
        levelTraversal[level].push_back(root->val);
        if(root->left) OrderTraversal(root->left, level+1);
        if(root->right) OrderTraversal(root->right, level+1);
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
    public List<List<Integer>> levelOrderBottom(TreeNode root) {
        List<List<Integer> > ret = new LinkedList<List<Integer>>();
        OrderTraversal(ret, root, 0);
        return ret;
    }
    
    public void OrderTraversal(List<List<Integer>> ret, TreeNode root, int level){
        if(root == null){
            return;
        }
        if(ret.size() == level){
            ret.add(0, new LinkedList<Integer>());
        }
        
        if(root.left != null) OrderTraversal(ret, root.left, level+1);
        if(root.right != null) OrderTraversal(ret, root.right, level+1);
        
        ret.get(ret.size()-level-1).add(root.val);
    }
}