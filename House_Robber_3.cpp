/*337. House Robber III  QuestionEditorial Solution  My Submissions
Total Accepted: 21466
Total Submissions: 54509
Difficulty: Medium
The thief has found himself a new place for his thievery again. There is only one entrance to this area, called the "root." Besides the root, each house has one and only one parent house. After a tour, the smart thief realized that "all houses in this place forms a binary tree". It will automatically contact the police if two directly-linked houses were broken into on the same night.

Determine the maximum amount of money the thief can rob tonight without alerting the police.

Example 1:
     3
    / \
   2   3
    \   \ 
     3   1
Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
Example 2:
     3
    / \
   4   5
  / \   \ 
 1   3   1
Maximum amount of money the thief can rob = 4 + 5 = 9.
Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.*/




/*DFS /DP
maintain two scenarios for each tree root
the first element of which denotes the maximum amount of money that can be robbed if "root" not robbed
the second element signifies the maximum amount of money robbed if root is robbed
recursively rob the root.left and root.right
for each root, 
the first element, we sum up the larger elements of rob(root.left) and rob(root.right)
the second element , we add the root*/

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
    int rob(TreeNode* root) {
        vector<int> ret = robHouse(root);
        return max(ret[0], ret[1]);
    }
    
    vector<int> robHouse(TreeNode* root){
        if(!root){
            return vector<int>(2);
        }
        
        vector<int> left = robHouse(root->left);
        vector<int> right = robHouse(root->right);
        
        vector<int> ret(2);
        ret[0] = max(left[0], left[1]) + max(right[0], right[1]);
        ret[1] = root->val + left[0] + right[0];
        
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
    public int rob(TreeNode root) {
        int[] ret = robHouse(root);
        return Math.max(ret[0], ret[1]);
    }
    
    public int[] robHouse(TreeNode root){
        if(root == null){
            return new int[2];
        }
        
        int[] left = robHouse(root.left);
        int[] right = robHouse(root.right);
        
        int[] ret = new int[2];
        ret[0] = Math.max(left[0],left[1]) + Math.max(right[0], right[1]);
        ret[1] = root.val + left[0] + right[0];
        
        return ret;
    }
}