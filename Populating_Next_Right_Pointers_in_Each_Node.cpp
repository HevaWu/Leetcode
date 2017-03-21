/*116. Populating Next Right Pointers in Each Node Add to List
Description  Submission  Solutions
Total Accepted: 121101
Total Submissions: 328195
Difficulty: Medium
Contributors: Admin
Given a binary tree

    struct TreeLinkNode {
      TreeLinkNode *left;
      TreeLinkNode *right;
      TreeLinkNode *next;
    }
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

Initially, all next pointers are set to NULL.

Note:

You may only use constant extra space.
You may assume that it is a perfect binary tree (ie, all leaves are at the same level, and every parent has two children).
For example,
Given the following perfect binary tree,
         1
       /  \
      2    3
     / \  / \
    4  5  6  7
After calling your function, the tree should look like:
         1 -> NULL
       /  \
      2 -> 3 -> NULL
     / \  / \
    4->5->6->7 -> NULL
Hide Company Tags Microsoft
Hide Tags Tree Depth-first Search
Hide Similar Problems (M) Populating Next Right Pointers in Each Node II (M) Binary Tree Right Side View
*/



/*from left to right, get the cur->next
if cur->next exist, cur->right->next = cur->next->left
if not exist, jump out the while(cur->next) loop
then search the next layer of the tree*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for binary tree with next pointer.
 * struct TreeLinkNode {
 *  int val;
 *  TreeLinkNode *left, *right, *next;
 *  TreeLinkNode(int x) : val(x), left(NULL), right(NULL), next(NULL) {}
 * };
 */
class Solution {
public:
    void connect(TreeLinkNode *root) {
        if(!root) return;
        TreeLinkNode *pre = root;
        TreeLinkNode *cur = NULL;
        while(pre->left){
            cur = pre;
            while(cur){
                cur->left->next = cur->right;
                if(cur->next) cur->right->next = cur->next->left;
                cur = cur->next;
            }
            pre = pre->left;
        }
    }
};




/*
DFS (0 ms/ 14 test)
search the pre.left
while it exist, find pre.next pointer
from left to right, get the cur->next
if cur->next exist, cur->right->next = cur->next->left
if not exist, jump out the while(cur->next) loop
then search the next layer of the tree*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for binary tree with next pointer.
 * public class TreeLinkNode {
 *     int val;
 *     TreeLinkNode left, right, next;
 *     TreeLinkNode(int x) { val = x; }
 * }
 */
public class Solution {
    public void connect(TreeLinkNode root) {
        if(root == null) return;
        TreeLinkNode pre = root;
        TreeLinkNode cur = null;
        while(pre.left != null){
            cur = pre;
            while(cur != null){
                cur.left.next = cur.right;
                if(cur.next != null) cur.right.next = cur.next.left;
                cur = cur.next;
            }
            pre = pre.left;
        }
    }
}
