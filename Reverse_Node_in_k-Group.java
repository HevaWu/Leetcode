/*25. Reverse Nodes in k-Group Add to List
Description  Submission  Solutions
Total Accepted: 85005
Total Submissions: 283101
Difficulty: Hard
Contributors: Admin
Given a linked list, reverse the nodes of a linked list k at a time and return its modified list.

k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes in the end should remain as it is.

You may not alter the values in the nodes, only nodes itself may be changed.

Only constant memory is allowed.

For example,
Given this linked list: 1->2->3->4->5

For k = 2, you should return: 2->1->4->3->5

For k = 3, you should return: 3->2->1->4->5

Hide Company Tags Microsoft Facebook
Hide Tags Linked List
Hide Similar Problems (M) Swap Nodes in Pairs
 */






/*
Solution 2 faster than Solution 1

Solution 1: recursive 12 ms/ 81 test
recursive find the next k element
then reverse the list
    ListNode nextNode = head.next;
    head.next = cur;
    cur = head;
    head = nextNode;
then head = cur;
return head

Solution 2: iterative.  9 ms / 81 test
     a linked list:
     * 0->1->2->3->4->5->6
     * |           |
     * start       end
     * after call start = reverse(start, end)
     *
     * 0->3->2->1->4->5->6
     *          |  |
     *      start end
     * @return the reversed list's 'start' node, which is the precedence of node end
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1: recursive
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        if(head==null || k==0) return head;

        ListNode cur = head;
        int index = 0;
        while(cur != null && index != k){
            //find the k+1 node
            cur = cur.next;
            index++;
        }

        if(index==k){
            //if there is k+1 node, find if there is a next k node in the list
            //if there is, reverse it
            cur = reverseKGroup(cur, k);

            //reverse current k element
            while(index-- > 0){
                ListNode nextNode = head.next;
                head.next = cur;
                cur = head;
                head = nextNode;
            }
            head = cur; //remember update the head
        }
        return head;
    }
}



//Solution 2: iterative
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseKGroup(ListNode head, int k) {
        if(head==null || k==0) return head;

        ListNode pre = new ListNode(0);
        pre.next = head;

        ListNode cur = pre;

        int index = 1; //help count the k element
        while(head != null){
            if(index % k == 0){
                //reverse k element
                //remember the end node is head.next
                cur = reverseList(cur, head.next);
                //update start
                head = cur.next;
            } else {
                head = head.next;
            }
            index++;
        }
        return pre.next;
    }

    //reverse the list from start.next to end.pre
    // 0->1->2->3->4->5
    // |           |
    // start       end
    // after reverse:
    // 0->3->2->1 -> 4->5
    //          |    |
    //          cur end
    public ListNode reverseList(ListNode start, ListNode end){
        ListNode pre = start;
        ListNode cur = start.next;

        while(cur.next != end){
            ListNode nextNode = cur.next;
            cur.next = nextNode.next;
            nextNode.next = pre.next;
            pre.next = nextNode;
        }
        return cur;
    }
}
