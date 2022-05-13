/*
Given a binary tree

struct Node {
  int val;
  Node *left;
  Node *right;
  Node *next;
}
Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL.

Initially, all next pointers are set to NULL.



Follow up:

You may only use constant extra space.
Recursive approach is fine, you may assume implicit stack space does not count as extra space for this problem.


Example 1:



Input: root = [1,2,3,4,5,null,7]
Output: [1,#,2,3,#,4,5,7,#]
Explanation: Given the above binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.


Constraints:

The number of nodes in the given tree is less than 6000.
-100 <= node.val <= 100
*/

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
