/*
Given a binary tree, find its minimum depth.

The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
*/


/*BFS*/
/*recursive search the depth of leftnode and rightnode
If the depth return 0, means this is a leaf node
finally, return the min of lt and rt, since this need to find the minDepth of the tree*/

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
    int minDepth(TreeNode* root) {
        if(!root) return 0;
        int lt = minDepth(root->left);
        int rt = minDepth(root->right);
        if(lt==0 || rt==0) return 1+lt+rt; //need to sepearate thinking about the left node and the right node
        else return 1+min(lt,rt);
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
    public int minDepth(TreeNode root) {
        if(root == null){
            return 0;
        }
        
        int lt = minDepth(root.left);
        int rt = minDepth(root.right);
        
        if(lt == 0 || rt == 0){
            return 1+lt+rt;
        } else{
            return 1+Math.min(lt,rt);
        }
    }
}
