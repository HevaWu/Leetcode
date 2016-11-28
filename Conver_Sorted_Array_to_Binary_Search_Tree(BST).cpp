/*108. Convert Sorted Array to Binary Search Tree  QuestionEditorial Solution  My Submissions
Total Accepted: 86400
Total Submissions: 222711
Difficulty: Medium
Given an array where elements are sorted in ascending order, convert it to a height balanced BST.

Subscribe to see which companies asked this question*/



/*same to question "conver sorted list to binary search tree"*/
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
    int n = 0;
    vector<int> numsArray;
public:
    TreeNode* sortedArrayToBST(vector<int>& nums) {
        if(nums.size()==0) return NULL;
        numsArray = nums;
        cout << nums.size();
        return buildBST(0, nums.size()-1);
    }
    
    TreeNode* buildBST(int start, int end){
        if(start>end) return NULL;
        
        int mid = (start+end)/2;
        TreeNode* left = buildBST(start, mid-1);
        
        TreeNode* ret = new TreeNode(numsArray[n]);
        ret->left = left;
        n++;
             
        TreeNode* right = buildBST(mid+1, end);
        ret->right = right;
             
        return ret;
        
        // if(n<numsArray.size()){  //add the limit to avoid over the nums
        //      TreeNode* ret = new TreeNode(numsArray[n]);
        //      ret->left = left;
        //      n++;
             
        //      TreeNode* right = buildBST(mid+1, end);
        //      ret->right = right;
             
        //      return ret;
        // }
      
        // return NULL;
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
    private int n = 0;
    
    public TreeNode sortedArrayToBST(int[] nums) {
        if(nums.length==0) return null;
        return buildBST(0, nums.length-1, nums);
    }
    
    public TreeNode buildBST(int start, int end, int[] nums){
        if(start>end) return null;
        
        int mid = (start+end)/2;
        TreeNode left = buildBST(start, mid-1, nums);
        
        TreeNode ret = new TreeNode(nums[n]);
        ret.left = left;
        n++;
        
        TreeNode right = buildBST(mid+1, end, nums);
        ret.right = right;
        
        return ret;
    }
}