/*230. Kth Smallest Element in a BST  QuestionEditorial Solution  My Submissions
Total Accepted: 61252
Total Submissions: 153348
Difficulty: Medium
Given a binary search tree, write a function kthSmallest to find the kth smallest element in it.

Note: 
You may assume k is always valid, 1 ≤ k ≤ BST's total elements.

Follow up:
What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?

Hint:

Try to utilize the property of a BST.
What if you could modify the BST node's structure?
The optimal runtime complexity is O(height of BST).
Credits:
Special thanks to @ts for adding this problem and creating all test cases.

Hide Company Tags Bloomberg Uber Google
Hide Tags Binary Search Tree
Hide Similar Problems (M) Binary Tree Inorder Traversal
*/



/*dfs   O(nlog(n))
search from the left child of the tree, since this tree is BST, if k > countnode(root.left)+1, the return node should be at the right side
otherwise, it should be at the left side*/

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
    int kthSmallest(TreeNode* root, int k) {
        int count = countNode(root->left);
        if(k<=count){
            // cout << count << "left ";
            return kthSmallest(root->left, k);
        } else if(k>count+1){
            // cout << count << "right ";
            return kthSmallest(root->right, k-1-count);  //remember (k-1-count)
        }
        
        return root->val;
    }
    
    int countNode(TreeNode* node){
        if(node==NULL) return 0;
        return 1 + countNode(node->left) + countNode(node->right);
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
    public int kthSmallest(TreeNode root, int k) {
        int count = countNode(root.left);
        
        if(k<=count){
            // System.out.println(count  + "left ");
            return kthSmallest(root.left, k);
        } else if(k > count+1){
            // System.out.println(count  + "right ");
            return kthSmallest(root.right, k-1-count);
        }
        
        // System.out.println(count  + "return ");
        return root.val;
    }
    
    public int countNode(TreeNode node){
        if(node==null) return 0;
        return 1+countNode(node.left) + countNode(node.right);
    }
}