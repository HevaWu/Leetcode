/*1117. Populating Next Right Pointers in Each Node II Add to List
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




/*
DFS
seperately consider the left node and right node
using two more pointers to control the next node
head pointer point to the first node in each layer
pre pointer control the node point to the next node
if left node exist, pre.next = cur.left
if right node exist, pre.next = cur.right

Solution 2 faster than solution 1

Solution 1:
two while loop, waste time
compare too many times

Solution 2: (1 ms/ 61 test S)
init head as a fake node with init value
each time, only need to get the head.next element is the next level head value
init pre = head
each time move and change pre node to change the next element
if cur == null move to the next level(head.next)
    update pre = head, cur = head.next, head.next = null
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 2
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

        TreeLinkNode cur = root;
        TreeLinkNode head = new TreeLinkNode(0); //init a fake head
        TreeLinkNode pre = head;
        while(cur != null){
            if(cur.left != null){
                pre.next = cur.left;
                pre = pre.next;
            }
            if(cur.right != null){
                pre.next = cur.right;
                pre = pre.next;
            }
            cur = cur.next;
            //go to the next level
            if(cur == null){
                pre = head;
                cur = head.next;
                head.next = null;
            }
        }
    }
}





//Solution 1
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
        TreeLinkNode cur = root;
        TreeLinkNode head = null;
        TreeLinkNode pre = null;

        while(cur != null){
            while(cur != null){//iterative current level
                if(cur.left != null){
                    if(pre != null){
                        pre.next = cur.left;
                    } else {
                        head = cur.left;
                    }
                    pre = cur.left;
                }

                if(cur.right != null){
                    if(pre != null){
                        pre.next = cur.right;
                    } else{
                        head = cur.right;
                    }
                    pre = cur.right;
                }
                //move to next node
                cur = cur.next;
            }

            //move to next level
            cur = head;
            head = null;
            pre = null;
        }
    }
}
