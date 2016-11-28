/*109. Convert Sorted List to Binary Search Tree  QuestionEditorial Solution  My Submissions
Total Accepted: 79624
Total Submissions: 252088
Difficulty: Medium
Given a singly linked list where elements are sorted in ascending order, convert it to a height balanced BST.

Subscribe to see which companies asked this question*/



/*divide the list into two part, the left part insert as the left node of the tree
the right part insert as the right node of the tree*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
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
    ListNode* node;
public:
    TreeNode* sortedListToBST(ListNode* head) {
        if(!head) return NULL;
        
        int listSize = 0;
        ListNode* temp = head;
        node = head;
        while(temp){
            listSize++;
            temp = temp->next;
        }
        
        return buildBST(0, listSize-1);
    }
    
    TreeNode* buildBST(int start, int end){
        if(start>end) return NULL;
        
        int mid = (start+end)/2;
        TreeNode* left = buildBST(start, mid-1);
        
        TreeNode* ret = new TreeNode(node->val);
        ret->left = left;
        node = node->next;
        
        TreeNode* right = buildBST(mid+1, end);
        ret->right = right;
        
        return ret;
    }
};





/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
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
    private ListNode node;
    
    public TreeNode sortedListToBST(ListNode head) {
        if(head==null) return null;
        ListNode temp = head;
        node = head;
        int listSize = 0;
        while(temp!=null){
            listSize++;
            temp = temp.next;
        }
        return buildBST(0, listSize-1);
    }
    
    public TreeNode buildBST(int start, int end){
        if(start>end) return null;
        
        int mid = (start+end)/2;
        TreeNode left = buildBST(start, mid-1);
        
        TreeNode ret = new TreeNode(node.val);
        ret.left = left;
        node = node.next;
        
        TreeNode right = buildBST(mid+1, end);
        ret.right = right;
        
        return ret;
    }
}