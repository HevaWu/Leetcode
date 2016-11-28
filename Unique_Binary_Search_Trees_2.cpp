/*95. Unique Binary Search Trees II  QuestionEditorial Solution  My Submissions
Total Accepted: 63260
Total Submissions: 212899
Difficulty: Medium
Given an integer n, generate all structurally unique BST's (binary search trees) that store values 1...n.

For example,
Given n = 3, your program should return all 5 unique BST's shown below.

   1         3     3      2      1
    \       /     /      / \      \
     3     2     1      1   3      2
    /     /       \                 \
   2     1         2                 3
Subscribe to see which companies asked this question*/


/*DP*/
/*1...n is the in-order traversal for BST
pick i-th node as the root, the elements i to (i-1) should be the left node
the element (i+1) to n should be the right node
recursively do this
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
    vector<TreeNode*> generateTrees(int n) {
        if(n==0){
            return vector<TreeNode*>();
        }
        return buildTree(1, n);
    }
    
    vector<TreeNode*> buildTree(int start, int end){
        vector<TreeNode*> ret;
        if(start>end){
            ret.push_back(NULL);
        }
        
        vector<TreeNode*> left, right;
        for(int i = start; i <= end; ++i){
            left = buildTree(start, i-1);
            right = buildTree(i+1, end);
            for(TreeNode* l:left){
                for(TreeNode* r:right){
                    TreeNode* root = new TreeNode(i);
                    root->left = l;
                    root->right = r;
                    ret.push_back(root);
                }
            }
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
    public List<TreeNode> generateTrees(int n) {
        if(n==0){
            return (new LinkedList<TreeNode>());
        }
        return buildTree(1,n);
    }
    
    public List<TreeNode> buildTree(int start, int end){
        List<TreeNode> ret = new LinkedList<>();
        if(start > end){
            ret.add(null);
        }
        
        for(int i = start; i <= end; ++i){
            List<TreeNode> left = buildTree(start, i-1);
            List<TreeNode> right = buildTree(i+1, end);
            for(TreeNode l:left){
                for(TreeNode r:right){
                    TreeNode root = new TreeNode(i);
                    root.left = l;
                    root.right = r;
                    ret.add(root);
                }
            }
        }
        
        return ret;
    }
}