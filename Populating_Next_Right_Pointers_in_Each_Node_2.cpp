/*
1117. Populating Next Right Pointers in Each Node II Add to List
Description  Submission  Solutions
Total Accepted: 86863
Total Submissions: 258578
Difficulty: Medium
Contributors: Admin
Follow up for problem "Populating Next Right Pointers in Each Node".

What if the given tree could be any binary tree? Would your previous solution still work?

Note:

You may only use constant extra space.
For example,
Given the following binary tree,
         1
       /  \
      2    3
     / \    \
    4   5    7
After calling your function, the tree should look like:
         1 -> NULL
       /  \
      2 -> 3 -> NULL
     / \    \
    4-> 5 -> 7 -> NULL
Hide Company Tags Microsoft Bloomberg Facebook
Hide Tags Tree Depth-first Search
Hide Similar Problems (M) Populating Next Right Pointers in Each Node
*/



/*seperately consider the left node and right node
using two more pointers to control the next node
head pointer point to the first node in each layer
pre pointer control the node point to the next node
if left node exist, pre.next = cur.left
if right node exist, pre.next = cur.right*/

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
        TreeLinkNode *cur = root;
        TreeLinkNode *head = NULL;
        TreeLinkNode *pre = NULL;

        while(cur){
            while(cur){
                if(cur->left){
                    if(pre){
                        pre->next = cur->left;
                    } else {
                        head = cur->left;
                    }
                    pre = cur->left;
                }

                if(cur->right){
                    if(pre){
                        pre->next = cur->right;
                    } else {
                        head = cur->right;
                    }
                    pre = cur->right;
                }

                cur = cur->next;
            }

            cur = head;
            head = NULL;
            pre = NULL;
        }
    }
};
