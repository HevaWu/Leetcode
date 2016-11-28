/*270. Closest Binary Search Tree Value   QuestionEditorial Solution  My Submissions
Total Accepted: 20557 Total Submissions: 55860 Difficulty: Easy Contributors: Admin
Given a non-empty binary search tree and a target value, find the value in the BST that is closest to the target.

Note:
Given target value is a floating point.
You are guaranteed to have only one unique value in the BST that is closest to the target.
Hide Company Tags Microsoft Google Snapchat
Hide Tags Tree Binary Search
Hide Similar Problems (M) Count Complete Tree Nodes (H) Closest Binary Search Tree Value II
*/



/*
if current root.value < target, root = root.right
if current root.value > target, root = root.left 
recursively do function
or using while in function*/

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
    int closestValue(TreeNode* root, double target) {
        TreeNode* next = target>root->val ? root->right : root->left;
        if(next == NULL) return root->val;
        int temp = closestValue(next, target);
        return abs(root->val - target)<abs(temp-target) ? root->val : temp;
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
    public int closestValue(TreeNode root, double target) {
        //recursively do function
        TreeNode next = target<root.val ? root.left : root.right;
        if(next==null) return root.val;
        int temp = closestValue(next, target);
        return Math.abs(root.val-target) < Math.abs(temp-target) ? root.val : temp;
    }
}



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
    public int closestValue(TreeNode root, double target) {
        //while do function
        int ret = root.val;
        while(root!=null){
            if(Math.abs(root.val-target) < Math.abs(ret-target)){
                ret = root.val;
            }
            root = target<root.val ? root.left : root.right;
        }
        return ret;
    }
}